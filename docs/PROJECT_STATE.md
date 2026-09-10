# Project State

Last updated: after completing Lemma #11 (γάρ).

## Current database contents

| Metric | Count |
|---|---|
| Lemmas | 11 |
| Senses | 87 |
| Constructions | 64 |
| Citations | 64 (word 11's 5 citations all `verified`) |
| Morph_Index rows | 40 (γάρ contributes 1 -- indeclinable) |

Words, in build order: λόγος, νόμος, ψυχή, δίκη, ἀρετή, γνῶσις, εἰμί, ἀπό, θεός, ὕβρις, γάρ.

## What was just completed (this task)

Lemma #11, **γάρ** (a discourse particle -- the hardest grammatical category
attempted so far: no case government, no morphological paradigm).

- Built entirely through `scripts/add_word11.py`, using the parameterized
  `db_utils.py` layer (no hand-written SQL, no manually-tracked IDs).
- Assigned IDs: `L011`; Senses `S081`-`S087` (7 discourse functions: causal,
  anticipatory/inverted, elliptical yes/no, epexegetic, interrogative,
  wish-strengthening, the τί γάρ; idiom); Constructions `C060`-`C064` (5,
  covering postpositive word order, clause-fronting, ellipsis, the
  evidence-introducing formula, and the wish-intensifying combination);
  5 Citations, all `verification_status = 'verified'`.
- Design claim verified by direct query, not just asserted: all 5 of
  γάρ's `Required_Case` values are `N/A` (queried and confirmed --
  see commit `2904a84`).
- Full regression suite: **13/13 passing** after load (`python -m
  unittest tests.test_integrity -v`).
- Committed: `2904a84 Word 11: γάρ -- a discourse particle, built through
  db_utils.py`.

## Files changed in this task

- **Added:** `scripts/add_word11.py` (the only new file)
- **Modified:** `classical.db` (via the script -- L011 and its children added)
- **Unrelated files:** untouched, per instructions

## Known open items (not part of this task, listed for continuity)

- `scripts/add_word10.py` is not idempotent -- re-running it creates a
  duplicate Lemma rather than a no-op. `scripts/dedupe_word.py` and
  `scripts/cleanup_all_duplicates.py` exist as after-the-fact fixes; a
  proper fix (reject/skip duplicate `Term_Original` in `add_lemma()`)
  has been discussed but not yet implemented in `db_utils.py`.
- Cross-lemma pattern taxonomy (`Pattern_Category` column) has not been
  reviewed against word 11's new SINGLETON categories to check for
  overlap with existing patterns from words 1-10 -- worth a pass once
  a few more particles/functional words are added, the same way word
  10 promoted `Cognate/Internal Accusative Object` from singleton to
  confirmed.

## Exact next step

No word 12 has been chosen yet. Two directions were on the table before
this task began:
1. Another particle or functional word (test whether γάρ's
   discourse-structural Construction categories recur).
2. A return to nouns/verbs to keep building lexicon breadth.

**Next action is to choose word 12 and confirm which direction, then
build it via `scripts/add_word12.py` following the same pattern as
`add_word10.py`/`add_word11.py`.** No other in-progress work is pending.
