-- Classical Language Database — ἀπό (L008), full detail
-- Run AFTER logos, nomos, psyche, dike, arete, gnosis, and eimi are already loaded.
-- FIRST PREPOSITION entry. Unlike every noun/verb entry so far, Required_Case is almost always
-- simply "Genitive" throughout -- the real teaching content here is CONTRASTS BETWEEN PREPOSITIONS
-- (ap' vs ek, apo vs hypo) rather than case variation. See the Lemma's Classical_Concept design note.
-- All 6 citations here are CONFIRMED directly from source lexicon material provided (LSJ, Pape, DGE),
-- not reconstructed from memory.

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

-- Lemma: ἀπό
INSERT INTO Lemmas (
    Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field, Cross_Language_Connection, Modern_Resonance, Classical_Concept
) VALUES (
    'L008',
    'ἀπό',
    'Ancient Greek',
    'From PIE *h2epo (''off, away''), an exceptionally well-preserved and widespread root — cognate with Sanskrit apa, Latin ab, Gothic af, Old English of/æf (English ''off''/''of''), Hittite āppa. Dialect variants: Aeolic/Thessalian/Arcado-Cypriot ἀπύ, poetic ἀπαί. ἀπό governs the genitive in virtually all Greek (the overwhelming norm across every period and dialect this database has covered); a genuine dative-governing use survives only in Arcado-Cypriot inscriptions (a small, geographically isolated relic), and an accusative-governing use appears only in very late (Byzantine-adjacent) Greek — treat ''ἀπό + genitive'' as the default assumption essentially without exception for Classical and Koine texts.',
    'Spatial separation/motion-away-from, temporal succession (after/since), origin/descent/source/material, cause/reason, instrumental means, (encroaching) passive agency, partitive selection, and a fixed psychological/logical-consistency idiom (οὐκ ἀπὸ σκοποῦ).',
    'Direct cognate of English ''of'' and ''off'' (both descend from the same PIE root as ἀπό, having split apart in meaning over the history of English) and of Latin ab. Arabic من (min) covers much of ἀπό''s spatial/origin/partitive territory but has no equivalent single preposition for ἀπό''s agency-marking use (Arabic passive constructions typically don''t need a stated agent at all, or use a separate phrase like من قبل or بواسطة, rather than one flexible preposition doing the job the way Greek ἀπό/ὑπό do).',
    'English ''apo-'' as a productive scientific/technical prefix (apostasy, apogee, apoptosis) descends directly from this preposition in compound form, generally preserving its ''away from, off'' sense (e.g. apogee, ''away from the earth'', the point in an orbit farthest from Earth).',
    'ἀπό is fundamentally different in kind from every noun and even from the verb εἰμί already in this database: as a PREPOSITION, its case-government is essentially FIXED (genitive, with rare and marginal exceptions) rather than variable — meaning the real interpretive challenge this entry documents is not ''which case does this construction take'' (almost always the same answer) but ''which of several genuinely distinct SEMANTIC RELATIONSHIPS is this instance of ἀπό+genitive expressing.'' This is the reverse teaching problem from every noun entry so far, where a single word took several different cases each with a distinct function; here, one single case is reused across many distinct functions, disambiguated by context, collocating verb, and (crucially) by contrast with near-synonym prepositions — especially ἐκ (marking more immediate/from-within separation or descent, versus ἀπό''s more remote/superficial separation or descent) and ὑπό (marking more direct agency, versus ἀπό''s marking of less direct or more remote causal involvement). Recognizing these CONTRASTIVE oppositions between prepositions, not case alone, is the core skill this entry is built to teach.'
);

-- Senses (8 rows)
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S057',
    'L008',
    'Spatial — ''away from, from'' (motion and position)',
    'من (بعيدًا عن)',
    'The oldest and, in Homer, overwhelmingly dominant sense: physical separation, whether as motion away from a place (φοβέοντο ἀπὸ νηῶν, ''they fled away from the ships'') or as a static state of being distant/apart from something (μένων ἀπʼ ἀλόχοιο, ''remaining apart from his wife''). Motion and static position are treated as one sense here rather than two, since both express the same underlying spatial-separation relationship, differing only in whether the separation is a punctual event or an ongoing state.',
    'The most literal, concrete sense of the preposition — physical distance or departure, prior to any of the more abstract extensions (temporal, causal, instrumental) built on this same spatial foundation.',
    'Crucially contrasted with ἐκ: both can mean ''from'', but ἀπό marks separation from something considered as an external point (surface-level departure), while ἐκ marks emergence from WITHIN something (immediate, internal origin) — explicitly contrasted in Xenophon, Memorabilia 2.7.2: ''we get nothing from the land (ἐκ τῆς γῆς) nor from the houses (ἀπὸ τῶν οἰκιῶν)'' — land is worked FROM WITHIN (ἐκ), houses merely provide external income (ἀπό).',
    'Overwhelmingly the dominant sense in Homer; remains fully current through every later period as the basic spatial preposition, alongside the more specialized extensions that develop from it.',
    NULL,
    'Default first reading for ἀπό: physical separation or distance, ''away from.'' If that doesn''t fit, check whether a temporal, causal, or instrumental extension is more likely given the surrounding verb.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S058',
    'L008',
    'Temporal — ''from, after, since''',
    'منذ، بعد',
    'Marking a point in time from which something proceeds: ἀπὸ δείπνου, ''after dinner'' (literally ''from dinner [onward]''); ἀφʼ οὗ (χρόνου), ''from which time, since''; τὸ ἀπὸ τούτου, ''from this point onward.'' A natural extension of the spatial sense — a temporal starting-point functions grammatically just like a spatial one.',
    'A metaphorical mapping of spatial separation onto the time axis — ''away from a point in time'' becomes ''after/since that point'', exactly the same conceptual move English makes with its own ''from''.',
    'Near-synonym: μετά + accusative (also ''after'', but marking simple temporal sequence rather than ἀπό''s implication of continuing forward FROM that starting point).',
    'Common across all periods; particularly frequent in historiography for dating and sequencing narrated events (Herodotus, Thucydides, Xenophon all use ἀφʼ οὗ / ἀπὸ τούτου constructions heavily for narrative chronology).',
    'ἀφʼ οὗ — ''since, from which time''; τὸ ἀπὸ τούτου / τοῦδε — ''from this point onward.''',
    'ἀπό + a noun naming an event or time-point almost always means ''after/since X'' rather than physical separation — context (a meal, a battle, a named point in time) signals you''re in this temporal sense.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S059',
    'L008',
    'Origin, descent, source, or material',
    'من (أصلًا)، مصنوع من',
    'Marking the SOURCE something comes from: genealogical descent (πατρὸς ἄπο, ''from a father'' = descended from him; οὐ γὰρ ἀπὸ δρυός ἐσσι οὐδʼ ἀπὸ πέτρης, ''you are not sprung from oak or rock'' = you have real, known ancestry), geographic origin (οἱ ἀπὸ Σπάρτης, ''the men from Sparta''), material composition (εἵματα ἀπὸ ξύλου, ''clothes made of [tree-]cotton''), or ongoing economic sustenance (ζῆν ἀπὸ ἰχθύων, ''to live off fish''). A single ἀπό+genitive construction covers descent, geographic origin, material, and livelihood-source because Greek treats all of these as structurally the same relationship: X exists/continues because of a connection to source Y.',
    'A generalization from the spatial sense: ''coming from a place'' extends naturally to ''coming from a parent/ancestor'' and then to ''made from/sustained by a material or resource'' — the same underlying source-relationship applied across physical, genealogical, and material domains.',
    'Crucially contrasted with ἐκ for descent-specifically: ἀπό tends to mark more REMOTE descent, ἐκ more IMMEDIATE/direct descent — explicitly contrasted in Isocrates 12.81: ''some descended from gods (ἀπὸ θεῶν), others sprung directly from the gods themselves (ἐξ αὐτῶν τῶν θεῶν)'' — the same ἀπό/ἐκ opposition already documented for spatial separation (S057), now operating in the genealogical domain.',
    'Genealogical/self-identification usage especially prominent in epic and tragedy (heroes naming their lineage); the ''disciple of a school'' extension (οἱ ἀπὸ Πλάτωνος, ''the followers/school of Plato'') is a distinctly later (Hellenistic onward) development of this same source-relationship, applied to intellectual rather than biological descent.',
    'οἱ ἀπὸ Πλάτωνος/Πυθαγόρου — ''the followers of Plato/Pythagoras'' (a philosophical school, by extension of the descent-relationship to intellectual lineage).',
    'εἰμί/γίγνομαι + ἀπό + genitive marking a person, place, or substance is very likely this origin/source sense — check whether the context is parentage, geography, material, or a philosophical school to pick the right English translation.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S060',
    'L008',
    'Cause, reason, or occasion',
    'بسبب، من أجل',
    'Marking the cause, motive, or occasion because of which something happens: ἀπὸ δικαιοσύνης, ''by reason of justice''; ἀπὸ τῶν αὐτῶν λημμάτων, ''moved by/for the sake of the same profits.'' This sense also generates a large cluster of fixed adverbial idioms where ἀπό + an abstract noun functions essentially as a single adverb: ἀπὸ σπουδῆς, ''eagerly, in earnest''; ἀπὸ τοῦ ἴσου / ἀπʼ ἴσης, ''equally, on equal terms''; ἀφʼ ἑαυτοῦ, ''of one''s own accord.''',
    'An abstraction of the origin sense (S059): just as a person can ''come from'' a place or parent, an ACTION can be understood as ''coming from'' a cause or motive — the same source-relationship applied to abstract causation rather than physical/genealogical origin.',
    'Near-synonym: διά + accusative (also expressing cause, ''because of'', though διά+accusative tends to mark a more direct, immediate cause than ἀπό''s often more general/attendant-circumstance causation).',
    'The adverbial-idiom cluster (ἀπὸ σπουδῆς, ἀφʼ ἑαυτοῦ, etc.) is attested from Homer onward and remains extremely common and stable across every subsequent period.',
    'ἀπὸ σπουδῆς — ''eagerly, in earnest''; ἀπὸ τοῦ ἴσου/ἀπʼ ἴσης — ''equally''; ἀφʼ ἑαυτοῦ — ''of one''s own accord, spontaneously.''',
    'When ἀπό governs an abstract noun (an emotion, a quality, a circumstance) rather than a concrete place/person, and the surrounding clause describes an ACTION rather than physical movement, you''re very likely in this causal sense — many instances have simply become fixed adverbs, worth memorizing as vocabulary units rather than parsing fresh each time.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S061',
    'L008',
    'Instrumental — ''by means of, with''',
    'بواسطة، بـ',
    'Marking the physical means or instrument by which an action is performed: τοὺς πέφνεν ἀπʼ ἀργυρέοιο βιοῖο, ''he slew them with/from a silver bow''; ἀπὸ χειρὸς ἐργάζεσθαι, ''to work with the hand''; a related, especially productive idiom uses body-part or faculty nouns to mark HOW an utterance/action is performed: ἀπὸ γλώσσης, ''by word of mouth, orally'' (literally ''from the tongue''); ἀπὸ στόματος, ''by heart, from memory'' (literally ''from the mouth'').',
    'A further extension of the source-relationship (S059/S060): the instrument or body-part an action proceeds FROM is treated the same way a physical or causal source is — ''shot from a bow'' and ''spoken from the tongue'' both frame the tool/faculty as the point of origin for the action.',
    'Near-synonym: the plain instrumental dative (no preposition needed) — Greek can express the same instrumental relationship either with a bare dative or with ἀπό + genitive, with the ἀπό-construction perhaps foregrounding the instrument''s role as SOURCE-of-the-action slightly more than the dative''s more neutral ''by means of''.',
    'The body-part idioms (ἀπὸ χειρός, ἀπὸ γλώσσης, ἀπὸ στόματος) are attested across nearly all periods and genres, from Homer through Attic prose to later Koine, remaining a stable, productive idiomatic family throughout.',
    'ἀπὸ γλώσσης — ''orally, by word of mouth''; ἀπὸ στόματος (λέγειν) — ''to say/recite by heart, from memory''; ἀπὸ χειρός — ''by hand, with the hand.''',
    'A body-part or faculty noun (hand, tongue, mouth) after ἀπό, with a verb of speaking, working, or reciting nearby, is very likely this instrumental idiom — translate ''by/with X'' or ''orally/by heart'' rather than a literal spatial ''from the hand/tongue.'''
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S062',
    'L008',
    'Agency (encroaching on ὑπό) — ''by''',
    'من قبل، بواسطة (فاعل الحدث)',
    'Marking the person by whom an action is performed, functioning like ὑπό (''by'', the standard agent-marking preposition with passive verbs) but implying a LESS DIRECT form of agency: οὐδὲν μέγα ἔργον ἀπʼ αὐτοῦ ἐγένετο, ''no great deed came about by/from him''; ἐπράχθη ἀπʼ αὐτῶν οὐδέν, ''nothing was done by them.'' This usage becomes markedly more frequent in later Greek (Polybius, the New Testament), to the point that ancient and modern scholars alike sometimes debate, in individual manuscript readings, whether a given ἀπό should actually be emended to ὑπό.',
    'A further abstraction of the causal sense (S060): the PERSON responsible for an action is framed as its ''source'', the same relationship already used for physical/causal origin, now applied specifically to marking the agent of a passive verb.',
    'Crucially contrasted with ὑπό: ὑπό marks DIRECT agency (the immediate doer of the action), while ἀπό marks a more REMOTE or indirect causal involvement (someone from whose sphere or initiative the action ultimately derives, even if not the immediate direct actor) — a real, sometimes textually-contested distinction, since scribes could and did confuse the two prepositions.',
    'A minor, occasional usage in Classical Attic prose (Herodotus, Thucydides); becomes substantially more frequent and less clearly distinguished from ὑπό in Hellenistic and Roman-period Greek, including the New Testament.',
    NULL,
    'ἀπό + genitive marking the doer of a passive verb, especially in later/Koine Greek, may be functioning just like ὑπό (direct agent) — but where a text is Classical-period and precise, expect ἀπό here to mark somewhat less direct responsibility than a true ὑπό-agent would.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S063',
    'L008',
    'Partitive — ''of, from among''',
    'من (جزء من)',
    'Marking a part or share taken from a larger whole: λαχὼν ἀπὸ ληΐδος αἶσαν, ''having obtained a share FROM the booty''; ὀλίγοι ἀπὸ πολλῶν, ''few OF/FROM many'' (i.e. only a few survived out of a much larger number). Functions similarly to a bare partitive genitive (as already documented for εἰμί''s S054 and ἀρετή''s class-membership sense), but makes the FROM-A-WHOLE relationship explicit with a preposition rather than leaving it to a bare case-ending alone.',
    'A further generalization of the source-relationship: a ''part'' is understood as something that ''comes from'' the whole it belongs to, the same underlying relationship as physical or genealogical origin (S059), now applied to whole/part relationships specifically.',
    'Near-synonym: the bare partitive genitive (no preposition) — Greek can mark ''a share of X'' either with the bare genitive alone or with ἀπό + genitive, with ἀπό perhaps making the FROM-relationship more explicit/emphatic.',
    'Common across all periods, especially frequent with numerals and quantity words (ὀλίγοι, πολλοί, εἷς) marking survivors, portions, or subsets of a larger group.',
    NULL,
    'ἀπό + genitive following a number or quantity word (few, one, many) is very likely marking a subset/share taken FROM a larger group — ''X out of/from Y'', not physical separation.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S064',
    'L008',
    'Fixed idiom — ''not ἀπὸ X'' = ''not out of line with, consistent with X''',
    'غير بعيد عن (الصواب أو الهدف) — أي متوافق معه',
    'A fixed, heavily litotes-favoring (negated) idiom cluster built on the mental/psychological extension of the spatial sense: ἀπὸ θυμοῦ, ''away from [my] heart'' = alien, distasteful; and, almost always negated, οὐκ ἀπὸ σκοποῦ / τρόπου / γνώμης / πράγματος, ''not off the mark / not out of line with the manner-of-things / not away from [good] judgment / not away from the matter [at hand]'' = ''not unreasonable, apt, to the point.'' The negation is doing real interpretive work: Greek prefers to praise an idea as ''not off-target'' rather than making the more direct positive claim ''right on target'', a genuine stylistic/rhetorical preference worth flagging.',
    'A metaphorical extension of the spatial sense (S057) into the domain of mental/logical alignment: ''far from the heart/mark/judgment'' (physical-feeling metaphor) becomes ''alien to/inconsistent with'' in a purely psychological or logical sense, no physical distance literally intended.',
    'The idiom is built around implied antonyms σκοπός (mark/target), τρόπος (manner, way things are), γνώμη (judgment), πρᾶγμα (the matter at hand) — ''not away from'' any of these functions as a stock understatement for ''fitting, apt, sensible.''',
    'Extremely frequent in Plato''s dialogues specifically (οὐκ ἀπὸ σκοποῦ/τρόπου/γνώμης recur across the Theaetetus, Republic, and elsewhere) as a characteristic mark of Socratic/Platonic understated approval of an interlocutor''s point.',
    'οὐκ ἀπὸ σκοποῦ — ''not off the mark, apt''; οὐκ ἀπὸ τρόπου — ''not unreasonable''; οὐκ ἀπὸ γνώμης — ''not without good judgment.''',
    'Whenever you see οὐκ ἀπό + an abstract noun like σκοπός/τρόπος/γνώμη, translate the whole negated phrase as a single positive-flavored idiom (''reasonable, apt, sensible'') rather than parsing ''not away from X'' literally — this is a stock Platonic understatement, especially common in dialogue responses.'
);

-- Constructions (6 rows)
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C042',
    'S059',
    'τοὺς μὲν ἀπὸ θεῶν, τοὺς δʼ ἐξ αὐτῶν τῶν θεῶν γεγονότας (Isocrates 12.81) — ''some descended from gods [remotely], others sprung directly from the very gods themselves'' — ἀπό and ἐκ both governing the genitive but marking different degrees of directness in the same descent-relationship.',
    'Genitive (both prepositions).',
    'Since both ἀπό and ἐκ govern the same case (genitive), the contrast here is carried entirely by the CHOICE OF PREPOSITION, not by any difference in case — a genuinely unusual teaching point for this database, where nearly every other Construction has documented case-choice as the key variable. Here Greek instead distinguishes REMOTE/general descent (ἀπό) from IMMEDIATE/direct descent (ἐκ) purely through which preposition is chosen, both taking the identical genitive complement.',
    'Students may treat ἀπό and ἐκ as freely interchangeable synonyms for ''from'' and miss that an author''s specific choice between them can carry real information (how directly/immediately one thing derives from another) — this is a genuine authorial choice, not free variation, in careful prose like Isocrates''.',
    'θεῶν, genitive plural of θεός, governed by both ἀπό and ἐκ in the two parallel clauses.',
    'Both prepositional phrases function adverbially, modifying the participle γεγονότας (''having been born/descended''), marking the source of descent with differing degrees of directness.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C043',
    'S062',
    'ἐπράχθη ἀπʼ αὐτῶν οὐδέν (Thucydides) — ''nothing was accomplished by them'' — ἀπό marking the agent of a passive verb, in competition with the more standard agent-marking preposition ὑπό.',
    'Genitive (governed by ἀπό, exactly as ὑπό also governs the genitive when marking agency).',
    'Both ἀπό and ὑπό govern the genitive when marking a passive verb''s agent, so again the real choice is between PREPOSITIONS, not cases. ὑπό is the standard, maximally direct agent-marker (''by [the direct doer of] X''); ἀπό, when it encroaches on this same function, tends to mark a more remote or attendant-circumstance causal role (the action ultimately traces back to this person/group, without asserting them as the immediate hands-on actor) — though this distinction blurs considerably in later Greek.',
    'Because the distinction between ἀπό-agency and ὑπό-agency genuinely weakens over time (Hellenistic/Koine Greek uses them close to interchangeably), a student should calibrate how much interpretive weight to place on this distinction by PERIOD: sharp and meaningful in Classical Attic prose, much less reliable in later Greek including the New Testament.',
    'αὐτῶν, genitive plural personal pronoun, governed by ἀπό.',
    'Adverbial prepositional phrase marking the agent of the passive verb ἐπράχθη.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C044',
    'S064',
    'οὐκ ἀπὸ σκοποῦ εἴρηκεν (Plato, Theaetetus 179c) — ''he has spoken not off the mark'' = ''he has spoken aptly/reasonably'' — a negated ἀπό+genitive functioning as a fixed positive-evaluative idiom.',
    'Genitive (σκοποῦ, τρόπου, γνώμης, etc.).',
    'Not a case-choice teaching point (ordinary genitive governed by ἀπό as in the plain spatial sense) — the real teaching value is recognizing that the NEGATION plus a fixed set of abstract nouns (σκοπός, τρόπος, γνώμη, πρᾶγμα) together form a conventionalized understatement idiom, not a literal claim about physical or metaphorical distance that should be parsed compositionally each time.',
    'A student parsing this compositionally (''not away from the mark'') will actually arrive at roughly the right sense by luck, but should recognize this as a RECOGNIZED FIXED IDIOM (especially frequent in Plato) rather than a live, freshly-constructed metaphor each time it appears — much like recognizing ''not bad'' as idiomatic praise in English rather than parsing it as a literal quality-assessment.',
    'σκοποῦ / τρόπου / γνώμης / πράγματος, genitive singular, governed by ἀπό.',
    'Adverbial prepositional phrase, negated, functioning as a fixed evaluative idiom modifying the verb of speaking/acting.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C045',
    'S063',
    'ὀλίγοι ἀπὸ πολλῶν (Thucydides 7.87) — ''few from/out of many'' — ἀπό+genitive marking a subset selected from or surviving out of a larger group.',
    'Genitive (πολλῶν).',
    'A partitive relationship that Greek can also express with a BARE genitive alone (no preposition) — compare the bare partitive/class-membership genitives already documented for εἰμί (S054, τῶν φίλων εἶναι) and ἀρετή. ἀπό+genitive makes the same partitive relationship more explicit by adding an overt ''FROM'' marker, useful especially with quantity words (ὀλίγοι, εἷς, πολλοί) where the writer wants to emphasize the size of the group something is drawn FROM.',
    'Students should recognize that Greek has (at least) two ways to express ''some of X'' — bare genitive alone, or ἀπό+genitive — and that the choice between them is often stylistic/emphatic rather than marking any real difference in meaning, unlike the meaningful ἀπό/ἐκ or ἀπό/ὑπό contrasts documented elsewhere in this entry.',
    'πολλῶν, genitive plural of πολύς, governed by ἀπό.',
    'Adverbial prepositional phrase modifying the quantity word ὀλίγοι, marking the larger group the small number is drawn from.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C046',
    'S061',
    'ἀπὸ γλώσσης (Herodotus 1.123) — ''by word of mouth, orally'' (literally ''from the tongue''); ἀπὸ χειρός — ''by hand, with the hand'' — body-part nouns governed by ἀπό, functioning as fixed instrumental-manner adverbials.',
    'Genitive (γλώσσης, χειρός).',
    'The same source-relationship documented for S059 (origin) and S060 (cause) here marks an INSTRUMENT/FACULTY as the ''point of origin'' for an action — a spoken message is treated as originating FROM the tongue, a physical task as originating FROM the hand, exactly the way a person is said to originate FROM a parent or place. Greek could alternatively express pure instrumentality with a bare dative (τῇ γλώσσῃ, τῇ χειρί) without a preposition at all; choosing ἀπό+genitive instead specifically foregrounds the body-part as a SOURCE the action flows from, not merely a neutral tool.',
    'A student may translate ἀπὸ γλώσσης too literally (''from the tongue'') rather than recognizing the fixed idiomatic sense ''orally, by word of mouth'' (as opposed to in writing) — context (a message, an order, a recitation) signals the idiomatic reading is intended.',
    'γλώσσης, genitive singular of γλῶσσα (tongue); χειρός, genitive singular of χείρ (hand).',
    'Adverbial prepositional phrase functioning as a manner-adverbial, modifying a verb of speaking, ordering, or working.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C047',
    'S057',
    'ὅσον πεντεκαίδεκα στάδια ἀπὸ Φυλῆς (Xenophon, Hellenica 2.4.4) — ''about fifteen stades from Phyle'' — a numeral of measurement governed by, or governing alongside, ἀπό to express distance-away.',
    'Genitive (Φυλῆς) — note that the MEASURE noun itself (στάδια) stands in the accusative of extent, not the genitive, and is grammatically separate from the ἀπό-phrase.',
    'A genuine diachronic word-order/construction shift is documented across periods: in earlier Classical Greek (as in this Xenophon example), the measurement (accusative of extent, στάδια) precedes ἀπό, which then governs the genitive place-name; in later Greek (Hellenistic historians like Diodorus Siculus and Plutarch), the order reverses, with ἀπό placed directly before the numeral itself (ἀπὸ σταδίων εἴκοσι, ''from twenty stades'', treating the numeral itself as if it were the object of ἀπό) — a real syntactic development worth recognizing when dating or characterizing a text''s Greek by register.',
    'A student accustomed to one word-order pattern (numeral-then-ἀπό-then-place, the earlier Classical pattern) may be confused encountering the reverse order (ἀπό-then-numeral) in a later historian and should recognize this as a genuine diachronic shift, not a scribal error or aberration.',
    'στάδια, accusative plural (of extent) in the earlier pattern; σταδίων, genitive plural in the later pattern where the numeral itself follows ἀπό directly.',
    'The genitive place-name is governed by ἀπό; the numeral+measure-word functions as an accusative of extent describing how far away that place is.',
    'The word-order shift between earlier (numeral before ἀπό+place) and later (ἀπό before numeral) Greek reflects a real, datable syntactic development, not free variation.'
);

-- Citations (6 rows)
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit043',
    'C042',
    'Isocrates 12.81 — τοὺς μὲν ἀπὸ θεῶν, τοὺς δʼ ἐξ αὐτῶν τῶν θεῶν γεγονότας (''some descended from gods, others sprung directly from the very gods themselves'').',
    'Isocrates deliberately uses both prepositions in the same sentence to draw a precise distinction between remote and immediate divine descent — a single preposition (''from'') would have collapsed this distinction entirely.',
    'بعضهم من نسل الآلهة [بعيد]، وآخرون ولدوا من الآلهة أنفسهم [مباشرة] — Arabic needs added qualifiers (بعيد/مباشرة) to render explicitly what Greek achieves through preposition choice alone.',
    'Isocrates, Orations, ed. Mathieu-Brémond (Budé) or Norlin (Loeb).',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit044',
    'C043',
    'Thucydides 1.17 — ἐπράχθη οὐδὲν ἀπʼ αὐτῶν ἔργον ἀξιόλογον (''no notable deed was accomplished by them'').',
    'Thucydides''s assessment of the tyrants of Greece uses ἀπό rather than ὑπό, arguably marking their causal responsibility for the era''s lack of achievement without asserting them as vigorous direct agents of anything — consistent with his generally critical portrait of their limited ambitions.',
    'لم يُنجَز عمل يُذكر من قِبَلهم / بواسطتهم',
    'Thucydides, Historiae, ed. Jones & Powell (OCT), Book 1, chapter 17.',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit045',
    'C044',
    'Plato, Theaetetus 179c — οὐκ ἀπὸ σκοποῦ εἴρηκεν (''he has spoken not off the mark'').',
    'Plato uses this understated idiom rather than a direct positive statement (''he has spoken well'') as a characteristic mark of Socratic dialectical caution — even agreement is expressed as merely ''not missing the mark'' rather than an unqualified endorsement.',
    'لم يخطئ الهدف فيما قال / كلامه ليس بعيدًا عن الصواب',
    'Plato, Theaetetus, ed. Burnet (OCT), Stephanus 179c.',
    'CONFIRMED — this exact citation appears independently in both the English (LSJ) and German (Pape) source lexicon entries this database entry was built from, giving unusually strong cross-source confirmation.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit046',
    'C045',
    'Thucydides 7.87 — ὀλίγοι ἀπὸ πολλῶν (''few out of many'' [survived]).',
    'This phrase closes Thucydides''s account of the catastrophic Athenian defeat in Sicily — the stark partitive construction (''few FROM many'') delivers the scale of the disaster in four words, a famously terse and devastating closing line.',
    'قليلون من كثيرين [نجوا]',
    'Thucydides, Historiae, ed. Jones & Powell (OCT), Book 7, chapter 87.',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit047',
    'C046',
    'Herodotus 1.123 — ἐντειλάμενος ἀπὸ γλώσσης (''instructing/commanding by word of mouth'').',
    'Herodotus specifies that the order was given ORALLY (as opposed to in writing) precisely because the surrounding narrative context (a secret, sensitive political message) makes the medium of transmission a meaningful detail, not incidental.',
    'أوصى شفهيًا / بالقول لا بالكتابة',
    'Herodotus, Historiae, ed. Wilson (OCT), Book 1, chapter 123.',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from (appearing in both the English LSJ and Spanish DGE excerpts), not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit048',
    'C047',
    'Xenophon, Hellenica 2.4.4 — ὅσον πεντεκαίδεκα στάδια ἀπὸ Φυλῆς (''about fifteen stades from Phyle'').',
    'Xenophon needs precise distance-marking here because the narrative (the exiles'' march from Phyle toward Athens during the overthrow of the Thirty Tyrants) turns on exactly how far the rival forces were from key strategic points.',
    'على بعد نحو خمسة عشر ستاديون من فيلي',
    'Xenophon, Hellenica, ed. Marchant (OCT), Book 2, chapter 4, section 4.',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
