-- Classical Language Database — full schema + full-detail λόγος entry
-- Safe to run repeatedly (CREATE TABLE IF NOT EXISTS); re-running INSERTs on
-- existing IDs will error under plain INSERT (by design — see note at bottom).

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Lemmas (
    Lemma_ID                  TEXT PRIMARY KEY,
    Term_Original              TEXT NOT NULL,
    Language                   TEXT NOT NULL,
    Root_Lineage                TEXT,
    Semantic_Field              TEXT,
    Cross_Language_Connection   TEXT,
    Modern_Resonance            TEXT,
    Classical_Concept           TEXT
);

CREATE TABLE IF NOT EXISTS Senses (
    Sense_ID                   TEXT PRIMARY KEY,
    Lemma_ID                   TEXT NOT NULL REFERENCES Lemmas(Lemma_ID) ON DELETE CASCADE,
    Sense_Label                 TEXT NOT NULL,
    Primary_Arabic_Definition   TEXT,
    Nuance_Context               TEXT,
    Literal_vs_Contextual        TEXT,
    Synonyms_Antonyms            TEXT,
    Author_Period_Nuance         TEXT,
    Fixed_Expression_Proverb     TEXT,
    Student_Note                 TEXT
);

CREATE TABLE IF NOT EXISTS Constructions (
    Construction_ID             TEXT PRIMARY KEY,
    Sense_ID                    TEXT NOT NULL REFERENCES Senses(Sense_ID) ON DELETE CASCADE,
    Construction_Governance      TEXT NOT NULL,
    Required_Case                TEXT,
    Case_Why_Not_Another         TEXT,
    Syntactic_Pitfall            TEXT,
    Morphology                   TEXT,
    Syntax_Role                  TEXT,
    Morphological_Change         TEXT
);

CREATE TABLE IF NOT EXISTS Citations (
    Citation_ID                 TEXT PRIMARY KEY,
    Construction_ID              TEXT NOT NULL REFERENCES Constructions(Construction_ID) ON DELETE CASCADE,
    Example_Citation              TEXT NOT NULL,
    Why_This_Word                 TEXT,
    Translation_Choices           TEXT,
    Source_Reliability            TEXT,
    Verification_Notes            TEXT
);

CREATE INDEX IF NOT EXISTS idx_senses_lemma ON Senses(Lemma_ID);
CREATE INDEX IF NOT EXISTS idx_constructions_sense ON Constructions(Sense_ID);
CREATE INDEX IF NOT EXISTS idx_citations_construction ON Citations(Construction_ID);

-- Lemmas (1 row)
INSERT INTO Lemmas (
    Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field, Cross_Language_Connection, Modern_Resonance, Classical_Concept
) VALUES (
    'L001',
    'λόγος',
    'Ancient Greek',
    'From λέγω: ''to speak'' and an older ''to gather/reckon'' (cf. Latin legere). Descendants: Modern Greek λόγος; English -logy/-logue/-logic/logos, ''logarithm''; Arabic نطق/منطق via the 9th-10th c. translation movement (calque, not loanword).',
    'Speech, narrative, discourse, reason, rational principle, definition, argument, ratio/proportion, cosmic ordering principle, the divine Word.',
    'Latin splits it into ratio (reason) and oratio/verbum (speech). Arabic needs several words: قول, عقل, منطق, الكلمة depending on sense.',
    'Root of ''logic'', ''-ology'', ''dialogue'', ''analogy'', ''logarithm''. Heraclitus''s cosmic Logos anticipates natural-law thinking; feeds into Stoic and Johannine Logos theology; Derrida''s ''logocentrism''.',
    'The single most conceptually loaded word in Greek philosophy: reasoned speech (Aristotle), cosmic rational order (Heraclitus), definitional formula (Plato/Aristotle), mathematical ratio (Euclid).'
);

-- Senses (6 rows)
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S001',
    'L001',
    'Speech-act / spoken word / saying',
    'قول، كلام، حديث',
    'Default concrete sense, opposed to ἔργον (deed). Common in λόγῳ μέν... ἔργῳ δέ.',
    'Literal: ''a thing said'' — the base sense all others extend from.',
    'Synonym: ῥῆμα, φωνή. Antonym: ἔργον.',
    'Homer prefers ἔπος/μῦθος; λόγος dominates from 5th-c. prose (Herodotus, Thucydides) onward.',
    'λόγῳ μὲν... ἔργῳ δέ — ''in word... but in deed''.',
    'The ''boring'' baseline sense — try this first if stuck.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S002',
    'L001',
    'Account, narrative, story (historiographical)',
    'رواية، حكاية، سرد',
    'In Herodotus, a self-contained narrative unit — ''the Egyptian logos''.',
    'Extension from ''speech'' to ''content of an extended speech-act'', often with implicit truth-value question.',
    'Near-synonym: μῦθος (trends fictional). Contrast: ὄψις (eyewitness observation).',
    'Distinctly Herodotean/historiographical usage.',
    NULL,
    'λόγος = ''story/account'' in Herodotus when ''word'' makes no sense.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S003',
    'L001',
    'Reason, rational faculty, cosmic rational principle',
    'العقل، المبدأ العقلي الكوني',
    'Heraclitus fr.1: λόγος as cosmic ordering principle, common (ξυνός) yet misunderstood. Stoics: λόγος σπερματικός. Aristotle, Politics 1.2: λόγος distinguishes humans from animals (vs. mere φωνή).',
    'Metaphorical leap from ''speech'' to ''rational structure underlying speech/thought/cosmos''.',
    'Partial synonym: νοῦς. Antonym: ἄλογος, ἄλογα ζῷα.',
    'Heraclitus → Aristotle → Stoics → Philo — feeds into S005.',
    NULL,
    'The ''big idea'' sense — Reason itself, cosmic or human depending on context.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S004',
    'L001',
    'Definition, reasoned account, argument',
    'التعريف، الحجة العقلية، البرهان',
    'Plato, Theaetetus 201c ff.: true belief + λόγος as candidate definition of knowledge. Aristotle: defining formula / argument-from-reasoning in Rhetoric.',
    'Technical narrowing: a justificatory account, not just any account.',
    'Synonym: ἀπόδειξις. Contrast: δόξα (mere opinion).',
    NULL,
    'λόγον διδόναι (τινός) — ''to give an account of X''.',
    'A demand for λόγος = demand for a defensible justification, not a dictionary gloss.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S005',
    'L001',
    'The Word (theological hypostasis)',
    'الكلمة',
    'Philo: Logos as intermediary hypostasis. John 1:1 identifies this with Christ.',
    'Furthest extension from S001: speech becomes a personal divine hypostasis. Arabic keeps الكلمة distinct from ordinary قول.',
    NULL,
    'Presupposes S003 (Stoic cosmic reason) — John activates existing philosophical resonance.',
    NULL,
    'Not casually ''reason'' or ''word'' — by John, λόγος is close to a proper noun.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S006',
    'L001',
    'Ratio, proportion (mathematical)',
    'النسبة',
    'Euclid, Elements V, Def. 3: λόγος as relation of size between two magnitudes. Underlies ''logarithm''.',
    'Draws on the ''reckoning'' strand of λέγω, not ''speaking''.',
    'Near-synonym: ἀναλογία.',
    'Distinctly Euclidean/mathematical (4th-3rd c. BCE).',
    'κατὰ λόγον — ''proportionally'' / ''reasonably''.',
    'In mathematical passages, try ''ratio'' before ''word'' or ''reason''.'
);

-- Constructions (5 rows)
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C001',
    'S001',
    'λόγῳ μέν... ἔργῳ δέ antithetical dative pairing.',
    'Dative (no preposition).',
    'Dative of respect/manner (''true in the sphere of word'') — not instrumental, not a direct object.',
    'Students force an instrumental reading (''by means of word''); loses the antithetical scoping force.',
    'λόγος, -ου, ὁ, 2nd decl. masc.; dative sg. λόγῳ.',
    'Adverbial dative modifying the whole antithesis.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C002',
    'S003',
    'ζῷον λόγον ἔχον-type: λόγον as object of ἔχειν (cf. Aristotle, Politics 1.2).',
    'Accusative (direct object of ἔχειν).',
    'Straightforward transitive direct object; genitive would wrongly imply partitive, dative isn''t used for ἔχειν''s object.',
    'Confusable with the separate idiom ''to make an argument'' (S004) vs. ''to possess reason'' (S003).',
    'λόγον = acc. sg.; ἔχον = pres. act. ptc. agreeing with the head noun.',
    'λόγον = direct object of the participle ἔχον.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C003',
    'S004',
    'λόγον διδόναι (τινός) — ''to give an account of X''.',
    'Genitive (of the matter accounted for).',
    'Genitive of reference/connection, not partitive/possessive — bare genitive marks ''what the account concerns'' without needing a preposition.',
    'Confusable with genitive of source (''an account from X''); context disambiguates.',
    'λόγον, acc. sg.; διδόναι, pres. act. inf. of δίδωμι.',
    'λόγον = object of διδόναι; genitive noun = adnominal genitive on λόγον.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C004',
    'S005',
    'πρὸς τὸν θεόν — Logos''s relation to God (John 1:1).',
    'Accusative (governed by πρός).',
    'πρός+acc. normally = literal motion toward; here read relationally (face-to-face communion), not spatially — a nuance Koine πρός+acc. can carry beyond motion.',
    'Beginner error: reading it as mere physical direction, understating the claim of relational union.',
    'τὸν θεόν: acc. sg. masc. of θεός, governed by πρός.',
    'Prepositional phrase as predicate complement.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C005',
    'S006',
    'κατὰ λόγον — ''proportionally'' / ''as reason would have it''.',
    'Accusative (governed by κατά in its ''in accordance with'' sense).',
    'κατά+acc. = conformity/accordance, vs. κατά+gen. = ''down from/against'' — genitive would wrongly imply opposition.',
    'Confusable with distributive κατά+acc. (κατὰ πόλεις); only λόγον + context signals the proportion sense.',
    'λόγον, acc. sg., governed by κατά.',
    'Adverbial prepositional phrase.',
    NULL
);

-- Citations (5 rows)
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit001',
    'C001',
    'Thucydides, Funeral Oration (2.35-46) — repeated λόγος/ἔργον contrasts throughout.',
    'Activates the whole word/deed polarity central to 5th-c. Athenian political rhetoric.',
    'قولًا... وفعلًا (or عملًا) preserves the antithetical balance.',
    'Thucydides, Historiae, ed. Jones & Powell (OCT).',
    'FLAG: paraphrase of the rhetorical pattern, not a verbatim quote — verify exact wording/line vs. TLG before publishing.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit002',
    'C002',
    'Aristotle, Politics 1.2 (Bekker 1253a) — human λόγος vs. animal φωνή.',
    'Only λόγος (not φωνή/λαλιά) discloses the advantageous, harmful, and just — the basis of his political argument.',
    'النطق (al-nutq) is the standard Arabic-Aristotelian-tradition rendering, reserved for this rational-speech sense.',
    'Aristotle, Politica, ed. Ross (OCT), Bekker 1253a.',
    'FLAG: verify exact clause wording against the Bekker text before quoting Greek verbatim.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit003',
    'C003',
    'Plato, Theaetetus 201c-210b — ''true belief + λόγος'' definition of knowledge.',
    'λόγος (justifiable account) is required over bare δόξα (true belief) — the entire point of the passage.',
    'الحجة العقلية / البرهان fits better than plain قول given the justificatory weight required.',
    'Plato, Theaetetus, ed. Burnet (OCT), Stephanus 201c ff.',
    'FLAG: the dialogue''s resolution is genuinely disputed in scholarship (3 candidate readings) — cite which reading is being followed.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit004',
    'C004',
    'Ἐν ἀρχῇ ἦν ὁ λόγος, καὶ ὁ λόγος ἦν πρὸς τὸν θεόν, καὶ θεὸς ἦν ὁ λόγος. (John 1:1)',
    'Opens with λόγος to activate S003''s cosmic-reason resonance and Philo''s hypostasis reading for a Hellenized audience.',
    'الكلمة (Van Dyck: ''وكان الكلمة عند الله'') kept distinct from قول; عند mirrors πρός''s relational force.',
    'Novum Testamentum Graece (Nestle-Aland); Van Dyck Arabic Bible.',
    'Greek text is standard/undisputed. Verify Arabic phrasing against the specific edition you cite.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit005',
    'C005',
    'Euclid, Elements V, Def. 3 — λόγος as relation of size between two magnitudes (paraphrased).',
    'Needs a term for ''relative size relationship'' distinct from ἀναλογία; λόγος chosen via the ''reckoning'' strand of λέγω.',
    'النسبة (al-nisba) is the standard Arabic mathematical term, unambiguous vs. the ''speech'' senses.',
    'Euclid, Elementa, ed. Heiberg/Heath.',
    'FLAG: Def. 3 is a famously debated definition in the history of mathematics — note the dispute rather than presenting it as self-explanatory.'
);

-- NOTE on re-running this script:
-- Plain INSERT will raise "UNIQUE constraint failed" if these IDs already exist
-- in your database (e.g. you already ran the condensed version). That's the
-- database correctly protecting you from silently duplicating or shadowing data.
-- To load fresh: run this against a new/empty .db file.
-- To overwrite existing L001/S00x/C00x/Cit00x rows with this fuller text instead:
-- change "INSERT INTO" to "INSERT OR REPLACE INTO" in each block above.
