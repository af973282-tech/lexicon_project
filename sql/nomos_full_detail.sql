-- Classical Language Database — νόμος (L002), full detail
-- Assumes the schema from the λόγος build already exists in your .db
-- (CREATE TABLE IF NOT EXISTS below is a no-op if so; safe to run against
-- either an existing database or a brand-new empty one).

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

-- Lemma: νόμος
INSERT INTO Lemmas (
    Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field, Cross_Language_Connection, Modern_Resonance, Classical_Concept
) VALUES (
    'L002',
    'νόμος',
    'Ancient Greek',
    'From νέμω, ''to distribute, allot, apportion'' (also ''to pasture''). Original sense ''that which is customarily allotted/practiced'' → custom → law. NOTE: distinct from νομός (different accent, ''pasture, district'' — root of the Egyptian administrative ''nome'') — a separate lemma, not a sense of this word; do not merge. Modern Greek νόμος (law); English -nomy (economy, astronomy), ''autonomy'' (αὐτονομία, self-law), ''antinomian.'' Arabic has no native cognate; renderings split by sense across عرف, قانون, and the direct Greek loanword الناموس (reserved for the religious-law sense).',
    'Custom, convention, statute, decree, religious law, governing principle, a type of musical composition.',
    'Latin splits what νόμος can mean across lex (statute, closer to S008) and mos (custom, closer to S007) — the same kind of splitting Latin does to λόγος via ratio/oratio. Arabic''s الناموس is a direct Greek loanword used specifically for Mosaic/biblical law, kept distinct from the native-root قانون used for civil law — evidence that Arabic translators treated the religious sense as needing a different word entirely, not just a different nuance.',
    '''Autonomy'' (αὐτονομία, self-law/self-rule), ''antinomianism'' (doctrine that grace supersedes moral law), the -nomy suffix (economy = oikonomia, ''household management by allotted rule''). The νόμος/φύσις debate anticipates modern nature-vs-convention and legal-positivism-vs-natural-law arguments.',
    'νόμος anchors one of the most consequential debates in Greek thought: the νόμος/φύσις antithesis, asking whether justice and social order are human constructs or grounded in nature. Running from the Sophists through Plato''s Gorgias and Aristotle''s Politics, it resurfaces directly in later natural-law and social-contract theory. UNVERIFIED SENSES (do not promote without LSJ check): ''coin'' is very likely confusion with the related-but-distinct noun νόμισμα; ''course of masonry'' is very likely confusion with νομός (different accent, ''district/pasture'') — both held out of the Senses table pending verification.'
);

-- Senses (5 rows)
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S007',
    'L002',
    'Custom / Usage',
    'العادة، العرف',
    'The oldest, most general sense: ''that which is in habitual practice.'' Often people-specific (Herodotus regularly reports ''it is the νόμος of the X to...''). No sharp line exists in early Greek between habitual practice and a felt-binding rule — the slide from ''custom'' to ''law'' (S008) happens because Greek doesn''t lexically separate them the way English separates custom/law.',
    'Literal: ''that which is customarily allotted/practiced'' (from νέμω) — the base sense the others specialize from.',
    'Synonym: ἔθος (habit — more purely descriptive, less normatively binding). Antonym (in the νόμος/φύσις debate): φύσις (nature).',
    'Especially prominent in Herodotus''s ethnographic digressions, his standard term for reporting a foreign people''s customary practice without asserting it''s universally binding.',
    'νόμος πάντων βασιλεύς — ''custom/law is king of all'' (Pindar fr. 169, quoted by Herodotus 3.38); νόμος δεσπότης / νόμος τύραννος τῶν ἀνθρώπων — emphasizing custom''s near-absolute grip on human life.',
    'Read νόμος as ''custom'' first whenever the sentence describes what a people habitually does, especially in Herodotus — the strict legal sense is a later specialization of this same word.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S008',
    'L002',
    'Law / Ordinance',
    'القانون، التشريع',
    'The classic Athenian political/legal sense: a specific enacted statute, as opposed to a ψήφισμα (a decree on one particular matter). Solon''s laws are the paradigm case: Σόλων νόμους ἔθηκεν, ''Solon enacted laws.''',
    'Contextual narrowing of S007: a custom formally enacted/codified by a recognized political authority, rather than simply practiced habitually.',
    'Near-synonym but importantly distinct: ψήφισμα (a specific decree, not a general/standing law). Antonym: ἀνομία (lawlessness).',
    'Central to Athenian oratory (Demosthenes, Lysias) and to accounts of the Solonic/Cleisthenic reforms; the νόμος/ψήφισμα distinction becomes especially precise in 4th-c. Athenian forensic rhetoric.',
    'νόμον τιθέναι — ''to enact a law''; νόμον τίθεσθαι (middle) — ''to enact a law for oneself/one''s own city''; νόμος ἄγραφος — ''unwritten law''; νόμος γεγραμμένος — ''written law''; κατὰ νόμον — ''according to law''; παρὰ νόμον — ''contrary to law.''',
    'If νόμος shows up with ἔθηκεν/τιθέναι or in a courtroom speech, it means a specific enacted statute — check nearby for ψήφισμα, since Attic legal vocabulary keeps the two carefully distinct.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S009',
    'L002',
    'Divine Law',
    'الناموس',
    'In the Septuagint and New Testament, νόμος regularly renders Hebrew torah, referring to the Mosaic Law (ὁ νόμος Μωϋσέως / ὁ νόμος Κυρίου). Pauline usage extends this: ὁ νόμος τοῦ Χριστοῦ (''the law of Christ'') and ὁ νόμος τοῦ πνεύματος τῆς ζωῆς (''the law of the spirit of life'') use νόμος almost metaphorically for a governing spiritual principle, set against ὁ νόμος τῆς ἁμαρτίας καὶ τοῦ θανάτου (''the law of sin and death'') — here νόμος names an operative controlling power, not a written code.',
    'A theologically specialized narrowing of S008''s concrete Mosaic sense, but capable of extending metaphorically (in Paul) to ''a governing principle/force'' with no written code at all — watch for this shift within a single author.',
    NULL,
    'Septuagint/NT Koine usage; a distinctly different register from classical Athenian S008, even though historically continuous with it.',
    NULL,
    'Don''t assume νόμος in Paul always means ''the Mosaic law as a text'' — by Romans 8 it''s closer to ''a ruling power/principle,'' and Arabic marks this whole cluster with the loanword الناموس rather than plain قانون.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S010',
    'L002',
    'Convention (philosophical, νόμῳ/φύσει)',
    'اصطلاح، اتفاق عرفي',
    'The Sophistic/philosophical technical sense activated in the νόμῳ vs. φύσει antithesis: something holds ''by convention/human agreement'' (νόμῳ) as opposed to ''by nature'' (φύσει). Central to Antiphon and to Callicles''s speech in Plato''s Gorgias.',
    'A philosophically sharpened S007: not just ''what people happen to do'' but ''what holds only because humans have agreed to it,'' explicitly opposed to what holds intrinsically — the opposition itself is the philosophical content, absent from the plain ''custom'' sense.',
    'Direct philosophical antonym: φύσις (nature) — one of the most productive binaries in Greek thought.',
    NULL,
    'νόμῳ ... φύσει — the standard contrastive dative pair; ὅσον νόμου χάριν — ''for form''s/convention''s sake only,'' i.e. merely conventionally, not in reality.',
    'Whenever νόμῳ is paired with φύσει, you''re in the specific debate over whether something is ''real'' or merely ''agreed upon'' — don''t translate νόμῳ here as just ''customarily.'''
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S011',
    'L002',
    'Musical composition (nome)',
    'لحن أو مؤلَّف موسيقي محدد',
    'A distinct technical sense: a νόμος is a fixed, traditional melody-type/composition associated especially with citharodic (kithara-accompanied) performance — e.g. the ''Orthian nome'' (cf. Herodotus 1.24). The melody and the composition built on it weren''t felt as separate things, which is why ''melody'' and ''composition'' collapse into one sense rather than two.',
    'Draws on the same root idea as S007/S008 — a fixed, established, traditionally-allotted pattern — applied to music; the connection is the ''fixed pattern'' concept, not a metaphorical extension of ''law.''',
    NULL,
    'Archaic/Classical musical-poetic terminology; essentially unconnected in actual usage to the legal/political senses despite sharing the word.',
    NULL,
    'If νόμος shows up in a musical/poetic-performance context, it means a set melody-type/composition, not ''law'' — a separate technical vocabulary sharing only the ''fixed pattern'' root idea.'
);

-- Constructions (6 rows)
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C006',
    'S008',
    'κατὰ νόμον — ''according to law,'' accusative governed by κατά in its ''in accordance with'' sense.',
    'Accusative',
    'κατά+accusative marks conformity/accordance, parallel to κατὰ λόγον. κατά+genitive (''down from, against'') would wrongly imply opposition rather than agreement — the case alone flips the meaning from ''in accordance with the law'' toward ''down against the law,'' which is why the true opposite of κατὰ νόμον is expressed with a different preposition (παρά, C007) rather than by switching κατά''s case.',
    'Students assume κατά''s case barely matters since it governs both genitive and accusative; here it matters completely — swapping the case doesn''t just shade the meaning, it heads toward nonsense, since ''against the law'' is idiomatically expressed by παρά, not by κατά+genitive.',
    'νόμον, accusative singular of νόμος, -ου, ὁ (2nd declension masculine).',
    'Adverbial prepositional phrase modifying the verb/clause, marking legal conformity.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C007',
    'S008',
    'παρὰ νόμον — ''against/contrary to law,'' accusative governed by παρά in its directional ''to beside, alongside'' sense.',
    'Accusative',
    'παρά governs three cases with three distinct core senses: genitive (''from beside'' — source), dative (''beside, in the presence of'' — static location), accusative (''to beside, alongside'' — motion along/past). The accusative''s motion-based core is what develops the figurative meaning ''beside the mark, off to the side of what the law specifies'' → ''in violation of, contrary to.'' It is specifically the accusative''s directional sense (not the genitive''s source-sense or the dative''s static sense) that makes the ''stepping past/beside the law'' metaphor work — case governs meaning here, not the reverse. This construction also gives Athenian law its technical noun: γραφὴ παρανόμων, ''indictment for an unconstitutional proposal,'' etymologically transparent as ''beside/against-the-law.''',
    'The biggest trap: assuming παρά always means neutral spatial ''beside'' and missing that παρά+accusative in a legal/normative context is idiomatically negative (''contrary to, in violation of'') rather than merely locational.',
    'νόμον, accusative singular, governed by παρά.',
    'Adverbial prepositional phrase, directly antonymic in function to κατὰ νόμον (C006) despite both governing the accusative.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C008',
    'S008',
    'νόμον τιθέναι (active) — ''to enact a law''; νόμον τίθεσθαι (middle) — ''to enact a law for oneself/one''s own city.''',
    'Accusative (direct object of τιθέναι/τίθεσθαι).',
    'Straightforward transitive direct-object accusative — unremarkable as a case choice. The real teaching point is voice, not case: middle τίθεσθαι shifts the sense from enacting a law generically to enacting a law that binds the enactor''s own community, a nuance the active voice doesn''t carry.',
    'Students often treat τιθέναι/τίθεσθαι as stylistic variation; in legal-historical texts (e.g. Solon) the active/middle choice can signal exactly who the law is understood to bind.',
    'νόμον, accusative singular; τιθέναι, present active infinitive of τίθημι; τίθεσθαι, present middle infinitive.',
    'νόμον = direct object of the infinitive.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C009',
    'S009',
    'νόμος + genitive — ''the law of X'' (ὁ νόμος τοῦ Μωϋσέως, ''the law of Moses''; ὁ νόμος τοῦ πολέμου, ''the law of war'').',
    'Genitive.',
    'A genitive of reference/source marking the authority, origin, or domain the law belongs to — Greek uses the bare genitive rather than a preposition, the way an adnominal genitive regularly marks possession or source without a separate word for ''of.''',
    'In Pauline usage this construction shifts from a source/authority genitive (νόμος τοῦ Μωϋσέως, a law originating from Moses) to something closer to a domain/governing-sphere genitive (ὁ νόμος τοῦ πνεύματος τῆς ζωῆς — not a law issued by ''the spirit'' as an authority figure, but the governing principle operative within that domain). Same case, subtly different genitive function — don''t assume every νόμος+genitive is a source-genitive.',
    'νόμος stands in whatever case the clause requires; the dependent noun stands in the genitive regardless.',
    'The genitive noun is an adnominal genitive modifying νόμος.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C010',
    'S010',
    'νόμῳ ... φύσει — a contrastive dative pair, ''by convention ... by nature,'' used without a preposition.',
    'Dative.',
    'A dative of manner/respect, structurally identical to the λόγῳ/ἔργῳ construction already built for λόγος: it answers ''by what standard does this hold?'' — ''this is F νόμῳ'' means ''this counts as F by the standard of convention,'' not ''this is F using convention as an instrument'' (an over-literal instrumental misreading).',
    'Same pitfall as λόγῳ: students force an instrumental reading (''by means of convention'') instead of recognizing the dative of respect scoping the claim to one standard (convention) versus another (nature) — the two datives do parallel scoping work, which is exactly why the pairing is philosophically forceful: it lines up two rival standards in the same grammatical slot.',
    'νόμῳ, dative singular of νόμος; φύσει, dative singular of φύσις (3rd declension).',
    'Adverbial dative modifying the predicate, in contrastive pairing with a second adverbial dative.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C011',
    'S011',
    'νόμος ὄρθιος — ''the Orthian nome,'' a specific named citharodic composition (cf. Herodotus 1.24, the Arion story).',
    'Nominative (citation form); adjective agrees with νόμος in whatever case the sentence requires.',
    'Not primarily a case-choice teaching point (ordinary adjective agreement) — the real point is genre-naming convention: specific νόμοι (compositions) were individually named via an attributive adjective, the way one might name a raga or maqam. Recognizing this naming pattern is what signals a musical-technical use of νόμος rather than a legal one, even before reading further context.',
    'A student trained to expect νόμος = ''law'' may try to force a legal reading onto ''νόμος ὄρθιος'' — recognizing the adjective-naming pattern of the musical genre immediately resolves this.',
    'ὄρθιος, -α, -ον, 1st/2nd declension adjective agreeing with νόμος.',
    'Attributive adjective modifying νόμος; together they form a genre/composition proper name.',
    NULL
);

-- Citations (6 rows)
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit006',
    'C006',
    'Formulaic across Attic oratory (e.g. Demosthenes, Lysias) — no single canonical locus; κατὰ (τὸν) νόμον is standard legal-formulaic Greek across forensic speeches.',
    'The formulaic, repeated nature of the phrase is itself informative: it shows κατὰ νόμον functioning as fixed legal boilerplate, not a one-off literary choice by any single author.',
    'وفقًا للقانون / بحسب القانون',
    'General usage pattern across the Attic orators (Demosthenes, Lysias, OCT editions).',
    'FLAG: this row describes a usage pattern, not one verbatim citation — if the database requires a single pinned example, select a specific Demosthenes passage and verify against TLG before publishing.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit007',
    'C007',
    'The Athenian legal procedure γραφὴ παρανόμων (''indictment for an unconstitutional proposal''), discussed across Demosthenes'' orations and Aristotle''s Athenian Constitution.',
    'παρανόμων is built directly from παρὰ+νόμος, making the etymology of the legal procedure itself the clearest possible illustration of what παρὰ νόμον means and how it functions as a legal charge, not just a phrase.',
    'دعوى مخالفة القانون (a descriptive Arabic rendering of the procedure, since الناموس/القانون terminology doesn''t have a single-word Arabic legal-procedure equivalent)',
    'Aristotle, Athenaion Politeia; Demosthenes'' orations generally discuss or invoke this procedure.',
    'FLAG: this describes a well-attested institution rather than one pinned sentence — select a specific oration (e.g. Demosthenes, Against Meidias) and verify the exact passage against TLG if a single citation is required.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit008',
    'C008',
    'Widely reported of Solon: Σόλων νόμους ἔθηκεν, ''Solon enacted laws'' (cf. Aristotle, Athenaion Politeia; Plutarch, Life of Solon).',
    'τιθέναι is chosen (rather than a generic verb like ποιεῖν, ''to make'') because it specifically connotes formal, authoritative enactment/establishment — appropriate to Solon''s role as a constitutionally empowered lawgiver, not merely someone who produced rules informally.',
    'سنّ سولون قوانين',
    'Aristotle, Athenaion Politeia; Plutarch, Vitae (Solon).',
    'FLAG: this is a paraphrase of a widely reported fact across multiple ancient sources, not a single verbatim quotation from one text — pin to a specific passage (Ath. Pol. or Plutarch, Solon) and verify exact wording before publishing.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit009',
    'C009',
    'Romans 8:2 — core vocabulary: ὁ νόμος τοῦ πνεύματος τῆς ζωῆς (''the law of the spirit of life'') set against ὁ νόμος τῆς ἁμαρτίας καὶ τοῦ θανάτου (''the law of sin and death'').',
    'Paul deliberately reuses νόμος across both halves of the antithesis rather than switching to a different word, forcing the reader to hold both the concrete Mosaic-law sense and this newer governing-principle sense in mind simultaneously — the repetition is the argument.',
    'ناموس روح الحياة ... ناموس الخطية والموت (standard Arabic NT phrasing, using الناموس consistently with the loanword rather than plain قانون)',
    'Novum Testamentum Graece (Nestle-Aland); Van Dyck Arabic NT for the traditional Arabic phrasing.',
    'FLAG: the key phrases quoted here are well-established; verify full verse wording and exact word order against Nestle-Aland before publishing a complete verbatim citation.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit010',
    'C010',
    'Plato, Gorgias 482e ff. — Callicles''s speech contrasting what holds νόμῳ (conventionally) against what holds φύσει (naturally) in his argument about justice and the stronger.',
    'Plato has Callicles use exactly this νόμῳ/φύσει vocabulary because it was already the live technical language of the Sophistic movement (cf. Antiphon''s On Truth) — using it signals Callicles is deploying a recognized philosophical position, not improvising.',
    'بالاصطلاح ... بالطبيعة',
    'Plato, Gorgias, ed. Dodds (standard critical commentary and edition).',
    'FLAG: verify exact Stephanus line range and wording against the OCT/Dodds text before quoting Greek verbatim; note that Antiphon''s papyrus fragment (Oxyrhynchus) is an alternative, non-Platonic primary source for the same debate if a Sophistic (rather than Platonic-dramatized) citation is preferred.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit011',
    'C011',
    'Herodotus 1.24 — Arion, facing death at the hands of the sailors, requests to perform the νόμος ὄρθιος (''the Orthian nome'') in full citharodic dress before leaping into the sea (after which a dolphin famously saves him).',
    'Herodotus names the specific nome Arion performs, using νόμος in its precise musical-technical sense — signalling to the reader that this is a real, recognized composition-type, not a generic ''song,'' which matters for the story''s claim to specific, verifiable detail.',
    'لحن الأورثيوس (proper names of musical genres are typically transliterated rather than translated, similarly to how maqam names are kept in Arabic)',
    'Herodotus, Historiae, ed. Hude/Wilson (OCT), Book 1.',
    'FLAG: verify exact chapter/spelling of ὄρθιος against the OCT text before publishing; the general fact (Arion requests this named nome before his leap) is well-established in Herodotus scholarship, but exact wording should be checked against TLG.'
);
