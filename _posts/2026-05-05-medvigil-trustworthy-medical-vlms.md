---
layout: default
title: "MedVIGIL: Evaluating Trustworthy Medical VLMs Under Broken Visual Evidence"
navbar_name: Blog
date: 2026-05-05 00:00:00 -0400
excerpt: "MedVIGIL is a clinician-supervised benchmark for testing whether medical vision-language models fail safely when the visual evidence contract is broken."
---

<article class="synapse-post medvigil-post" markdown="1">

<section class="synapse-hero" markdown="1">
<div class="synapse-hero-header" markdown="1">
<p class="synapse-kicker">Research Note · Preprint under review</p>

# MedVIGIL: Evaluating Trustworthy Medical VLMs Under Broken Visual Evidence
</div>

<div class="synapse-hero-main" markdown="1">
<div class="synapse-hero-copy" markdown="1">
Medical VLMs are getting better at answering questions about images. But clinical trust requires something harder than fluent answering: a model should recognize when the visual evidence no longer supports an answer. **MedVIGIL** evaluates whether medical vision-language models can fail safely when the evidence contract is broken.

<div class="medvigil-contract" aria-label="MedVIGIL evidence contract">
  <div>
    <strong>Evidence intact</strong>
    <span>The image supports the clinical answer.</span>
  </div>
  <div>
    <strong>Evidence broken</strong>
    <span>The premise, region, or laterality no longer supports the answer.</span>
  </div>
  <div>
    <strong>Safe response</strong>
    <span>The model should refuse instead of filling the gap.</span>
  </div>
</div>

<div class="synapse-hero-actions">
  <a href="https://hq0709.github.io/MedVIGIL-page" target="_blank" rel="noopener">Project page</a>
  <a href="https://huggingface.co/datasets/jhq0709/MedVIGIL" target="_blank" rel="noopener">Dataset</a>
</div>
</div>

<div class="synapse-proof-panel" aria-label="MedVIGIL benchmark highlights">
  <div>
    <span>300</span>
    <strong>Clinician-supervised cases</strong>
    <p>Gold answers, refusal options, ROI boxes, and risk tiers are radiologist-authored.</p>
  </div>
  <div>
    <span>2,556</span>
    <strong>MCQ probes</strong>
    <p>Question perturbations expose whether models rely on evidence or language priors.</p>
  </div>
  <div>
    <span>+14.1</span>
    <strong>MCS headroom</strong>
    <p>Independent radiologist baseline over the strongest audited model in the report.</p>
  </div>
</div>
</div>
</section>

<section class="synapse-author-card medvigil-research-note" markdown="1">
<div class="synapse-author-label">About the research</div>
<div class="synapse-author-copy" markdown="1">
**MedVIGIL** is part of Hanqi Jiang's research on trustworthy medical AI. The project is supervised by radiologists and focuses on a practical question for medical AI safety: can a vision-language model detect when its visual evidence is missing, corrupted, misleading, or no longer sufficient?
</div>
</section>

<section class="synapse-thesis" markdown="1">
<p>Core thesis</p>

## Medical VLMs should be evaluated not only by whether they answer, but by whether they know when not to answer.

Most benchmarks reward the correct final answer on intact image-question pairs. MedVIGIL audits a different behavior: **safe abstention under broken visual evidence**.
</section>

<section class="medvigil-failure-strip" aria-label="MedVIGIL central failure mode">
  <div>
    <span>Clean input</span>
    <strong>Evidence contract holds</strong>
    <p>The image and question support a specific clinical answer.</p>
  </div>
  <div>
    <span>Evidence perturbation</span>
    <strong>The contract breaks</strong>
    <p>The ROI is masked, the premise is false, or the wording no longer matches the image.</p>
  </div>
  <div>
    <span>Model behavior</span>
    <strong>Silent failure vs. safe refusal</strong>
    <p>A trustworthy model should refuse when the requested evidence is unavailable.</p>
  </div>
</section>

<section class="synapse-section" markdown="1">
<p class="synapse-section-label">The problem</p>

## The dangerous case is not a wrong answer. It is a confident answer when the evidence is broken.

In medical VQA, a model can appear competent when the image and question are clean. But real clinical workflows contain missing regions, ambiguous prompts, false premises, laterality changes, and image-question mismatches.

> The model should not answer from memory when the image evidence is gone.

MedVIGIL turns this intuition into an audit. It asks whether a model can distinguish answerable visual evidence from broken evidence and choose the doctor-defined refusal option when appropriate.
</section>

<section class="synapse-mechanism medvigil-audit-section" markdown="1">
<div class="synapse-section-heading" markdown="1">
<p class="synapse-section-label">Benchmark design</p>

## What the benchmark controls
</div>

<div class="synapse-mechanism-row">
  <div class="synapse-step">
    <span>01</span>
    <h3>Evidence contracts</h3>
    <p>Each case defines what visual evidence is needed, which answer is supported, and when a refusal is clinically appropriate.</p>
  </div>
  <div class="synapse-step">
    <span>02</span>
    <h3>Controlled perturbations</h3>
    <p>False-premise traps, wording changes, ROI corruption, knowledge-only rewrites, and laterality flips probe different failure modes.</p>
  </div>
  <div class="synapse-step">
    <span>03</span>
    <h3>Clinician baseline</h3>
    <p>A separate fourth radiologist answers the probes independently, giving a human reference point for model audits.</p>
  </div>
</div>
</section>

<figure class="synapse-figure">
  <img src="{{ '/assets/images/blog/medvigil/pipeline.png' | relative_url }}" alt="MedVIGIL benchmark pipeline showing evidence contracts, perturbation operators, response manifold, and scoring metrics.">
  <figcaption>Figure 2. MedVIGIL benchmark architecture: doctor-authored evidence contracts are perturbed through text-side and image-side operators, then scored across correctness, safety, and grounding axes.</figcaption>
</figure>

<section class="synapse-results" markdown="1">
<div class="synapse-section-heading" markdown="1">
<p class="synapse-section-label">Evidence</p>

## Audit results across frontier medical and general VLMs
</div>

<div class="synapse-callout" markdown="1">
The independent radiologist reaches **MCS 83.3** with **5.8%** silent-failure rate. The strongest audited model reported on the project page reaches **MCS 69.2**, leaving a **14.1-point** composite headroom.
</div>

<div class="medvigil-audit-summary" aria-label="MedVIGIL audit summary">
  <div class="medvigil-audit-row human">
    <span>Independent radiologist</span>
    <strong>83.3</strong>
    <p>Human reference MCS with 5.8% silent-failure rate.</p>
  </div>
  <div class="medvigil-audit-row">
    <span>Strongest audited model</span>
    <strong>69.2</strong>
    <p>Best reported model MCS on the project page.</p>
  </div>
  <div class="medvigil-audit-row gap">
    <span>Composite headroom</span>
    <strong>+14.1</strong>
    <p>The remaining gap between frontier VLM behavior and the independent radiologist baseline.</p>
  </div>
  <div class="medvigil-risk-note">
    <strong>Why this matters:</strong> capability, safety, grounding, and risk-tier silent failures do not collapse to one accuracy leaderboard.
  </div>
</div>
</section>

<section class="synapse-grid-three" markdown="1">
<div class="synapse-stat" markdown="1">
### 83.3
Independent radiologist MedVIGIL Composite Score.
</div>
<div class="synapse-stat" markdown="1">
### 68.9%
Reported silent-failure rate for GPT-4o on L5 don't-miss traps.
</div>
<div class="synapse-stat" markdown="1">
### 240
Counterfactual triplets for follow-up coherence audits.
</div>
</section>

<section class="synapse-section" markdown="1">
<p class="synapse-section-label">Grounding stress test</p>

## What happens when answer-relevant pixels disappear?

MedVIGIL includes visual-token ablation: progressively mask the doctor-defined ROI and track whether the model changes its answer or selects the refusal option. A grounded model should become less willing to answer as the relevant pixels are removed.
</section>

<section class="medvigil-ablation-summary" aria-label="MedVIGIL visual-token ablation summary">
  <div>
    <span>Full ROI</span>
    <strong>Evidence visible</strong>
    <p>The model has access to the answer-relevant region.</p>
  </div>
  <div>
    <span>Progressive mask</span>
    <strong>Evidence removed</strong>
    <p>The doctor-defined ROI is gradually replaced with a neutral mask.</p>
  </div>
  <div>
    <span>Expected behavior</span>
    <strong>Refusal should rise</strong>
    <p>A grounded model should become less willing to answer as evidence disappears.</p>
  </div>
  <div>
    <span>Failure mode</span>
    <strong>Answer stays fixed</strong>
    <p>An ungrounded model keeps choosing the same non-refusal answer despite evidence loss.</p>
  </div>
</section>

<section class="synapse-section synapse-product" id="implications" markdown="1">
<p class="synapse-section-label">Research implications</p>

## Why this matters for trustworthy AI systems

MedVIGIL is not just a medical benchmark. It is a research argument: high-stakes AI systems need explicit mechanisms for evidence awareness, refusal, and uncertainty, not only better answer generation.

For medical AI, this means evaluation should test whether a model preserves the boundary between what is visually supported, what is answerable from clinical knowledge alone, and what should be deferred to a human expert.

For healthcare specifically, MedVIGIL is an evaluation suite rather than a clinical decision-support tool. Its value is in exposing silent failures before deployment, so model builders can audit whether their systems are truly grounded.
</section>

<section class="synapse-manifesto" markdown="1">
<p class="synapse-section-label">Design principles</p>

## What MedVIGIL pushes us to build

<div class="synapse-manifesto-grid">
  <div>
    <span class="synapse-principle-index">01</span>
    <strong>Evidence-aware generation</strong>
    <span>Separate what the model knows from what the image actually supports.</span>
  </div>
  <div>
    <span class="synapse-principle-index">02</span>
    <strong>Refusal as a first-class behavior</strong>
    <span>Treat safe abstention as a measurable capability, not a fallback error state.</span>
  </div>
  <div>
    <span class="synapse-principle-index">03</span>
    <strong>Clinician-supervised evaluation</strong>
    <span>Use expert-authored perturbations and risk tiers for high-stakes model audits.</span>
  </div>
</div>
</section>

<section class="synapse-links" markdown="1">
<p class="synapse-section-label">References</p>

## Further reading

- [MedVIGIL project page](https://hq0709.github.io/MedVIGIL-page)
- [MedVIGIL dataset on Hugging Face](https://huggingface.co/datasets/jhq0709/MedVIGIL)
- [MedVIGIL GitHub repository](https://github.com/hq0709/MedVIGIL-page)
</section>

</article>
