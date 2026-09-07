-- Classical Language Database — γνῶσις (L006), full detail
-- Run AFTER logos, nomos, psyche, dike, and arete are already loaded.
-- Note: 2 senses proposed in earlier analysis were deliberately NOT included as separate rows:
-- "means of knowing" (folded into S041) and "being known/knowability" (reframed as the
-- subjective/objective genitive construction note in C035) -- see Lemma design note.
-- 3 of the 9 senses (S044 recognition, S046 spiritual knowledge, S048 written record)
-- intentionally have NO Construction/Citation rows in this pass, consistent with "not every
-- sense needs one." S049 (fame) also has none, and is additionally flagged as unverified.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Lemmas (
    Lemma_ID TEXT PRIMARY KEY, Term_Original TEXT NOT NULL, Language TEXT NOT NULL,
    Root_Lineage TEXT, Semantic_Field TEXT, Cross_Language_Connection TEXT,
    Modern_Resonance TEXT, Classical_Concept TEXT
);
CREATE TABLE IF NOT EXISTS Senses (
    Sense_ID TEXT PRIMARY KEY, Lemma_ID TEXT NOT NULL REFERENCES Lemmas(Lemma_ID) ON DELETE CASCADE,
    Sense_Label TEXT NOT NULL, Primary_Arabic_Definition TEXT, Nuance_Context TEXT,
    Literal_vs_Contextual TEXT, Synonyms_Antonyms TEXT, Author_Period_Nuance TEXT,
    Fixed_Expression_Proverb TEXT, Student_Note TEXT
);
CREATE TABLE IF NOT EXISTS Constructions (
    Construction_ID TEXT PRIMARY KEY, Sense_ID TEXT NOT NULL REFERENCES Senses(Sense_ID) ON DELETE CASCADE,
    Construction_Governance TEXT NOT NULL, Required_Case TEXT, Case_Why_Not_Another TEXT,
    Syntactic_Pitfall TEXT, Morphology TEXT, Syntax_Role TEXT, Morphological_Change TEXT
);
CREATE TABLE IF NOT EXISTS Citations (
    Citation_ID TEXT PRIMARY KEY, Construction_ID TEXT NOT NULL REFERENCES Constructions(Construction_ID) ON DELETE CASCADE,
    Example_Citation TEXT NOT NULL, Why_This_Word TEXT, Translation_Choices TEXT,
    Source_Reliability TEXT, Verification_Notes TEXT
);
CREATE INDEX IF NOT EXISTS idx_senses_lemma ON Senses(Lemma_ID);
CREATE INDEX IF NOT EXISTS idx_constructions_sense ON Constructions(Sense_ID);
CREATE INDEX IF NOT EXISTS idx_citations_construction ON Citations(Construction_ID);

-- Lemma: γνῶσις
INSERT INTO Lemmas (
    Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field, Cross_Language_Connection, Modern_Resonance, Classical_Concept
) VALUES (
    'L006',
    'γνῶσις',
    'Ancient Greek',
    'From γιγνώσκω (''to come to know, recognize, perceive''), from the widespread Indo-European root *gno- (cf. Latin (g)noscere/cognoscere, English ''know'', ''ken'', ''can''). Descendants: English ''gnosis'', ''gnostic'', ''agnostic'' (ἀ- privative + γνῶσις/γνωστικός); Modern Greek γνώση (knowledge). Arabic has no cognate; renderings split across معرفة/علم (ordinary knowledge), تحقيق/بحث (inquiry), قرار/حكم (official finding), تعرّف (recognition), تعارف (acquaintance), معرفة روحية (spiritual knowledge), الغنوص (the technical/heresiological ''Gnosis''), and سجل/وثيقة (written record) — a very wide split, comparable to δίκη and ἀρετή.',
    'Knowledge/cognition, inquiry/investigation, an official finding/determination, recognition, personal acquaintance, spiritual/religious knowledge, the technical religious concept ''Gnosis'', a written record/administrative document, and (unverified, disputed) public fame/reputation.',
    'Directly parallel to Latin (co)gnitio/scientia, which likewise split ordinary knowledge from technical/legal ''cognizance'' (a legal hearing/determination) — English ''cognizance'' itself preserves exactly this legal-investigative sense alongside the ordinary-knowledge sense, mirroring γνῶσις''s own knowledge/inquiry/finding split almost precisely. English ''gnosis'' and ''agnostic'' (T.H. Huxley''s 1869 coinage, directly from ἄγνωστος) are direct un-translated borrowings of this word''s technical senses rather than translations — a rare case in this database where English simply imported the Greek term instead of finding a native equivalent.',
    '''Gnostic''/''Gnosticism'' as the standard scholarly term for the movements S047 names; ''agnostic'' (Huxley''s coinage) built directly on ἄγνωστος/γνῶσις to name a stance of principled non-knowledge, paralleling ancient ἄγνοια/ἀγνωσία. The knowledge/inquiry/finding split (S041-S043) directly parallels how modern English ''cognizance'' still carries both an everyday and a specifically legal sense.',
    'γνῶσις is a RADIAL network like λόγος and ἀρετή, but radiating along several genuinely independent pathways rather than one center: an epistemic/cognitive pathway (knowledge, opposed to ignorance and to mere opinion in Plato; opposed to praxis in Aristotle), an institutional/legal pathway (inquiry → official finding, closely paralleling δίκη''s judgment/lawsuit distinction), a relational pathway (recognition → acquaintance), and a religious-technical pathway (spiritual knowledge → the specific heresiological ''Gnosis''). DESIGN NOTE: two senses proposed in earlier analysis of this word are deliberately NOT promoted to independent Sense rows here: (1) γνῶσις as ''means/instrument of knowing'' is folded into S041 as a minor, loosely-attested extension rather than a distinct lexical sense; (2) ''being known/knowability'' is reframed entirely as a CONSTRUCTION-level point (subjective vs. objective genitive ambiguity with γνῶσις, documented in C035) rather than a separate sense, since this ambiguity is a general feature of virtually all Greek deverbal nouns (compare φόβος, ''fear'', equally ambiguous between ''X''s fear'' and ''fear of X'') and elevating ordinary genitive ambiguity to sense-status would be a category error, not a genuine semantic split. S049 (fame/reputation) is flagged as having weaker attestation confidence than the other senses and should be independently verified against LSJ before being taught as settled.'
);

-- Senses (9 rows)
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S041',
    'L006',
    'Knowledge, cognition (core sense, incl. philosophical/epistemological specialization)',
    'معرفة، علم، إدراك',
    'The broad, foundational sense: knowledge, knowing, cognitive grasp. In Plato this acquires real philosophical structure — γνῶσις is systematically opposed to ἀγνωσία/ἄγνοια (ignorance) and situated within an epistemological hierarchy involving being, non-being, and the intermediate realm of opinion (δόξα) — but this philosophical specialization is kept WITHIN this sense rather than split into its own row, since the underlying mental model (possessing/lacking correct cognitive grasp of something) does not actually change, only its systematic elaboration does. In Aristotle, γνῶσις is regularly opposed instead to πρᾶξις (action/practice) — the Nicomachean Ethics repeatedly insists its end is not γνῶσις but πρᾶξις, since ethical inquiry aims at becoming good, not merely knowing what goodness is. A minor, loosely-attested extension sometimes proposed (γνῶσις as ''the means/instruments of knowing'') is noted here rather than promoted to its own sense, given weaker and less consistent attestation as a genuinely distinct lexical meaning.',
    'Close to literal at its broadest (simply ''knowledge''); the Platonic being/non-being/opinion structure and the Aristotelian knowledge/practice contrast are both real philosophical elaborations of this same core sense, not separate senses in their own right.',
    'Antonym: ἄγνοια/ἀγνωσία (ignorance) — a stable technical opposition in Plato. Contrasted (not strictly antonym) with πρᾶξις (action/practice) in Aristotle''s ethical works, and with δόξα (opinion) in Plato''s epistemology, as the intermediate cognitive state between knowledge and ignorance.',
    'Central to Platonic epistemology (Republic''s sun/line/cave sequence; Cratylus''s argument that a stable object is required for γνῶσις to be possible at all, against Heraclitean flux) and to Aristotelian ethics (the recurring γνῶσις/πρᾶξις distinction throughout the Nicomachean Ethics).',
    NULL,
    'This is the default, safest first reading of γνῶσις in a philosophical text — but check immediately what it''s being opposed to (ἄγνοια? πρᾶξις? δόξα?), since that opposition tells you which specific philosopher''s technical elaboration of ''knowledge'' you''re reading.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S042',
    'L006',
    'Inquiry, investigation (esp. judicial/administrative)',
    'تحقيق، بحث، استقصاء',
    'γνῶσις as the PROCESS of finding something out, especially a formal/judicial or administrative inquiry — γνῶσις περὶ τῆς δίκης, ''inquiry concerning the case.'' The focus is on the institutional process of establishing facts, not on knowledge already possessed.',
    'A real conceptual shift from S041: ''what one knows'' (a possessed cognitive state) versus ''the process of finding something out'' (an ongoing institutional activity) are genuinely different kinds of thing, directly paralleling δίκη''s own state/act/process distinctions.',
    'Near-synonym: ζήτησις (inquiry, search), ἐξέτασις (examination) — γνῶσις in this sense carries more institutional/official weight than either.',
    'Prominent in legal and administrative Greek, especially Hellenistic and Roman-period documentary papyri from Egypt.',
    NULL,
    'In a legal or administrative context, γνῶσις is very likely naming the process of investigating a case, not a possessed piece of knowledge — check for nearby legal vocabulary (δίκη, δικαστής, etc.).'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S043',
    'L006',
    'Official finding, determination, decision',
    'قرار، نتيجة تحقيق، حكم',
    'Develops naturally from S042 (inquiry) but names the RESULT of that process — the official finding or determination an authority reaches after investigation, as distinct from the investigative process itself (S042) or a court''s formal verdict (compare δίκη''s own judgment sense).',
    'Process versus product: investigating (S042) versus the official determination that investigation produces (this sense) — the same process/product distinction already tested and confirmed for δίκη''s judgment/lawsuit/trial cluster.',
    'Near-synonym: κρίσις (judgment/decision) — γνῶσις in this administrative sense overlaps significantly with κρίσις''s institutional-determination sense.',
    'Prominent in Hellenistic and Roman-period administrative and legal documentary Greek, especially papyrological sources recording official rulings.',
    NULL,
    'If γνῶσις names a completed ruling or official determination rather than an ongoing process of investigation, you''re in this sense, not S042.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S044',
    'L006',
    'Recognition',
    'تعرّف، إدراك الهوية',
    'The verbal force of γιγνώσκω (''to recognize'') surfacing in the noun: the cognitive EVENT of recognizing someone or something, e.g. γνῶσις τοῦ οἰκείου, ''recognition of one''s own people/kin.'' This is not simply possessing information about someone, but the specific act of identifying them as who/what they are.',
    'A real shift from S041: ''knowing a fact'' versus ''recognizing a person/thing'' are different cognitive events — recognition specifically involves identifying something as already-familiar, which bare propositional knowledge does not require.',
    'Closely related to but distinct from S045 (acquaintance): recognition names the momentary event of identification, while acquaintance names the resulting ongoing state of familiarity.',
    NULL,
    NULL,
    'Ask whether the passage describes a moment of identifying/recognizing someone (this sense) or an ongoing familiarity with them (S045, acquaintance) — related but distinct.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S045',
    'L006',
    'Acquaintance, personal familiarity, relationship',
    'معرفة شخصية، تعارف، علاقة',
    'γνῶσις πρός τινα, ''acquaintance with someone'' — extending toward ongoing personal familiarity or relationship, distinct from propositional knowledge of a fact. Later Christian authors extend this relational sense toward intimate or covenantal ''knowing'' (paralleling how Hebrew yada'' functions relationally in prophetic and Pauline usage).',
    '''Knowledge of mathematics'' (S041, epistemic possession of information) versus ''acquaintance with a person'' (this sense, personal familiarity/relationship) are genuinely different mental models — one is about propositions, the other about a relationship with a person.',
    NULL,
    'Especially significant in later Christian usage, where relational/covenantal ''knowing'' (extending this ordinary-Greek acquaintance sense) becomes theologically loaded (compare 1 Corinthians 8:3, 13:12, and broader NT usage of related verbs for God ''knowing'' and being ''known'').',
    'γνῶσις πρός τινα — ''acquaintance with someone.''',
    'When γνῶσις concerns a PERSON rather than a fact or proposition, and especially when governed by πρός + accusative, you''re very likely in this relational/acquaintance sense, not S041''s propositional knowledge.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S046',
    'L006',
    'Spiritual or religious knowledge',
    'معرفة روحية، معرفة إلهية',
    'In biblical and early Christian Greek, γνῶσις frequently denotes more than neutral propositional information: knowledge of God, spiritual understanding, revealed truth. The Arabic rendering may remain the same as S041''s ordinary معرفة, but the mental model changes substantially — this is not ''having information'' but something closer to revelation, relationship, or transformative insight, often operating within a stable conceptual network alongside πίστις (faith), σοφία (wisdom), and ἐπίγνωσις (fuller/deeper knowledge).',
    'The Arabic test alone does not force a split here (both S041 and this sense may render as معرفة), but the conceptual-model test does: Aristotle''s γνῶσις (understanding nature or ethics) and a Christian mystical writer''s γνῶσις (transformative knowledge of God) are not the same kind of cognitive event, even when the same Arabic word covers both.',
    'Operates within a stable network alongside πίστις (faith), σοφία (wisdom), ἀγάπη (love), and ἐπίγνωσις (fuller knowledge) in Pauline and early Christian usage; contrasted with spiritual ignorance/blindness.',
    'New Testament and early Christian/patristic Koine usage, distinct in register from both Classical philosophical usage (S041) and the more specifically technical ''Gnosis'' of S047.',
    NULL,
    'In a New Testament or patristic religious context, γνῶσις is very likely doing more theological work than ''knowing facts'' — check whether it''s paired with πίστις, σοφία, or ἐπίγνωσις nearby, which signals this specifically religious register.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S047',
    'L006',
    'Gnosis — the technical religious/heresiological concept',
    'الغنوص، المعرفة الغنوصية',
    'When γνῶσις denotes the specialized concept associated with the Gnostic religious movements — a claimed esoteric, saving knowledge, often opposed by orthodox Christian writers as a false or counterfeit claim. Paul''s own polemical phrase ψευδώνυμος γνῶσις (''falsely-named knowledge,'' 1 Timothy 6:20) is directed at exactly this claim — the whole point of the phrase is to deny that what these teachers call γνῶσις deserves the name at all.',
    'A referential/technical split from S046, not merely ''more of the same'' religious knowledge: this sense names a specific claimed religious-philosophical SYSTEM (later labeled ''Gnosticism'' by scholars) rather than religious knowledge/understanding in general.',
    'Directly opposed, in orthodox polemical usage, to genuine πίστις and sound διδασκαλία (teaching) — the ψευδώνυμος (''falsely-named'') qualifier is itself doing antonym-like work, denying the term''s legitimacy rather than merely contrasting it with another term.',
    '1st-2nd century CE polemical/heresiological Christian usage (the Pastoral Epistles; later patristic writers like Irenaeus, whose Against Heresies is a sustained attack on movements making this claim).',
    'ψευδώνυμος γνῶσις — ''falsely-named knowledge'' (1 Timothy 6:20), the standard polemical label.',
    'If γνῶσις appears with ψευδώνυμος, or in a context explicitly attacking a rival teaching claiming secret/saving knowledge, you''re reading this specific technical-polemical sense, not general spiritual knowledge (S046).'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S048',
    'L006',
    'Written record, statement, list, or administrative document',
    'سجل، بيان، وثيقة، كشف',
    'In later documentary/administrative Greek (especially Hellenistic and Roman-period Egyptian papyri), γνῶσις can refer to a written report, official statement, certificate, list, or similar administrative record — no longer primarily a psychological/cognitive state at all, but a physical or documentary object.',
    'A complete shift from every psychological sense above: this names an administrative OBJECT (a document), not any kind of knowing, recognizing, or investigating.',
    NULL,
    'Distinctly late, documentary/papyrological Greek; a bureaucratic technical development largely absent from Classical literary usage.',
    NULL,
    'In a papyrus or administrative document, γνῶσις may simply mean ''the written record/statement'' itself, not any psychological state — a genre-specific technical sense worth recognizing on sight in documentary contexts.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S049',
    'L006',
    'Fame, reputation, public recognition (UNVERIFIED — treat with caution)',
    'شهرة، صيت، سمعة (غير مؤكد)',
    'A proposed later development along the lines ''know → be known → be widely known → fame.'' This entry has WEAKER attestation confidence than the other senses here — γνῶσις specifically (as opposed to related but distinct words like δόξα or κλέος, the standard Greek terms for fame/glory) is not confidently confirmed by this entry as bearing this sense in any specific verified passage. Included provisionally, pending direct LSJ/TLG verification, rather than asserted as settled.',
    NULL,
    'Compare δόξα, κλέος — the standard, well-attested Greek terms for fame/glory; if this sense of γνῶσις is confirmed, it would be an unusual semantic overlap with these more standard terms.',
    NULL,
    NULL,
    'Treat this sense with real skepticism until verified — if you encounter γνῶσις translated as ''fame'' somewhere, check the primary source and LSJ directly rather than assuming this entry confirms it.'
);

-- Constructions (6 rows)
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C030',
    'S041',
    'ἐπὶ μὲν τῷ ὄντι γνῶσις ἦν, ἀγνωσία δ'' ἐξ ἀνάγκης ἐπὶ μὴ ὄντι (Republic V, 477a-b) — ''knowledge was set upon what is, and ignorance necessarily upon what is not'' — ἐπί governing the dative to mark the ontological ground of the cognitive state.',
    'Dative (governed by ἐπί).',
    'ἐπί + dative here marks the object/ground a cognitive state (γνῶσις or ἀγνωσία) is ''set upon'' or grounded in — a foundational/basis relation. Greek could in principle use a bare genitive of the object known instead, but Plato''s epistemological architecture here requires marking knowledge and ignorance as each strictly correlated with a specific ontological status (being vs. non-being) — the ἐπί+dative expresses this foundational correlation more precisely than a bare genitive would.',
    'Students may read ἐπί here as simply locational (''upon'') without registering that Plato is making a precise epistemological claim: each cognitive state is strictly correlated with a specific ontological status, not loosely ''about'' or ''concerning'' it.',
    'τῷ ὄντι, dative singular neuter participle of εἰμί (''being,'' substantivized); τῷ μὴ ὄντι, its negated counterpart.',
    'Adverbial prepositional phrase, marking the ontological ground/basis of the cognitive state named by the subject noun (γνῶσις/ἀγνωσία).',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C031',
    'S041',
    'τὸ τέλος ἐστὶν οὐ γνῶσις ἀλλὰ πρᾶξις (Nicomachean Ethics) — ''the end/goal is not knowledge but action/practice'' — two abstract nouns as coordinated/contrasted predicate nominatives under an οὐ...ἀλλά (''not...but'') construction.',
    'Nominative (both predicate nouns).',
    'Not primarily a case-choice teaching point — both nouns are ordinary predicate nominatives agreeing with the subject τὸ τέλος. The real teaching value is the οὐ...ἀλλά antonym-pair construction itself: this is the standard Greek pattern for asserting a strong technical opposition between two terms (compare δίκη''s antonym pair with βία, and ἀρετή''s with κακία), and recognizing the pattern signals that γνῶσις and πρᾶξις are being set up as a stable, load-bearing technical opposition central to Aristotle''s whole ethical argument, not an incidental word choice.',
    'A reader unfamiliar with Aristotle''s broader argument might treat this as a passing remark rather than recognizing that the γνῶσις/πρᾶξις opposition recurs throughout the Nicomachean Ethics and is central to Aristotle''s claim that ethics is a practical, not merely theoretical, discipline.',
    'γνῶσις, nominative singular; πρᾶξις, nominative singular.',
    'Both are predicate nominatives agreeing with the subject τὸ τέλος, coordinated antonymically by οὐ...ἀλλά.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C032',
    'S043',
    'γνῶσις περὶ (τῆς δίκης / τοῦ πράγματος) — ''a finding/determination concerning (the case/the matter),'' περί governing the genitive to mark the topic the official determination concerns.',
    'Genitive (governed by περί).',
    'περί + genitive is the standard Greek construction for ''concerning, about, regarding'' a topic — here marking the specific matter or case an official γνῶσις (finding) has been reached about, distinguishing this administrative sense from the bare genitive-of-specification pattern already documented elsewhere in this database (cf. ἀρετή''s C024/C025/C026), since here a preposition IS present rather than a bare genitive alone.',
    'Students should not assume this περί+genitive works identically to the bare adnominal genitives built elsewhere (λόγος, ψυχή, ἀρετή) — the presence of περί here specifically marks ''concerning/about,'' a distinct genitive-governing relationship from an unmarked adnominal genitive of specification.',
    'τῆς δίκης / τοῦ πράγματος, genitive singular, governed by περί.',
    'Adverbial prepositional phrase modifying γνῶσις, marking the matter the official finding concerns.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C033',
    'S045',
    'γνῶσις πρός τινα — ''acquaintance with someone,'' πρός governing the accusative to mark the person one has a relationship of familiarity with.',
    'Accusative (governed by πρός).',
    'πρός + accusative here marks a relational orientation toward a person — the same directional/relational core sense of πρός + accusative already documented for λόγος''s C004 (πρὸς τὸν θεόν, the Logos''s relation to God) and now recurring in a different lemma to mark ordinary human acquaintance rather than a theological relation. Recognizing this recurring πρός+accusative relational pattern across multiple words is itself a mature cross-lemma reading skill.',
    'Students may default to reading πρός+accusative here as simple physical direction (''toward'') rather than recognizing the relational-acquaintance sense — the same pitfall already flagged for λόγος''s C004, now recurring.',
    'τινα, accusative singular of τις, governed by πρός.',
    'Adverbial prepositional phrase modifying γνῶσις, marking the person the acquaintance/relationship is with.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C034',
    'S047',
    'ψευδώνυμος γνῶσις — ''falsely-named knowledge'' (1 Timothy 6:20), an attributive compound adjective (ψευδο- + ὄνομα, ''false-name'') modifying γνῶσις to name and simultaneously delegitimize the specific technical/heresiological sense.',
    'Nominative (citation form); adjective agrees with γνῶσις in whatever case the sentence requires.',
    'Not a case-choice teaching point — the real signal is the same attributive-adjective naming pattern already documented for νόμος ὄρθιος (a musical genre-name) and δίκη/ἀρετή''s personification patterns: a specific attributive adjective attached to an otherwise ordinary noun signals that a specialized technical sense, rather than the ordinary sense, is intended. Here the adjective additionally does polemical work: ψευδώνυμος doesn''t just name a variety of γνῶσις, it denies the variety deserves the name at all.',
    'A reader might parse ψευδώνυμος as simply descriptive (''knowledge which happens to be falsely named by others'') rather than recognizing the polemical force: the phrase is Paul''s own dismissal of a rival teaching''s self-description, not a neutral label.',
    'ψευδώνυμος, -ον, 2nd declension adjective (compound of ψεῦδος + ὄνομα), agreeing with γνῶσις (here genitive, τῆς ψευδωνύμου γνώσεως, governed by the surrounding clause).',
    'Attributive adjective modifying γνῶσις, together forming a polemical technical label.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C035',
    'S041',
    'τὴν τοῦ σώματος γνῶσιν (Nicomachean Ethics) — ''knowledge OF the body'' (an objective genitive: the body is what is known, not the knower) — illustrating the general subjective/objective genitive ambiguity that applies to γνῶσις exactly as it does to any Greek deverbal noun (compare φόβος, ''fear'', equally ambiguous between ''X''s fear'' and ''fear of X'').',
    'Genitive (τοῦ σώματος).',
    'This is specifically an OBJECTIVE genitive: the body is the THING KNOWN, not an entity that itself possesses knowledge (which would be a subjective genitive reading, ''the body''s own knowledge'' — nonsensical here given the context of doctors studying the body). Recognizing which reading is intended depends entirely on context and plausibility, not on any difference in the genitive''s form — Greek does not morphologically distinguish subjective from objective genitives, which is precisely why this ambiguity is worth flagging as a general construction-level point rather than treating ''being known'' as a separate lexical sense of γνῶσις itself (as sometimes proposed) — the ambiguity belongs to the genitive construction generally, not to this noun specifically.',
    'Students encountering an unfamiliar X+genitive+γνῶσις phrase should actively check both readings (subjective: ''X''s knowledge''; objective: ''knowledge of X'') and use context to decide, rather than assuming one direction by default — this ambiguity is genuinely common across Greek deverbal nouns generally, not a quirk specific to this word.',
    'τοῦ σώματος, genitive singular of σῶμα (body).',
    'Adnominal genitive dependent on γνῶσιν, here functioning objectively (marking the thing known).',
    NULL
);

-- Citations (6 rows)
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit031',
    'C030',
    'Plato, Republic V, 477a-b — ἐπὶ μὲν τῷ ὄντι γνῶσις ἦν, ἀγνωσία δ'' ἐξ ἀνάγκης ἐπὶ μὴ ὄντι (''knowledge was set upon what is, and ignorance necessarily upon what is not'') — part of the sun/line/cave epistemological sequence distinguishing knowledge, opinion, and ignorance by their correlated objects.',
    'Plato needs a term whose CORRELATION with an ontological status (being vs. non-being) can be precisely marked by the ἐπί+dative construction — γνῶσις is chosen specifically because the argument depends on treating knowledge and ignorance as each strictly grounded in a different kind of object, not merely differing in degree of certainty.',
    'المعرفة قائمة على الموجود، والجهل بالضرورة على غير الموجود — a philosophically precise Arabic rendering preserving the foundational/grounding relation rather than a looser ''knowledge concerns X.''',
    'Plato, Republic, ed. Slings (OCT), Book V, Stephanus 477a-b (based on directly excerpted text).',
    'CONFIRMED via direct textual excerpt. Exact Stephanus line boundaries still worth double-checking against the OCT for a publication-grade citation, but the wording and content are grounded in real attested text, not paraphrase alone.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit032',
    'C031',
    'Aristotle, Nicomachean Ethics I (Bekker ~1095a, context) — ἐπειδὴ τὸ τέλος ἐστὶν οὐ γνῶσις ἀλλὰ πρᾶξις (''since the end/goal is not knowledge but action'').',
    'Aristotle is making a foundational methodological claim for the whole Ethics: ethical inquiry is a practical discipline, not a theoretical one, and he needs γνῶσις specifically (rather than a narrower term like θεωρία, though closely related) to name the kind of merely-contemplative outcome he is explicitly setting the whole discipline against.',
    'فالغاية ليست معرفة بل عملًا — a direct Arabic rendering preserving the same nominative antonym-pair structure as the Greek.',
    'Aristotle, Nicomachean Ethics, ed. Bywater (OCT), Bekker ~1095a (based on directly excerpted text).',
    'CONFIRMED via direct textual excerpt. Exact Bekker line reference still worth double-checking against the OCT for a publication-grade citation.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit033',
    'C032',
    'Formulaic across Hellenistic/Roman-period Egyptian administrative and legal papyri — γνῶσις περὶ (τοῦ πράγματος/τῆς δίκης) as a technical phrase for an official finding concerning a specific case or matter, without one single canonical literary locus.',
    'The administrative/papyrological register consistently uses γνῶσις rather than a purely literary term for this specific technical function — recognizing the genre (documentary papyrus) is itself the main signal for this sense.',
    'قرار بشأن / حكم بخصوص',
    'General usage pattern in documentary papyri (cf. published collections such as the Papyri Graecae Berolinenses or P.Oxy. volumes).',
    'FLAG: describes a usage pattern rather than one verbatim citation — pin to a specific published papyrus (with its standard P.Oxy./P.Berol. reference number) and verify exact wording before publishing a specific citation.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit034',
    'C033',
    'Formulaic across Classical and Koine Greek — γνῶσις πρός τινα, ''acquaintance with someone,'' a recurring construction rather than tied to one canonical locus.',
    'The πρός+accusative pattern is productively available across genres and periods for marking personal acquaintance, directly paralleling the same construction''s relational use elsewhere in this database (cf. λόγος''s πρὸς τὸν θεόν, C004).',
    'معرفة به / تعارف معه',
    'General usage pattern across Classical and Koine Greek.',
    'FLAG: describes a productive construction pattern, not one verbatim citation — select a specific attested instance and verify exact wording against TLG before publishing a pinned example.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit035',
    'C034',
    '1 Timothy 6:20 — ὦ Τιμόθεε, τὴν παραθήκην φύλαξον, ἐκτρεπόμενος τὰς βεβήλους κενοφωνίας καὶ ἀντιθέσεις τῆς ψευδωνύμου γνώσεως (''O Timothy, guard what has been entrusted to you, turning away from worldly chatter and the contradictions of what is falsely called knowledge'').',
    'The author names the rival teaching''s central claim explicitly (γνῶσις) precisely in order to deny it — using the target''s own preferred self-description before undercutting it with ψευδώνυμος is a deliberate polemical strategy, not an incidental word choice.',
    'المعرفة المزعومة كذبًا / الغنوص الكاذب — modern scholarly Arabic discussions of Gnosticism typically transliterate الغنوص for the movement itself, while a translation of this specific verse would render the phrase descriptively.',
    'Novum Testamentum Graece (Nestle-Aland), 1 Timothy 6:20.',
    'This is a well-established, non-disputed reading; low textual-critical risk for this specific verse, though double-check exact wording against Nestle-Aland before a publication-grade quotation.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit036',
    'C035',
    'Aristotle, Nicomachean Ethics I (Bekker ~1102a, context) — οἱ χαρίεντες (τῶν ἰατρῶν) πολλὰ πραγματεύονται περὶ τὴν τοῦ σώματος γνῶσιν (''the more refined among doctors concern themselves greatly with knowledge of the body'').',
    'τοῦ σώματος functions as an objective genitive (the body is what is known, not a knower) — Aristotle is arguing by analogy that just as good doctors need real knowledge OF the body, the political philosopher needs real knowledge of the soul, making correct resolution of this genitive''s direction essential to following the analogy.',
    'معرفة الجسد (بوصفه موضوع المعرفة، لا صاحبها) — an Arabic rendering that could preserve the same genitive ambiguity as the Greek, so a translator''s note clarifying the objective-genitive reading is genuinely useful here.',
    'Aristotle, Nicomachean Ethics, ed. Bywater (OCT), Bekker ~1102a (based on directly excerpted text).',
    'CONFIRMED via direct textual excerpt. Exact Bekker line reference still worth double-checking against the OCT for a publication-grade citation.'
);
