-- Classical Language Database — ψυχή (L003), full detail
-- Run AFTER logos (L001) and nomos (L002) are already loaded.
-- 4 of the 10 senses (S014 Orphic, S015 ordinary-self, S018 Stoic, S021 butterfly) intentionally
-- have NO Construction/Citation rows in this pass -- consistent with "not every sense needs one."

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

-- Lemma: ψυχή
INSERT INTO Lemmas (
    Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field, Cross_Language_Connection, Modern_Resonance, Classical_Concept
) VALUES (
    'L003',
    'ψυχή',
    'Ancient Greek',
    'From ψύχω, ''to breathe, blow, cool'' — originally ''the breath'' as sign and cause of life. Descendants: English ''psyche'', ''psychology'', ''psychiatry'', ''psychosomatic''; Modern Greek ψυχή (soul). No direct Arabic cognate; renderings split across نفس, روح, ذات, شخص, حياة depending on sense (see Classical_Concept design note).',
    'Life-breath, the departing life-principle, the transmigrating immortal soul, the psychological self, the rational/moral self (Platonic), the form/actuality of a living body (Aristotelian), material pneuma (Stoic), a counted individual/person, the ''soulish'' as opposed to ''spiritual'' (Pauline), a butterfly.',
    'Latin anima (breath/soul) and animus (mind/spirit) split some of what ψυχή covers, similar to how Latin splits λόγος across ratio/oratio. Arabic نفس (nafs) and روح (rūḥ) each carry their own independent theological/philosophical histories in Islamic thought and only partially overlap with any single sense here — a caution against assuming a one-to-one Greek-Arabic mapping.',
    '''Psychology'', ''psyche'', ''psychiatry'', ''psychosomatic'' descend directly from this word. The Homer-to-Plato shift is a foundational case study in the history of the concept of mind/self, referenced across modern philosophy of mind (see Bremmer, The Early Greek Concept of the Soul; Claus, Toward the Soul).',
    'ψυχή is less a single concept than a word that hosted a sequence of substantially different concepts across Greek intellectual history: Homer''s thin departing life-shadow, Orphic/Pythagorean immortal transmigration, Plato''s structured rational self, Aristotle''s biological form/actuality, Stoic material pneuma. DESIGN NOTE: unlike λόγος and νόμος, where a different Arabic word usually signaled a different sense, most of ψυχή''s philosophically loaded senses render as the same Arabic word (النفس) despite naming fundamentally different kinds of thing — disambiguation rests on Nuance_Context and Author_Period_Nuance, not on Primary_Arabic_Definition. A third splitting criterion is used throughout this entry: split two uses when competent understanding requires positing a fundamentally different answer to ''what kind of thing is ψυχή here?'' (the conceptual-model test), and split when a word''s meaning is fixed by a stable technical opposition (as with S020''s ψυχή/πνεῦμα).'
);

-- Senses (10 rows)
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S012',
    'L003',
    'Life / vital existence (the life that can be lost)',
    'نفس، حياة',
    'The broad, non-technical sense across all periods: ψυχή as one''s life itself, the thing at stake when ''risking'' or ''saving'' one''s ψυχή (κινδυνεύειν περὶ ψυχῆς). Covers both ''animating life-force'' and ''continued existence'' — these do not need separate Arabic words or separate mental models, so they are merged into one sense here rather than split.',
    'Close to literal: ''life'' as what one has and can lose, without yet invoking Homer''s postmortem-shade model or Plato''s structured-self model.',
    'Near-synonym: ζωή (life, more abstract/biological). Antonym: θάνατος (death).',
    'Common across all periods and genres as the default ''life at stake'' sense — the ground floor that Homeric, Orphic, and philosophical senses all build on or depart from.',
    'κινδυνεύειν περὶ (τῆς) ψυχῆς — ''to risk one''s life''; ψυχὴν διδόναι/τιθέναι ὑπέρ (τινος) — ''to give/lay down one''s life for (someone).''',
    'Whenever ψυχή just means ''life'' in a risk-it-or-lose-it sense — no shade in Hades, no tripartite theory — this is the sense, and the safest first guess outside a clearly religious or philosophical passage.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S013',
    'L003',
    'Homeric death-survivor',
    'النفس/الروح التي تفارق الجسد (best glossed as a phrase; no single Arabic word captures this specifically Homeric model)',
    'In Homer, ψυχή is emphatically NOT the seat of a living person''s thought, emotion, or character — those belong to νόος, θυμός, and φρένες. ψυχή becomes salient only at death: it departs (through the mouth or a wound) and survives in Hades as a thin, witless εἴδωλον (''image/shade'') of the once-living person, capable of fluttering and squeaking but not coherent thought (cf. Odysseus''s encounter with the shades, Odyssey 11).',
    'Arguably the LEAST metaphorically extended sense in the whole entry, yet the hardest for a modern reader to intuit correctly — the natural assumption that ''soul'' means ''inner self'' actively misleads here. Suppress Platonic/Christian associations the English word ''soul'' carries.',
    'Contrast (not synonym): θυμός (seat of emotion/impulse in the living), νόος (mind/perception in the living), φρένες (seat of practical thought) — all do work while alive that ψυχή in Homer does not.',
    'Distinctly and exclusively Homeric/early epic; already being supplemented (not replaced) by the time of Orphic and Pythagorean religious movements a few centuries later.',
    NULL,
    'If you''re reading Homer, resist translating ψυχή as ''soul'' in the modern sense — think ''the thing that leaves you at death and becomes a faint ghost,'' nothing psychological.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S014',
    'L003',
    'Orphic/Pythagorean immortal transmigrating soul',
    'الروح الخالدة، النفس المتناسخة',
    'A religious-eschatological development, not yet a philosophical theory: the ψυχή is genuinely immortal, separable from any one body, and passes through successive bodies (metempsychosis) according to ritual purity and accumulated guilt. Best sourced from primary Orphic/Pythagorean religious evidence (e.g. the Orphic gold funerary tablets addressing the deceased''s ψυχή with afterlife instructions) rather than from Plato, whose own transmigration myths (Republic X''s Myth of Er; the Phaedrus charioteer myth) are Plato redeploying this older religious material inside a philosophical argument — a distinct project from the source tradition.',
    'A major conceptual leap from S013: the Homeric shade is faint, passive, and terminal; the Orphic/Pythagorean ψυχή is active, morally accountable, and repeatedly reincarnated.',
    NULL,
    'Archaic-through-Classical religious movements (Orphism, Pythagoreanism), 6th c. BCE onward; historically prior to and a direct influence on Plato''s use of the same imagery, but analytically distinct from Plato''s philosophical elaboration (S016).',
    NULL,
    'When you meet transmigration/reincarnation language, ask whether the text is doing religious doctrine (this sense) or philosophical argument dressed in that doctrine''s imagery (Plato, S016) — same vocabulary, different projects. [FLAG: primary tablet Greek not quoted here pending verification against a critical edition, e.g. Graf & Johnston, Ritual Texts for the Afterlife.]'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S015',
    'L003',
    'Ordinary inner self / psychological self',
    'النفس، الذات',
    'Widespread post-Homeric, non-technical usage: ψυχή as the ordinary seat of emotion, desire, courage, or personal experience in everyday and literary Greek — ''his ψυχή was troubled,'' ''a noble ψυχή.'' Not yet a philosophical theory (contrast S016); the natural-language psychological vocabulary any competent Greek speaker used outside a technical philosophical context.',
    'A real semantic expansion beyond S013 — by the Classical period ψυχή has absorbed psychological work Homer distributed across θυμός/νόος/φρένες — but remains pre-theoretical: no claim about immortality, structure, or metaphysical status is implied.',
    'Overlaps loosely with καρδία (heart, more restricted to emotion) and θυμός (narrower emotional-impulse sense in Classical Greek).',
    'Pervasive in tragedy, oratory, and everyday Classical prose; the necessary semantic bridge between Homer (S013) and the technical philosophical senses (S016-S018).',
    NULL,
    '''His ψυχή was troubled'' (ordinary Greek) is not making a claim about the tripartite soul or immortality — don''t read philosophical technicality into every occurrence outside Plato/Aristotle/the Stoics.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S016',
    'L003',
    'Platonic rational, structured, immortal self',
    'النفس بوصفها الذات العاقلة والحقيقية',
    'Plato''s fullest technical sense (esp. Phaedo, Republic): ψυχή is the essential self — it reasons, desires, experiences internal conflict, bears moral responsibility, pre-exists and survives the body, and (Republic IV, 439d-441c) has internal structure: λογιστικόν (rational part), θυμοειδές (spirited part), ἐπιθυμητικόν (appetitive part). Not an expansion of S015 so much as a technical theory built using that sense''s vocabulary.',
    'By the conceptual-model test: a reader who pictures the Homeric shade or the ordinary-Greek ''inner feelings'' sense while reading the Republic''s tripartite argument has not understood the passage — this requires a genuinely different mental model.',
    'Antonym within Plato''s own scheme: σῶμα (body) — the ψυχή/σῶμα dualism is foundational to the Phaedo''s argument for the soul''s immortality and superiority to bodily concerns.',
    'Distinctly Platonic (5th-4th c. BCE); inherits and philosophically reworks Orphic/Pythagorean transmigration material (S014) without being identical to it.',
    NULL,
    'If you see λογιστικόν/θυμοειδές/ἐπιθυμητικόν or a reasoned argument for the soul''s pre-existence and immortality, you''re in Plato''s specific theory — don''t collapse this with the ordinary ''his soul was troubled'' sense.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S017',
    'L003',
    'Aristotelian form/actuality of a living body',
    'النفس بوصفها صورة الجسم الحي ومبدأ وظائفه',
    'Aristotle (De Anima II.1) redefines ψυχή as the entelecheia (''actuality,'' ''realized form'') of a naturally organized body possessing the potential for life — not a separable substance haunting the body (contrast S016) but the organizing principle making a body the kind of living thing it is. Graded across nature: nutritive ψυχή in plants, additionally sensitive in animals, additionally rational in humans.',
    'A substantial technical redefinition, not a specialization of S016: Aristotle''s ψυχή is not immortal or separable from body at all, and applies to plants and animals in a real, non-metaphorical way — Plato''s ψυχή is not distributed across nature this way.',
    'Technical near-synonym: entelecheia, morphē (form) — as opposed to hylē (matter), body apart from its organizing form.',
    'Distinctly Aristotelian (4th c. BCE), explicitly reacting against and revising the Platonic model rather than simply extending it.',
    NULL,
    'In Aristotle, ψυχή is closer to ''what makes this particular body a living X'' than to ''ghost inside the machine'' — resist importing Plato''s separable-soul picture when reading De Anima.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S018',
    'L003',
    'Stoic material pneuma-soul',
    'النفس المادية',
    'The Stoics (reported chiefly through later doxography, e.g. Diogenes Laertius Book 7) held ψυχή to be pneuma — a material, breath-like substance pervading and animating the organism — a thoroughgoing materialist psychology sharply distinct from Plato''s immaterial separable soul and Aristotle''s non-material form/actuality.',
    'The decisive conceptual-model difference from S016/S017: this ψυχή is stuff, not an immaterial substance (Plato) or a form (Aristotle) — a real ontological disagreement, not a difference in emphasis.',
    'Technical Stoic term: pneuma (breath/spirit-substance) — near-synonymous with ψυχή in this school''s vocabulary.',
    'Hellenistic Stoicism (3rd c. BCE onward); known to us mostly secondhand through later summarizers rather than extensive surviving primary Stoic texts on psychology specifically.',
    NULL,
    'If a text calls the soul ''pneuma'' and treats it as a material substance rather than an immaterial form or separable entity, you''re almost certainly reading Stoic psychology. [FLAG: exact Diogenes Laertius wording not quoted here — verify against Loeb/OCT before citing verbatim.]'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S019',
    'L003',
    'Person, individual, human being (headcount sense)',
    'شخص، إنسان',
    'ψυχή functioning as a plain counting-noun for a person — ''three thousand ψυχαί'' means ''three thousand people,'' not a theological claim about souls (cf. English census usage ''three thousand souls''). The semantic path is the ordinary life → living being → individual person extension found in many languages.',
    'A clean case where the Arabic test alone decisively forces a split: none of النفس/الروح fit naturally here, where شخص/إنسان is needed instead.',
    'Synonym in this counting function: ἄνθρωπος (human being), though without the same headcount/census connotation.',
    'Attested across genres wherever population counts occur; prominent in the Septuagint/NT (e.g. Acts 2:41) reflecting Hebrew nephesh''s parallel headcount usage, suggesting reinforcement from translation Greek rather than purely native development.',
    NULL,
    'A number directly in front of ψυχαί (plural) is your signal: this is ''people,'' not ''souls'' in any philosophical or religious sense.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S020',
    'L003',
    'Pauline ψυχή, contrasted with πνεῦμα',
    'النفس (في مقابل الروح)',
    'Paul establishes a technical anthropological opposition ψυχή/πνεῦμα (soul/spirit) not present in classical philosophical usage — 1 Thessalonians 5:23 addresses ''spirit and soul and body'' (πνεῦμα καὶ ψυχή καὶ σῶμα) as three distinguishable components, and 1 Corinthians contrasts ψυχικός (''soulish''/natural) with πνευματικός (''spiritual'') as two different modes of existence (1 Cor 2:14, 15:44). A stable technical opposition specific to Pauline anthropology, not classical philosophy''s tripartite scheme (S016) or Aristotle''s hierarchy (S017).',
    'Following the house rule established for this database (a word that acquires its meaning from a stable technical opposition earns a separate sense): ψυχή here is defined relationally, against πνεῦμα, in a way none of the classical senses are.',
    'Defining antonym/counterpart: πνεῦμα (spirit) — the entire sense is constituted by this contrast.',
    'Distinctly Pauline/early Christian Koine usage (1st c. CE); draws on but reorganizes the existing Greek psychological vocabulary (S015) into a new binary scheme.',
    'ψυχικὸς ἄνθρωπος — ''the natural/soulish person'' (1 Cor 2:14), contrasted with ὁ πνευματικός — ''the spiritual person.''',
    'In Paul, don''t assume ψυχή = the classical philosophical soul — check whether πνεῦμα is doing contrastive work nearby; if so, you''re in this specific technical scheme.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S021',
    'L003',
    'Butterfly',
    'فراشة',
    'A genuinely attested zoological sense, historically and symbolically connected to the ''soul'' senses (a butterfly''s emergence from a chrysalis was read as an image of the soul''s release from the body — hence Psyche''s traditional depiction with butterfly wings in the Cupid-and-Psyche tradition), but synchronically an entirely separate lexical item requiring no philosophical apparatus at all.',
    'No literal/contextual tension — this sense simply names an insect.',
    NULL,
    'Attested in Aristotle''s zoological works (Historia Animalium) among other sources discussing insect life-cycles; essentially unconnected in actual usage to any philosophical/religious sense above despite the shared word and the later poetic symbolism connecting them.',
    NULL,
    'If ψυχή shows up in a passage discussing caterpillars, chrysalises, or insect metamorphosis, it means ''butterfly'' — effectively a different word, just spelled the same. [FLAG: exact Historia Animalium passage not pinned here — verify book/chapter against Loeb/OCT before publishing a specific citation.]'
);

-- Constructions (6 rows)
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C012',
    'S012',
    'τὴν ψυχὴν τιθέναι ὑπέρ (τινος) — ''to lay down one''s life on behalf of/for (someone),'' accusative direct object ψυχήν + ὑπέρ governing the genitive.',
    'Accusative (ψυχήν, object of τιθέναι) + genitive (governed by ὑπέρ).',
    'ὑπέρ+genitive means ''on behalf of, for the sake of'' (benefactive/advocacy sense); ὑπέρ can also govern the accusative, but there means something different — ''over, beyond, exceeding'' (spatial/comparative). The genitive here is what makes the phrase mean self-sacrifice for someone''s benefit rather than a comparative sense — case governs which of ὑπέρ''s two meanings is active.',
    'Students who know ὑπέρ mainly from compounds like ὑπερβολή (''excess'') may default to the ''beyond/exceeding'' sense even when the genitive signals the benefactive sense instead — check the case before assuming which ὑπέρ you have.',
    'τὴν ψυχήν, accusative singular of ψυχή, -ῆς, ἡ (1st declension feminine); τῶν φίλων, genitive plural governed by ὑπέρ.',
    'ψυχήν = direct object of τιθέναι; the ὑπέρ-phrase is an adverbial prepositional phrase of benefit/advocacy.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C013',
    'S013',
    'πολλὰς ... ψυχὰς Ἄϊδι προΐαψεν (Iliad 1.3) — ''sent forth many souls to Hades,'' ψυχάς as accusative plural direct object, Ἄϊδι a bare dative of destination without a preposition.',
    'Accusative plural (ψυχάς, object of προΐαψεν) + dative (Ἄϊδι, destination).',
    'The bare dative Ἄϊδι functioning as ''to Hades'' without a preposition is a distinctly epic/poetic usage — Classical prose would require εἰς ᾍδου (accusative with preposition) for the same idea. Recognizing this as archaic/poetic Greek, rather than assuming Classical prose rules, is the main teaching point.',
    'A student trained on Attic prose may look for a missing preposition before Ἄϊδι and assume corruption — this bare dative-of-destination pattern is a genuine, well-attested feature of Homeric syntax, not an anomaly to correct.',
    'ψυχάς, accusative plural of ψυχή; Ἄϊδι, dative singular of Ἅιδης (Hades), epic form.',
    'ψυχάς = direct object of προΐαψεν (''sent forth''); Ἄϊδι = dative of destination modifying the verb.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C014',
    'S016',
    'τρία ... ἐν τῇ ψυχῇ εἴδη (Republic 439d ff.) — ''three forms/parts within the soul,'' ψυχῇ as dative governed by ἐν, marking the soul as a bounded container with internal parts.',
    'Dative (governed by ἐν).',
    'ἐν+dative is the standard construction for static location ''within'' something — Plato is doing real conceptual work with ordinary grammar here: treating ψυχή as a spatial container things can be ''in,'' part of what makes the tripartite theory intelligible as a structural claim. A bare genitive (τῆς ψυχῆς without ἐν) would mark possession/belonging instead, losing the container image the argument depends on.',
    'Easy to read ἐν τῇ ψυχῇ as a throwaway prepositional phrase rather than noticing the container metaphor it establishes is doing real argumentative work for the rest of the tripartite theory.',
    'τῇ ψυχῇ, dative singular of ψυχή, governed by ἐν.',
    'Adverbial prepositional phrase of location, modifying εἴδη (''forms/parts'') existing ''within'' the soul.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C015',
    'S017',
    'ψυχή ... ἐντελέχεια ... σώματος (De Anima II.1, 412a-b) — ψυχή identified via a predicate nominative (ἐντελέχεια) with a dependent genitive (σώματος) specifying the actuality of what.',
    'Genitive (σώματος, dependent on ἐντελέχεια).',
    'A genitive of specification: marks the entity whose actuality/realized-form is being named (''actuality OF a body''), not a genitive of source (''actuality FROM a body,'' which would wrongly suggest the body produces the actuality rather than the actuality being realized in and constituting the body''s living state).',
    'Students may read σώματος as a source-genitive (''coming from the body'') given how often genitives mark origin elsewhere — here it marks the possessor/bearer of the form being defined, subtly different and directly relevant to correctly understanding Aristotle''s non-dualist claim.',
    'σώματος, genitive singular of σῶμα (body), 3rd declension neuter; ἐντελέχεια, nominative singular predicate noun.',
    'σώματος = adnominal genitive dependent on ἐντελέχεια, itself a predicate nominative identified with ψυχή.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C016',
    'S019',
    'ψυχαὶ ... τρισχίλιαι (Acts 2:41) — ''about three thousand souls/people,'' ψυχαί in the nominative plural functioning as a countable head noun modified by a cardinal number, not as an abstract mass noun.',
    'Nominative plural.',
    'Not primarily a case-choice point (ordinary nominative subject) — the real signal is number and countability: ψυχή in its philosophical/religious senses is typically an abstract/mass noun, rarely counted with cardinals; its appearance here as a directly countable plural head noun is itself the grammatical marker flagging the headcount sense, not case morphology alone.',
    'A student who reads ''three thousand souls'' and immediately imports a theological reading (saved souls, a count of the redeemed) risks missing that the construction does the same job as English ''three thousand people'' — the theological resonance is a later interpretive layer, not inherent to the Greek construction.',
    'ψυχαί, nominative plural of ψυχή; τρισχίλιαι, nominative plural cardinal numeral agreeing with it.',
    'ψυχαί = subject noun, directly quantified by the cardinal numeral τρισχίλιαι.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C017',
    'S020',
    'τὸ πνεῦμα καὶ ἡ ψυχὴ καὶ τὸ σῶμα (1 Thess 5:23) — three coordinate nominative nouns (πνεῦμα, ψυχή, σῶμα) forming a tripartite anthropological formula, each agreeing with the predicate ὁλόκληρον (''whole, entire'').',
    'Nominative (all three coordinated subject nouns).',
    'Not a complex case-choice point — the teaching value is in the coordination itself: placing ψυχή as a distinct nominative subject alongside πνεῦμα and σῶμα, rather than treating it as encompassing or synonymous with πνεῦμα, is what establishes the specifically Pauline three-part anthropology as a real grammatical claim, not just rhetorical piling-up of near-synonyms.',
    'A reader may assume πνεῦμα and ψυχή are loose synonyms used for rhetorical emphasis (a common pattern elsewhere in Greek) rather than recognizing that Paul elsewhere (1 Cor 2:14, 15:44) treats this pairing as a load-bearing technical distinction — the coordination should be read as doctrinally intentional given that pattern.',
    'τὸ πνεῦμα (neuter), ἡ ψυχή (feminine), τὸ σῶμα (neuter) — three nominative singular nouns of different genders/declensions, coordinated by καί.',
    'All three are coordinate subject nouns of the implied verb (τηρηθείη, ''may be kept''), each separately agreeing with the predicate adjective ὁλόκληρον.',
    NULL
);

-- Citations (6 rows)
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit012',
    'C012',
    'John 15:13 — μείζονα ταύτης ἀγάπην οὐδεὶς ἔχει, ἵνα τις τὴν ψυχὴν αὐτοῦ θῇ ὑπὲρ τῶν φίλων αὐτοῦ (''no one has greater love than this, that someone lay down his life for his friends'').',
    'ψυχή rather than a plainer word for ''life'' (e.g. bare βίος) activates the whole life-as-something-that-can-be-given weight of the sacrifice, consistent with S012''s broad ''life that can be lost/given'' sense.',
    'بذل حياته / بذل نفسه لأجل أصدقائه — حياته is arguably closer to the plain ''life-at-stake'' sense (S012) than نفسه, which risks importing philosophical/religious soul-connotations not present in this verse.',
    'Novum Testamentum Graece (Nestle-Aland).',
    'The Greek text quoted here is the standard, non-disputed reading; no textual-critical flag needed for this verse specifically.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit013',
    'C013',
    'Homer, Iliad 1.3-5 — πολλὰς δ'' ἰφθίμους ψυχὰς Ἄϊδι προΐαψεν ἡρώων (''and sent forth to Hades many mighty souls of heroes'').',
    'Homer uses ψυχή specifically (not θυμός or φρένες, which do the living person''s mental work) because this is precisely the postmortem, departed sense the epic''s opening lines describe — the wrath of Achilles sends heroes'' bodies to become prey for dogs and birds while their ψυχαί go to Hades, exactly the division of labor S013 describes.',
    'أرواحًا / نفوسًا كثيرة جبارة إلى هاديس — a translator should resist over-theologizing this with modern religious connotations of ''soul''; the Homeric sense is closer to ''shade/ghost.''',
    'Homer, Iliad, ed. West (Teubner) or Monro/Allen (OCT).',
    'Among the most secure, uncontested readings in the entire Iliad (the poem''s opening lines) — very low risk of textual variation, but confirm line numbering against your specific edition.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit014',
    'C014',
    'Plato, Republic 439d-441c — the argument establishing τρία ... ἐν τῇ ψυχῇ εἴδη (''three forms/parts within the soul''): λογιστικόν, θυμοειδές, ἐπιθυμητικόν.',
    'Plato needs ψυχή (rather than, say, νοῦς, which would name only the rational part) because his argument specifically requires a single unified entity capable of internal conflict between its parts — the word choice is load-bearing for the whole argument''s structure.',
    'ثلاثة أنواع/أقسام في النفس — النفس is the standard rendering, but a translator''s note should flag that this is Plato''s specific technical theory, not the word''s default sense across all periods.',
    'Plato, Republic, ed. Slings (OCT); Republic Book IV, Stephanus 439d-441c.',
    'FLAG: verify exact Stephanus range and Greek wording against the OCT before quoting extended Greek verbatim — this entry paraphrases the argument''s structure rather than quoting a long passage.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit015',
    'C015',
    'Aristotle, De Anima II.1 (Bekker 412a-b) — the definition of ψυχή as ἐντελέχεια ἡ πρώτη σώματος φυσικοῦ δυνάμει ζωὴν ἔχοντος (''the first actuality of a natural body having life potentially'').',
    'Aristotle deliberately redefines ψυχή using his own technical vocabulary (ἐντελέχεια) rather than adopting Plato''s separable-substance picture wholesale — the word ψυχή is retained but its content is being actively re-theorized, precisely what S017 documents.',
    'النفس هي الكمال الأول لجسم طبيعي ذي حياة بالقوة — a technical philosophical Arabic rendering (drawing on the Arabic Aristotelian tradition''s established vocabulary for ἐντελέχεια, typically كمال or فعلية) rather than a loose paraphrase.',
    'Aristotle, De Anima, ed. Ross (OCT), Bekker 412a-b.',
    'FLAG: verify the precise Greek wording and Bekker line reference against the OCT before quoting verbatim — this is a famous, frequently-cited definition worth getting letter-perfect if quoted directly.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit016',
    'C016',
    'Acts 2:41 — προσετέθησαν ἐν τῇ ἡμέρᾳ ἐκείνῃ ψυχαὶ ὡσεὶ τρισχίλιαι (''about three thousand souls/people were added that day'').',
    'ψυχαί here functions exactly as a headcount noun — the verse reports a number of people, not a claim about the state of anyone''s soul in a philosophical or theological sense (contrast S020''s technical ψυχή/πνεῦμα anthropology, a different Pauline concern entirely).',
    'نحو ثلاثة آلاف نفس / شخص — نفس is actually the traditional rendering here (mirroring Hebrew nephesh''s parallel headcount usage), even though شخص might be clearer to a modern reader; worth flagging both options.',
    'Novum Testamentum Graece (Nestle-Aland), Acts 2:41.',
    'Standard, non-disputed reading; low textual-critical risk for this specific verse.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit017',
    'C017',
    '1 Thessalonians 5:23 — καὶ ὁλόκληρον ὑμῶν τὸ πνεῦμα καὶ ἡ ψυχὴ καὶ τὸ σῶμα ἀμέμπτως τηρηθείη (''and may your spirit and soul and body be kept complete, blameless'').',
    'Paul coordinates ψυχή as a distinct term alongside πνεῦμα and σῶμα rather than treating soul/spirit as interchangeable — establishing (or at minimum gesturing toward) the tripartite anthropology made explicit in his ψυχικός/πνευματικός contrast elsewhere (1 Cor 2:14, 15:44).',
    'روحكم ونفسكم وجسدكم بالكمال — standard Arabic NT phrasing keeping all three terms distinct, mirroring the Greek coordination rather than collapsing any two of them.',
    'Novum Testamentum Graece (Nestle-Aland), 1 Thessalonians 5:23.',
    'FLAG: this verse''s precise theological implications (strict ontological trichotomy vs. a rhetorical fullness-formula) are genuinely disputed in NT scholarship — cite the verse confidently, but don''t assert one interpretive side as settled fact in Nuance_Context without noting the dispute.'
);
