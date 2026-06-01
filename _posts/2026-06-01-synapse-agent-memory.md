---
layout: default
title: "SYNAPSE: Episodic-Semantic Memory for Long-Horizon LLM Agents"
navbar_name: Blog
date: 2026-06-01 00:00:00 -0400
excerpt: "SYNAPSE, accepted to Findings of ACL 2026, turns long-term agent memory from semantic search into spreading activation over an episodic-semantic graph."
---

<article class="synapse-post" markdown="1">

<section class="synapse-hero" markdown="1">
<div class="synapse-hero-header" markdown="1">
<p class="synapse-kicker">GyriQAI Research Note · Findings of ACL 2026</p>

# SYNAPSE: Episodic-Semantic Memory for Long-Horizon LLM Agents
</div>

<div class="synapse-hero-main" markdown="1">
<div class="synapse-hero-copy" markdown="1">
Your RAG agent may not be forgetting. It may simply fail to connect the right memory to the current question. This note summarizes **SYNAPSE**, our ACL 2026 Findings paper on long-term memory for LLM agents. The central claim is modest but important: memory-augmented agents should retrieve not only semantically similar text, but also structurally related evidence across time, entities, and events.

<div class="synapse-flow" aria-label="SYNAPSE retrieval flow">
  <div class="synapse-flow-track">
    <span class="synapse-flow-node">Query</span>
    <span class="synapse-flow-edge"><i></i></span>
    <span class="synapse-flow-node">Graph</span>
    <span class="synapse-flow-edge"><i></i></span>
    <span class="synapse-flow-node active">Activation</span>
    <span class="synapse-flow-edge"><i></i></span>
    <span class="synapse-flow-node">Context</span>
  </div>
  <p>Lexical and semantic anchors inject signal; activation then propagates through the memory graph before final context selection.</p>
</div>

<div class="synapse-hero-actions">
  <a href="https://arxiv.org/abs/2601.02744" target="_blank" rel="noopener">Read the paper</a>
  <a href="#gyriqai">Product implications</a>
</div>
</div>

<div class="synapse-proof-panel" aria-label="SYNAPSE benchmark highlights">
  <div>
    <span>40.5</span>
    <strong>Weighted F1</strong>
    <p>Best weighted average on LoCoMo among compared memory systems.</p>
  </div>
  <div>
    <span>+7.2</span>
    <strong>F1 over A-Mem</strong>
    <p>Improvement over A-Mem on the same GPT-4o-mini setting.</p>
  </div>
  <div>
    <span>95%</span>
    <strong>Fewer tokens</strong>
    <p>Compared with full-context methods on the LoCoMo evaluation.</p>
  </div>
</div>
</div>
</section>

<section class="synapse-author-card" markdown="1">
<div class="synapse-author-label">About the author</div>
<div class="synapse-author-copy" markdown="1">
**Hanqi Jiang** is co-founder of **GyriQAI** and a Computer Science Ph.D. candidate at the **University of Georgia**, advised by Distinguished Research Professor Tianming Liu. His research focuses on long-horizon agent memory, multimodal LLMs, quantum AI, medical image analysis, and brain-inspired AI. He is also affiliated with the Center for Advanced Medical Computing and Analysis at Mass General Brigham / Harvard Medical School, where he works on radiology-related AI research. Through GyriQAI, he is interested in translating memory-augmented agent research into practical decision-support products, starting with EZCollegeApp for U.S. undergraduate application planning.
</div>
</section>

<section class="synapse-thesis" markdown="1">
<p>Core thesis</p>

## Long-term agents need memory that preserves relationships, not just similar text.

Vector search asks: "What past text looks like this question?" SYNAPSE asks a complementary question: **what past evidence is connected to this situation?**
</section>

<section class="synapse-grid-two" markdown="1">
<div class="synapse-card muted" markdown="1">
### Similarity-based retrieval

1. Embed the user query.
2. Retrieve nearby chunks.
3. Stuff them into context.
4. Rely on the model to infer the missing bridge.

This is effective for direct lookup, but weaker when the answer depends on causal, temporal, or transitive links.
</div>

<div class="synapse-card accent" markdown="1">
### SYNAPSE retrieval

1. Build an episodic-semantic graph.
2. Inject activation from lexical and semantic anchors.
3. Let energy spread through temporal, abstraction, and association edges.
4. Retrieve the subgraph that is structurally relevant.

The memory still uses semantic similarity, but it also lets graph structure contribute to relevance.
</div>
</section>

<section class="synapse-section" markdown="1">
<p class="synapse-section-label">The problem</p>

## A common failure mode: contextual isolation

Imagine an assistant that has worked with a user for weeks. The user asks:

> Why am I feeling anxious today?

A vector memory will retrieve messages close to "anxious": stress, sleep, pressure, maybe recent complaints. But suppose the real cause was a scheduling conflict mentioned three weeks ago. That note never used the word "anxiety." It is not close in embedding space. The agent misses it and gives a plausible, incomplete answer.

That is contextual isolation: **the memory exists, but the retrieval system cannot connect it to the moment where it matters.** SYNAPSE is designed for this class of failure.
</section>

<section class="synapse-mechanism" markdown="1">
<div class="synapse-section-heading" markdown="1">
<p class="synapse-section-label">Technical innovation</p>

## Three mechanisms behind SYNAPSE
</div>

<div class="synapse-mechanism-row">
  <div class="synapse-step">
    <span>01</span>
    <h3>Unified graph</h3>
    <p>Dialogue turns become episodic nodes; extracted entities, goals, events, and preferences become semantic nodes. Temporal and semantic structure are represented in one graph.</p>
  </div>
  <div class="synapse-step">
    <span>02</span>
    <h3>Spreading activation</h3>
    <p>A query anchors the graph through BM25 and dense retrieval. Activation then propagates along temporal, abstraction, and association edges.</p>
  </div>
  <div class="synapse-step">
    <span>03</span>
    <h3>Uncertainty gating</h3>
    <p>If activation is too weak, the system can reject the memory claim before generation. This helps reduce memory hallucination.</p>
  </div>
</div>
</section>

<figure class="synapse-figure">
  <img src="{{ '/assets/images/blog/synapse/overview.png' | relative_url }}" alt="SYNAPSE architecture overview showing dual triggers, spreading activation dynamics, episodic-semantic graph nodes, and triple hybrid scoring.">
  <figcaption>Figure 1. Overview of SYNAPSE. A query anchors the memory graph through lexical and semantic triggers, activation propagates across episodic and semantic nodes, and triple hybrid scoring selects the final context.</figcaption>
</figure>

<section class="synapse-bridge" markdown="1">
<div class="synapse-node node-a">Ski trip</div>
<div class="synapse-line line-a"><i></i></div>
<div class="synapse-node hot node-b">Mark</div>
<div class="synapse-line line-b"><i></i></div>
<div class="synapse-node node-c">Later breakup</div>
<div class="synapse-bridge-copy" markdown="1">
### The bridge-node effect

If "Mark" appears in both a ski-trip conversation and a later dating conversation, Mark becomes the bridge. A question about "the guy from the ski trip" can activate the trip, then Mark, then the later relationship outcome. Pure vector search often misses that path.
</div>
</section>

<section class="synapse-results" markdown="1">
<div class="synapse-section-heading" markdown="1">
<p class="synapse-section-label">Evidence</p>

## Results on long-horizon conversational memory
</div>

<div class="synapse-result-table">
  <table>
    <thead>
      <tr>
        <th>Method</th>
        <th>Multi-Hop</th>
        <th>Temporal</th>
        <th>Open-Domain</th>
        <th>Single-Hop</th>
        <th>Weighted F1</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>A-Mem</td>
        <td>27.0</td>
        <td>45.9</td>
        <td>12.1</td>
        <td>44.7</td>
        <td>33.3</td>
      </tr>
      <tr>
        <td>AriGraph</td>
        <td>28.5</td>
        <td>43.2</td>
        <td>14.5</td>
        <td>45.1</td>
        <td>33.7</td>
      </tr>
      <tr>
        <td>MemoryOS</td>
        <td>35.3</td>
        <td>41.2</td>
        <td>20.0</td>
        <td>48.6</td>
        <td>38.0</td>
      </tr>
      <tr>
        <td>Zep</td>
        <td>35.5</td>
        <td>48.5</td>
        <td>23.1</td>
        <td>48.0</td>
        <td>39.7</td>
      </tr>
      <tr>
        <td><strong>SYNAPSE</strong></td>
        <td><strong>35.7</strong></td>
        <td><strong>50.1</strong></td>
        <td><strong>25.9</strong></td>
        <td><strong>48.9</strong></td>
        <td><strong>40.5</strong></td>
      </tr>
    </tbody>
  </table>
</div>

<div class="synapse-callout" markdown="1">
**Low-similarity subset:** when evidence is deliberately far from the question in embedding space, A-Mem drops by more than 50%; SYNAPSE drops by less than 8%. This supports the hypothesis that graph structure provides a complementary retrieval signal.
</div>
</section>

<section class="synapse-grid-three" markdown="1">
<div class="synapse-stat" markdown="1">
### 96.6
Adversarial F1. The gating layer helps the system reject questions about absent memories.
</div>
<div class="synapse-stat" markdown="1">
### 1.9s
Average latency on GPT-4o-mini in the reported efficiency evaluation.
</div>
<div class="synapse-stat" markdown="1">
### $0.24
Estimated cost per 1K queries under the paper's GPT-4o-mini cost profile.
</div>
</section>

<section class="synapse-section synapse-product" id="gyriqai" markdown="1">
<p class="synapse-section-label">From paper to product</p>

## Why this matters for GyriQAI

GyriQAI is building AI products for long-horizon decision support. Our first product direction, **EZCollegeApp**, focuses on U.S. undergraduate application planning for international students.

Admissions guidance is a memory-heavy workflow. A useful AI counselor must track a student's academic profile, school list, document status, essay revisions, deadlines, constraints, and the reasoning behind prior recommendations. It also needs restraint: it should not fabricate experiences, pretend forecasts are guarantees, or replace official admissions requirements.

This is where SYNAPSE informs our product thinking. We are interested in **memory-native AI products**: systems that preserve evolving user context, retrieve grounded evidence at the right time, and know when the evidence is not available.
</section>

<section class="synapse-manifesto" markdown="1">
<p class="synapse-section-label">Product principles</p>

## Design implications

<div class="synapse-manifesto-grid">
  <div>
    <span class="synapse-principle-index">01</span>
    <strong>Relationship-aware retrieval</strong>
    <span>Model temporal, causal, and entity links instead of relying only on semantic similarity.</span>
  </div>
  <div>
    <span class="synapse-principle-index">02</span>
    <strong>Grounded personalization</strong>
    <span>Use explicit user records and workflow state, not generic profile assumptions.</span>
  </div>
  <div>
    <span class="synapse-principle-index">03</span>
    <strong>Memory-aware uncertainty</strong>
    <span>Let the system say when a fact is not in memory.</span>
  </div>
</div>
</section>

<section class="synapse-links" markdown="1">
<p class="synapse-section-label">References</p>

## Further reading

- [SYNAPSE: Empowering LLM Agents with Episodic-Semantic Memory via Spreading Activation](https://arxiv.org/abs/2601.02744)
- [LoCoMo: Evaluating Very Long-Term Conversational Memory of LLM Agents](https://arxiv.org/abs/2402.17753)
- [MemGPT: Towards LLMs as Operating Systems](https://arxiv.org/abs/2310.08560)
- [Microsoft GraphRAG project](https://www.microsoft.com/en-us/research/project/graphrag/)
- [Zep: A Temporal Knowledge Graph Architecture for Agent Memory](https://arxiv.org/abs/2501.13956)
</section>

</article>
