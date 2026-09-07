-- Patch for arete_full_detail.sql — run AFTER it's already loaded.
-- 1. Upgrades Cit025 from paraphrase to confirmed-by-excerpt (Republic I function argument,
--    now confirmed to extend through horses to human virtue/justice).
-- 2. Adds Cit030 — a stronger, confirmed citation for S033/C026 (Protagoras 329c-d,
--    the "unity of virtue" question), replacing reliance on the Aristotle-only citation alone.

UPDATE Citations SET
    Example_Citation = 'Plato, Republic I, 352d-354a — the full function argument: eyes and ears each have their own ἀρετή (352d-353e), extended explicitly to horses (τῶν ἵππων ἀρετήν, 353b) and then to human beings (τὴν ἀνθρωπείαν ἀρετήν), concluding that δικαιοσύνη -- justice -- just IS ἀνθρωπεία ἀρετή, the specifically human excellence (353e-354a).',
    Verification_Notes = 'CONFIRMED (upgraded from paraphrase): direct textual excerpts confirm the argument''s extension through τῶν ἵππων ἀρετήν to ἀνθρωπείαν ἀρετήν and the identification of δικαιοσύνη as ἀνθρωπεία ἀρετή. Exact Stephanus line boundaries for each clause still worth confirming against the OCT for a publication-grade citation, but the argument''s content and sequence are now verified against real excerpted text rather than paraphrase alone.'
WHERE Citation_ID = 'Cit025';

INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices,
    Source_Reliability, Verification_Notes
) VALUES (
    'Cit030','C026',
    'Plato, Protagoras 329c-d -- Protagoras is asked whether ἀρετή is one thing with parts (μόριά ἐστιν), the way a face has parts (mouth, nose), or whether courage, wisdom, justice, temperance, and piety are all simply names for the same single thing -- the famous ''unity of virtue'' question.',
    'ἀρετή here is deliberately used as the single term whose internal unity or plurality is exactly what is being investigated -- the whole argument depends on treating courage/wisdom/justice/temperance/piety as candidate PARTS of one ἀρετή, testing whether the moral-virtue sense (S033) names one thing or several.',
    'وحدة الفضيلة (اعتبارها شيئًا واحدًا ذا أجزاء كالشجاعة والحكمة والعدالة) -- a technical philosophical framing distinct from the general excellence sense.',
    'Plato, Protagoras, ed. Burnet (OCT), Stephanus 329c-d.',
    'CONFIRMED via direct textual excerpt (not paraphrase). Still verify exact Stephanus line boundaries against the OCT before a publication-grade quotation, but the passage''s content and the ''unity of virtue'' framing are now grounded in real attested text rather than general knowledge alone.'
);
