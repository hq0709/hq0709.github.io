# Geo-Neus中renderer代码的具体解读

## get_psnr
```python
   def get_psnr(img1, img2, normalize_rgb=False):
    if normalize_rgb: # [-1,1] --> [0,1]
        img1 = (img1 + 1.) / 2.
        img2 = (img2 + 1. ) / 2.

    mse = torch.mean((img1 - img2) ** 2)
    psnr = -10. * torch.log(mse) / torch.log(torch.Tensor([10.]).cuda())

    return psnr
```
- 这个函数计算两张图像img1和img2的峰值信噪比（PSNR）。如果normalize_rgb标志设置为True，函数将通过将范围从[-1,1]转换为[0,1]来标准化图像。然后，函数通过计算两张图像的像素值之差的平方平均值来计算两幅图像之间的均方误差（MSE）。然后使用MSE和最大可能像素值（对于8位图像为255）的log base 10计算PSNR。返回最终的PSNR值。

## extract_fields
```python
  def extract_fields(bound_min, bound_max, resolution, query_func):
    N = 64
    X = torch.linspace(bound_min[0], bound_max[0], resolution).split(N)
    Y = torch.linspace(bound_min[1], bound_max[1], resolution).split(N)
    Z = torch.linspace(bound_min[2], bound_max[2], resolution).split(N)

    u = np.zeros([resolution, resolution, resolution], dtype=np.float32)
    with torch.no_grad():
        for xi, xs in enumerate(X):
            for yi, ys in enumerate(Y):
                for zi, zs in enumerate(Z):
                    xx, yy, zz = torch.meshgrid(xs, ys, zs)
                    pts = torch.cat([xx.reshape(-1, 1), yy.reshape(-1, 1), zz.reshape(-1, 1)], dim=-1)
                    val = query_func(pts).reshape(len(xs), len(ys), len(zs)).detach().cpu().numpy()
                    u[xi * N: xi * N + len(xs), yi * N: yi * N + len(ys), zi * N: zi * N + len(zs)] = val
    return u
  ```

- 这个函数通过在由边界框坐标和分辨率定义的网格上的点上调用查询函数来提取字段。该函数首先将网格分割成大小为N = 64的块，然后使用torch.linspace()函数生成一组线性间隔值，用于x，y和z维。然后，函数使用嵌套for循环遍历网格的块，对于每个块，它使用该块中的点调用查询函数，并将结果存储在u数组中。
- 这个函数使用numpy库创建数组，Pytorch创建点网格并将它们分块处理。

## extract_geometry
```python
def extract_geometry(bound_min, bound_max, resolution, threshold, query_func):
    print('threshold: {}'.format(threshold))
    u = extract_fields(bound_min, bound_max, resolution, query_func)
    vertices, triangles = mcubes.marching_cubes(u, threshold)
    b_max_np = bound_max.detach().cpu().numpy()
    b_min_np = bound_min.detach().cpu().numpy()

    vertices = vertices / (resolution - 1.0) * (b_max_np - b_min_np)[None, :] + b_min_np[None, :]
    return vertices, triangles
```

- 这个函数通过使用Marching Cubes算法来从3D场中提取几何体。它接受四个参数：bound_min和bound_max是3D空间的下限和上限，resolution是每个维度上的点数，threshold是Marching Cubes算法用来确定场中哪些点被认为是几何体的一部分的值，query_func是返回场在一组点上的值的函数。
- 该函数首先调用extract_fields()函数获取一个3D场，然后将场和阈值值传递给mcubes库中的marching_cubes()函数，该函数返回提取的几何体的顶点和三角形。然后，缩放并偏移顶点以匹配由bound_min和bound_max指定的边界框。
- 该函数使用Pytorch处理数据，使用mcubes库提取几何体，并使用Pytorch将张量转换为numpy数组。

## sample_pdf
```python
def sample_pdf(bins, weights, n_samples, det=False):
    # This implementation is from NeRF
    # Get pdf
    weights = weights + 1e-5  # prevent nans
    pdf = weights / torch.sum(weights, -1, keepdim=True)
    cdf = torch.cumsum(pdf, -1)
    cdf = torch.cat([torch.zeros_like(cdf[..., :1]), cdf], -1)
    # Take uniform samples
    if det:
        u = torch.linspace(0. + 0.5 / n_samples, 1. - 0.5 / n_samples, steps=n_samples)
        u = u.expand(list(cdf.shape[:-1]) + [n_samples])
    else:
        u = torch.rand(list(cdf.shape[:-1]) + [n_samples])

    # Invert CDF
    u = u.contiguous()
    inds = torch.searchsorted(cdf, u, right=True)
    below = torch.max(torch.zeros_like(inds - 1), inds - 1)
    above = torch.min((cdf.shape[-1] - 1) * torch.ones_like(inds), inds)
    inds_g = torch.stack([below, above], -1)  # (batch, N_samples, 2)

    matched_shape = [inds_g.shape[0], inds_g.shape[1], cdf.shape[-1]]
    cdf_g = torch.gather(cdf.unsqueeze(1).expand(matched_shape), 2, inds_g)
    bins_g = torch.gather(bins.unsqueeze(1).expand(matched_shape), 2, inds_g)

    denom = (cdf_g[..., 1] - cdf_g[..., 0])
    denom = torch.where(denom < 1e-5, torch.ones_like(denom), denom)
    t = (u - cdf_g[..., 0]) / denom
    samples = bins_g[..., 0] + t * (bins_g[..., 1] - bins_g[..., 0])

    return samples
```

- 这个函数用于采样一维的概率密度函数（PDF）。
- 函数的输入参数有：
  - bins：一个 tensor，表示每个 bin 的中心点。
  - weights：一个 tensor，表示每个 bin 的权重。
  - n_samples：一个整数，表示采样样本数。
  - det：一个布尔值，表示是否为确定性采样（即采样点是等间隔分布的）。 
- 这个函数首先使用权重对每个 bin 计算出概率密度函数（PDF），然后使用累积分布函数（CDF）对每个 bin 计算出累积概率，之后根据输入参数 det 来决定采样点是等间隔分布的还是随机分布的。最后，函数通过反演 CDF 来获取采样点在哪两个 bin 之间，然后使用线性插值计算出采样点的值。最后返回计算出来的样本。

## class GeoNeuSRenderer

### render_core_outside
```python
def render_core_outside(self, rays_o, rays_d, z_vals, sample_dist, nerf, background_rgb=None):
        """
        Render background
        """
        batch_size, n_samples = z_vals.shape

        # Section length
        dists = z_vals[..., 1:] - z_vals[..., :-1]
        dists = torch.cat([dists, torch.Tensor([sample_dist]).expand(dists[..., :1].shape)], -1)
        mid_z_vals = z_vals + dists * 0.5

        # Section midpoints
        pts = rays_o[:, None, :] + rays_d[:, None, :] * mid_z_vals[..., :, None]  # batch_size, n_samples, 3

        dis_to_center = torch.linalg.norm(pts, ord=2, dim=-1, keepdim=True).clip(1.0, 1e10)
        pts = torch.cat([pts / dis_to_center, 1.0 / dis_to_center], dim=-1)       # batch_size, n_samples, 4

        dirs = rays_d[:, None, :].expand(batch_size, n_samples, 3)

        pts = pts.reshape(-1, 3 + int(self.n_outside > 0))
        dirs = dirs.reshape(-1, 3)

        density, sampled_color = nerf(pts, dirs)
        alpha = 1.0 - torch.exp(-F.softplus(density.reshape(batch_size, n_samples)) * dists)

        alpha = alpha.reshape(batch_size, n_samples)
        weights = alpha * torch.cumprod(torch.cat([torch.ones([batch_size, 1]), 1. - alpha + 1e-7], -1), -1)[:, :-1]
        sampled_color = sampled_color.reshape(batch_size, n_samples, 3)
        color = (weights[:, :, None] * sampled_color).sum(dim=1)
        if background_rgb is not None:
            color = color + background_rgb * (1.0 - weights.sum(dim=-1, keepdim=True))

        return {
            'color': color,
            'sampled_color': sampled_color,
            'alpha': alpha,
            'weights': weights,
        }   
```
- 这是一个用于渲染三维图像的函数。它输入的参数有：
  - rays_o：一个 tensor，表示射线的起点。
  - rays_d：一个 tensor，表示射线的方向。
  - z_vals：一个 tensor，表示射线经过的每个层的深度值。
  - sample_dist：一个浮点数，表示采样距离。
  - nerf：一个函数，用于计算密度和颜色。
  - background_rgb：一个三元组，表示背景颜色。
- 这个函数首先计算出射线经过的每个层之间的距离，然后计算出这些层的中心点。之后使用 nerf 函数计算出密度和颜色。之后计算出透明度并计算出权重。最后，函数通过将采样颜色与权重相乘并求和得到最终颜色。如果背景颜色不为空，函数将最终颜色加上背景颜色。最后返回一个字典，包含最终颜色，采样颜色，透明度和权重。

### up_sample
```python
def up_sample(self, rays_o, rays_d, z_vals, sdf, n_importance, inv_s):
        """
        Up sampling give a fixed inv_s
        """
        batch_size, n_samples = z_vals.shape
        pts = rays_o[:, None, :] + rays_d[:, None, :] * z_vals[..., :, None]  # n_rays, n_samples, 3
        radius = torch.linalg.norm(pts, ord=2, dim=-1, keepdim=False)
        inside_sphere = (radius[:, :-1] < 1.0) | (radius[:, 1:] < 1.0)
        sdf = sdf.reshape(batch_size, n_samples)
        prev_sdf, next_sdf = sdf[:, :-1], sdf[:, 1:]
        prev_z_vals, next_z_vals = z_vals[:, :-1], z_vals[:, 1:]
        mid_sdf = (prev_sdf + next_sdf) * 0.5
        cos_val = (next_sdf - prev_sdf) / (next_z_vals - prev_z_vals + 1e-5)

        # ----------------------------------------------------------------------------------------------------------
        # Use min value of [ cos, prev_cos ]
        # Though it makes the sampling (not rendering) a little bit biased, this strategy can make the sampling more
        # robust when meeting situations like below:
        #
        # SDF
        # ^
        # |\          -----x----...
        # | \        /
        # |  x      x
        # |---\----/-------------> 0 level
        # |    \  /
        # |     \/
        # |
        # ----------------------------------------------------------------------------------------------------------
        prev_cos_val = torch.cat([torch.zeros([batch_size, 1]), cos_val[:, :-1]], dim=-1)
        cos_val = torch.stack([prev_cos_val, cos_val], dim=-1)
        cos_val, _ = torch.min(cos_val, dim=-1, keepdim=False)
        cos_val = cos_val.clip(-1e3, 0.0) * inside_sphere

        dist = (next_z_vals - prev_z_vals)
        prev_esti_sdf = mid_sdf - cos_val * dist * 0.5
        next_esti_sdf = mid_sdf + cos_val * dist * 0.5
        prev_cdf = torch.sigmoid(prev_esti_sdf * inv_s)
        next_cdf = torch.sigmoid(next_esti_sdf * inv_s)
        alpha = (prev_cdf - next_cdf + 1e-5) / (prev_cdf + 1e-5)
        weights = alpha * torch.cumprod(
            torch.cat([torch.ones([batch_size, 1]), 1. - alpha + 1e-7], -1), -1)[:, :-1]

        z_samples = sample_pdf(z_vals, weights, n_importance, det=True).detach()
        return z_samples 
```

- 这是一个用于重采样三维图像的函数。它输入的参数有
  - rays_o：一个 tensor，表示射线的起点。
  - rays_d：一个 tensor，表示射线的方向。
  - z_vals：一个 tensor，表示射线经过的每个层的深度值。
  - sdf：一个 tensor，表示每个层的距离场。
  - n_importance：一个整数，表示重采样的样本数。
  - inv_s：一个浮点数，表示缩放因子。
- 这个函数首先计算出射线经过的每个层的点坐标。然后计算出当前层与下一层中点的距离场值，这个值被用来估计下一层距离场的值。之后计算出对于每个层之间的权重并使用 sample_pdf 函数进行重采样，最后返回重采样后的深度值。

### cat_z_vals
```python
def cat_z_vals(self, rays_o, rays_d, z_vals, new_z_vals, sdf, last=False):
        batch_size, n_samples = z_vals.shape
        _, n_importance = new_z_vals.shape
        pts = rays_o[:, None, :] + rays_d[:, None, :] * new_z_vals[..., :, None]
        

        z_vals = torch.cat([z_vals, new_z_vals], dim=-1)
        z_vals, index = torch.sort(z_vals, dim=-1)

        if not last:
            new_sdf = self.sdf_network.sdf(pts.reshape(-1, 3)).reshape(batch_size, n_importance)
            sdf = torch.cat([sdf, new_sdf], dim=-1)
            xx = torch.arange(batch_size)[:, None].expand(batch_size, n_samples + n_importance).reshape(-1)
            index = index.reshape(-1)
            sdf = sdf[(xx, index)].reshape(batch_size, n_samples + n_importance)

        return z_vals, sdf
```
- 这是一个用于将新的深度值和距离场值添加到已有深度值和距离场值上的函数。它输入的参数有：
  - rays_o：一个 tensor，表示射线的起点。
  - rays_d：一个 tensor，表示射线的方向。
  - z_vals：一个 tensor，表示已有的射线经过的每个层的深度值。
  - new_z_vals：一个 tensor，表示新的射线经过的每个层的深度值。
  - sdf：一个 tensor，表示已有的每个层的距离场。
  - last：一个布尔值，表示是否是最后一次添加。
- 这个函数首先将新的深度值和已有的深度值连接在一起，然后对深度值进行排序。如果 last 为 False，函数使用网络计算新的距离场值并将其与已有的距离场值连接在一起。最后，函数返回深度值和距离场值。
