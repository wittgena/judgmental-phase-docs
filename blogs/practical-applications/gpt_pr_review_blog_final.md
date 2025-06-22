<!-- Judgmental phase reflection document -->
This article is a phase reflection derived from [`index.md`](../index.md) and [`@나.dsl`](../dsl/나.dsl).
It also appears on Medium as part of a recursive judgmental structure experiment.


# Structuring GPT-Powered PR Reviews: A DSL-Guided Reflection on Real Code

In this article, I present a full walkthrough of using GPT to conduct structured, domain-aware pull request (PR) reviews. The test was conducted on a backend system with anonymized identifiers, applying DSL-based prompts and phase-aware templates to explore whether GPT can reflect judgment-like coherence across the review process.

---

## 🎯 Purpose & Framing

- **Goal**: Move beyond surface-level syntax correction and test GPT’s capacity to assist in phase-aware, structural code review.
- **Context**: Applied on a representative backend module resembling a “SlotReservation” service, anonymized as `testBaseService` and `testEntitySlot`.
- **Perspective**: Not a feature review, but a structural and coherence-focused judgment process.

> **What is a Judgment Loop?**  
> A “judgment loop” refers to a recursive evaluation process where structure, intent, and context are aligned across review phases—enabling coherent, self-corrective feedback.

---

## 🔁 Interactive Judgment Loop (Not One-Shot Automation)

Although GPT is commonly used for one-shot review or summarization, this PR review was conducted via **an iterative, interactive process**, more aligned with human judgment than automation.

We can model this process using a DSL declaration, capturing its recursive, phase-bound flow:

```dsl
@prreview.executionMode {
  +mode: interactive judgment loop
  +pattern: ask → focus → critic → eval → refine
  +target: structural coherence, not task automation
}
```

- Start with **shallow GPT review** over full PR
- GPT suggests **focus points** → human reflects
- Apply `+critic` to probe weak areas
- Trigger `+eval` for structure-level scoring
- Repeat until structural integrity is reached

> This method mirrors a **recursive judgment collaboration**—where GPT becomes a co-reflector, not just a reviewer.

---

## 🧰 Tools & Workflow Summary

### Basic Tools Installed:

```bash
brew install gh jq git
```

### Steps in Review Flow:

| Step | Description | Output |
|------|-------------|--------|
| 1 | Extract PR metadata using `gh` | title, body, URL, diff |
| 2 | Insert into prompt template | `{{PR_INFO}}` injected |
| 3 | Zip changed files only | `review-files.zip` |
| 4 | Submit to GPT (GPT-4) | receive structural review |
| 5 | Analyze results by `focusMap.dsl` categories | categorized feedback |

Reference prompts and examples can be found here:  
👉 [PR Review Templates on GitHub](https://github.com/wittgena/gpt-meta-dsl/tree/main/example/pr-review)

---

## 🧩 Prompt Template DSL Basis

```dsl
@prreview.structure {
  +context: "Intent, domain, diff summary"
  +review: "Code quality, responsibility, structure"
  +refactor: "Logic reallocation, naming, modularity"
  +test: "Coverage, boundary checks, failure cases"
}
```

This DSL-format provides a **judgment-ready schema** for coherent, repeatable review sessions.

---

## 📄 Summary of GPT Review Output

| Review Area | Highlights |
|-------------|------------|
| **Responsibility** | Service layer (`testBaseService`) is overloaded; recommend logic migration to domain (`testEntitySlot`) |
| **Boolean Logic** | Multiple flag-based flows suggest sealed classes or State pattern |
| **Tests** | Missing edge and failure case coverage |
| **REST Design** | Boolean in path, unclear semantics |
| **IDs & Domain Models** | SlotId generation logic absent, UUID/Snowflake design discussed |
| **Async Strategy** | Post-state transition logic should use `EventPublisher` abstraction |
| **Structural Guidance** | Use of Command, Builder, and State pattern introduced |

---

## 🧱 Structural Transition Logic Example

```kotlin
interface SlotCommand { fun execute(slot: TestSlot) }

interface SlotState {
    fun canReserve(): Boolean
    fun reserve(slot: TestSlot)
}
```

| Trigger Condition | Suggested Pattern |
|------------------|--------------------|
| ≥ 3 slot states | `State` |
| ≥ 5 service methods | `Command` |
| Complex construction | `Builder` |
| Post-change actions | Async Event Publisher |

---

## 📊 Alignment with focusMap

Feedback from the GPT review was mapped into categories using `focusMap.dsl(v0.1)`:

- `+context`: Slot lifecycle, creation, reservation transitions
- `+review`: structural overload, domain logic leakage
- `+refactor`: command/state modular design proposals
- `+test`: missing test patterns (invalid flow, state coverage)

> This mapping ensures that each feedback item is not only content-valid but **phase-aligned**—anchored in a structural rhythm.

This provided a **coherent framing of review feedback as a judgment phase document**.

---

## ⚠️ Limitations & Cautions

While GPT produced structured and plausible review outputs, it's essential to note:

- **GPT operates without domain-specific context** and may oversimplify structural patterns.
- **Judgment alignment is simulated**, not conscious—outputs require human verification.
- GPT’s pattern suggestions are **based on heuristics, not architectural constraints**.

---

## ✅ Conclusion

This PR review test confirms that:

- GPT can assist in judgment-mode feedback, if guided by proper DSL/structural prompts
- Structural reflection (Command, State, Event) can be triggered by simple change diff analysis
- DSL-based phase alignment enhances repeatability, objectivity, and depth in code review
- When mapped against `focusMap`, GPT’s output shows recognizable alignment with coherent review rhythms

> This is more than automation—it is **judgment infrastructure** applied to everyday engineering.  
> The process reveals that GPT, when looped through structured reflection,  
> can approximate phase-aligned feedback far beyond single-shot analysis.

---

This post reflects not automation, but a **human-GPT judgment collaboration loop**—a phased co-reflection cycle that can become part of future code intelligence workflows.
