<!-- Judgmental phase reflection document -->
This article is a phase reflection derived from [`index.md`](../index.md) and [`@나.dsl`](../dsl/나.dsl).
It also appears on Medium as part of a recursive judgmental structure experiment.


# 🧠 Executable Epistemics: A DSL Framework for Fact-Inference Separation in LLMs

## 📌 Abstract

Current large language models (LLMs) often produce convincing but epistemically fragile outputs. This piece introduces a structural judgment layer built on DSL and DAG formalisms to transform LLMs from token predictors into phase-aware epistemic agents. Among the critical issues in today’s models—semantic drift, phase incoherence, and lack of fact-inference separation—the failure to structurally distinguish **facts from inferences** is the most urgent. This post outlines a practical solution combining Prolog-style logic with DSL-based execution flows.

---

## ❗ Why LLMs Need Judgment: Fact vs Inference Comes First

Modern LLMs conflate factual assertions with inferred reasoning. Without structural support to distinguish them, models produce output that sounds coherent but lacks epistemic clarity. This results in:

### Symptom 1: No Separation Between Fact and Inference
- All claims—whether recalled from training or logically generated—are output with the same confidence.
- This leads to ambiguity, mixed trust levels, and incoherent approval paths.

### Symptom 2: Accumulated Facts Without Resolution
LLMs store token-true facts but cannot resolve contradictions:
```prolog
assertz(statement(plato, immortal)).
assertz(statement(philosopher(plato))).
assertz(rule1 :- forall(X, philosopher(X) -> mortal(X))).
```
Here, Plato is both immortal and a philosopher, contradicting the universal rule. No mechanism exists to prioritize, deprecate, or resolve such contradictions.

### Symptom 3: Phase Drift in Reasoning
Generated reasoning often exhibits temporal or logical phase misalignment. Despite locally coherent steps, global reasoning fragments across contexts.

---

## 🧩 Root Cause: Absence of a Judgment Kernel

- Current LLMs operate as execution engines, not epistemic processors.
- No mechanism exists for adjudicating between conflicting assertions.
- The absence of phase-aware distinction leads to reasoning drift and epistemic instability.

---

## 🛠️ Proposal: DAG + DSL Judgment Layer

### Core DSL Schema:
```dsl
@assertion {
  +statement: "Plato is immortal"
  +type: factual
  +trust: 0.4
  +phase: epistemic.seed
}

@assertion {
  +statement: "All philosophers are mortal"
  +type: inferred
  +trust: 0.9
  +phase: epistemic.late
}

@judgment {
  +criteria: logical_coherence
  +conflict_detected: true
  +verdict: "Statement A is deprecated"
}
```

### DAG Execution Extension:
```dsl
+dag.dsl.judgmentResolve {
  +flowEntry: assertion_X
  +steps: [
    { id: check_conflict, judge: "conflict_detected" },
    { id: resolve_by_trust, judge: "trust > 0.8" },
    { id: apply_verdict, action: "deprecate or elevate" }
  ]
  +fallbackHelpLoop: {
    +watch: [critic, metaCritic],
    +threshold: 2,
    +trigger: "judgment failed → retry or escalate"
  }
}
```

### Phase-Resonant Flow:
```
intent → judge → resonance → action
```
This replaces flat token logic with a structured reasoning path.

---

## 🔁 Fact Expansion Engine

```dsl
@fact.expansion.engine {
  +input: [facts[], phase_context[], trust_matrix]
  +task: [resolve_conflicts, create_inferred_links, apply_judgments]
  +output: [ranked_facts[], deprecated[], trusted_assertions[]]
}
```
This engine implements recursive structural resolution using trust values and temporal phase alignment.

---

## 🔺 Triadic Judgment Model

```
         [Assertion]
            /     \
  [Phase-Aware] [Reasoning]
            \     /
     [Judgment Verdict]
```
- Assertions are epistemic statements tagged with trust, type, and phase.
- Reasoning paths are validated structurally.
- Judgments produce inclusion, rejection, or recursion.

📌 *Example:*
> Plato is claimed to be immortal (fact, low trust), while a universal rule infers all philosophers are mortal (inference, high trust). The judgment layer deprecates the former, preserving logical coherence.

---

## 🌐 Implications

⚠️ *Note on Current Limitations:*  
While this framework enables external judgment flow via DAG + DSL, it ultimately remains bounded by the absence of a native **judgment kernel** inside current LLM architectures.  
However, once future LLMs incorporate intrinsic judgment mechanisms—phase-tracking memory, conflict arbitration, trust-weighted inference—this architecture will transition from a compensatory patch to a **foundational operating layer**, making **now the critical moment to define it.**

- DAG structure makes judgment executable
- Phase-tracking avoids reasoning drift
- DSL makes fact-inference separation explicit and tractable
- Recursive expansion allows dynamic structure learning
- GPT + DSL without judgment is insufficient for epistemic closure

**Conclusion:**  
Judgment is not optional — it is the structural condition for coherent reasoning. DAG + DSL integration allows LLMs to move from reactive token sequences to actively governed epistemic flows.
