-- Classical Language Database — εἰμί (L007), full detail
-- Run AFTER logos, nomos, psyche, dike, arete, and gnosis are already loaded.
-- FIRST VERB entry in the database -- several fields are adapted from their noun-focused usage
-- elsewhere (see the Lemma's Classical_Concept design note). All 6 citations here are CONFIRMED
-- directly from source lexicon material provided, not reconstructed from memory -- a first for
-- this database.

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

-- Lemma: εἰμί
INSERT INTO Lemmas (
    Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field, Cross_Language_Connection, Modern_Resonance, Classical_Concept
) VALUES (
    'L007',
    'εἰμί',
    'Ancient Greek',
    'From the PIE root *h1es- (''to be''), one of the most conservative roots across the Indo-European family — cognate with Latin sum/esse, Sanskrit asmi, English ''is''/''am'' (via Germanic), Hittite ešmi. Supplemented irregularly by a second PIE root *bʰuh2- (''to become, grow'') in some daughter languages (English ''be'', Latin fui) — Greek keeps these more separate, with γίγνομαι (''to become'') largely covering the *bʰuh2- territory rather than merging into one paradigm. εἰμί is exceptionally dialectally fragmented even by Greek standards: real attested variants include Doric/Aeolic ἐντί (3rd pl.), Cretan ἠμί (1st sg.), Boeotian ἰῶσα (fem. participle), and dozens more across inscriptional and literary dialects — a student moving between authors/regions should expect real surface variation in this paradigm that would be a copying error in almost any other verb.',
    'Existence, reality, the philosophical concept of Being (τὸ ὄν), copular predication, possession (via dative), origin/descent/class-membership (via genitive), impersonal possibility, and an indefinite-pronoun-forming existential idiom (εἰσὶν οἵ).',
    'Latin esse/sum is the closest cognate and functional parallel, including its own philosophical technical use for Being (ens, essentia — medieval scholastic vocabulary built directly on this verb). Arabic has NO direct one-word equivalent for the copula in the present tense: Arabic nominal sentences typically use zero-copula (''the book [is] new'' needs no verb at all), with كان reserved mainly for past-tense or conditional ''to be'' — a genuinely different kind of translation challenge than any previous word in this database, since the issue isn''t choosing the right Arabic word but recognizing Arabic may need NO word at all.',
    'The entire Western philosophical tradition of ontology (''the study of being'') takes its name and central question (''what is Being?'') directly from this verb''s substantivized participle τὸ ὄν — running from Parmenides through Aristotle''s ''being qua being'' (Metaphysics), medieval scholasticism''s ens/esse distinction, down to Heidegger''s Sein und Zeit, which explicitly revisits this same Greek verb''s history as its starting point.',
    'εἰμί is fundamentally different in kind from every other word built into this database so far: it is a VERB, not a noun, and several of its ''senses'' are better described as distinct GRAMMATICAL FUNCTIONS (existential predicate, copula, auxiliary-in-periphrasis) than as distinct MEANINGS the way λόγος''s or ἀρετή''s senses are. This is the first entry to genuinely stretch the schema: Required_Case in the Constructions table now generally describes the case of εἰμί''s OWN COMPLEMENT (a dative of possession, a genitive of origin) rather than a case εἰμί itself is governed by; Morphology now must describe person/number/tense/mood/voice rather than noun declension, given the verb''s famously irregular, dialectally fragmented paradigm (see Root_Lineage). DESIGN NOTE: this entry treats the philosophical ''Being'' sense (S051) as sufficiently historically load-bearing to deserve independent Sense status despite building directly on the ordinary existential sense (S050) — the same kind of judgment call made for ψυχή''s Platonic sense and γνῶσις''s philosophical elaboration, here applied to what may be the single most historically consequential substantivized participle in the whole Greek philosophical tradition.'
);

-- Senses (7 rows)
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S050',
    'L007',
    'Existential — to exist, to be (real, alive, present)',
    'يوجد، موجود، كائن (مع ملاحظة أن العربية غالبًا لا تحتاج فعلًا للجملة الاسمية البسيطة)',
    'The basic existential sense: to exist, to be real, to be alive, to be present — οὐκ ἔσθ'' οὗτος ἀνήρ, οὐδ'' ἔσσεται, ''this man does not exist, nor will he''; θεοὶ αἰὲν ἐόντες, ''the gods who exist forever''; of the living vs. the dead, ζώντων καὶ ὄντων Ἀθηναίων, ''while the Athenians are living and in existence''; of cities/things, ὄλωλεν, οὐδ'' ἔτ'' ἔστι Τροία, ''Troy has perished and no longer exists'' (cf. Latin ''Troja fuit'').',
    'The most literal, bedrock sense of the verb — bare existence/presence-in-the-world, prior to any predicative or copular use.',
    'Overlaps with ζάω (to live, of animate beings specifically); antonym-in-context: ἀπόλλυμι/ὄλλυμαι (to perish, to be destroyed) — ''Troy no longer ἔστι'' directly follows ''Troy ὄλωλεν.''',
    'Pervasive across all periods; Homer''s formulaic θεοὶ αἰὲν ἐόντες and the recurring living/dead (ζῶν/οὐκ ὤν) distinction run from epic through tragedy and oratory unchanged in basic sense.',
    'οἱ ὄντες, ''the living'' (as opposed to the dead); ὁ οὐκ ὤν, ''the one who is no more'', a euphemism for the dead.',
    'This is the plain ''to exist / to be alive / to be real'' sense — the safest default reading whenever εἰμί isn''t obviously linking a subject to a predicate (copula) or marking possession (dative) or origin (genitive).'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S051',
    'L007',
    '''Being'' — the technical philosophical substantive (τὸ ὄν)',
    'الوجود، الكائن، الموجود بالمعنى الفلسفي',
    'The substantivized present participle ὤν/ὄν, used as a technical philosophical noun: τὸ ὄν, ''Being'' or ''that which is,'' opposed to τὸ μὴ ὄν (''non-being'') and, in a related but distinct opposition, to τὸ γίγνεσθαι (''becoming'' — that which is always changing rather than truly, stably being). This is the founding term of Western ontology, running from Parmenides'' poem through Plato''s distinction between the changelessly real (Forms, τὸ ὄν) and the ever-changing world of appearance (τὸ γιγνόμενον), into Aristotle''s Metaphysics, which investigates ''being qua being'' (τὸ ὂν ᾗ ὄν). A closely related idiom, τῷ ὄντι (''in reality, in fact, truly''), extends this same philosophical weight into ordinary adverbial use, marking a claim as REALLY true rather than merely apparent (cf. the classical Greek esse/videri, ''being'' vs. ''seeming'' distinction).',
    'A major technical narrowing from S050: not just ''existing'' in the ordinary sense, but Being as a philosophical category — the substantivized participle functions as a proper technical noun in a way the finite verb forms in S050 do not.',
    'Antonym: τὸ μὴ ὄν (non-being); related contrast (not strict antonym): τὸ γιγνόμενον (that which is becoming/changing) — Plato treats the being/becoming distinction as at least as important as the being/non-being distinction.',
    'Founding term of Presocratic (Parmenides) and Classical (Plato, Aristotle) philosophical ontology; the single most historically consequential technical use of any form of εἰμί.',
    'τῷ ὄντι — ''in reality, truly, in fact'' (marking a claim as genuinely, not merely apparently, true).',
    'Whenever you see τὸ ὄν, τὰ ὄντα, or ὁ ὤν functioning as a noun (not just a participle modifying something) in a philosophical text, you''re reading this specific technical sense — ''Being'' or ''the real,'' not merely ''the thing that happens to be existing.'''
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S052',
    'L007',
    'Copula — linking verb joining subject and predicate',
    '(غالبًا بلا مقابل عربي مباشر في الحاضر؛ الجملة الاسمية العربية تستغني عن الفعل)',
    'The purely grammatical function of linking a predicate to a subject, both standing in the same case: ''Socrates is wise,'' Σωκράτης σοφός ἐστιν. Arguably not a distinct MEANING of εἰμί at all so much as a distinct GRAMMATICAL FUNCTION — the verb here asserts predication/identity rather than describing an event, state, or possession. Arabic simple nominal sentences in the present tense typically need NO copula at all (زيدٌ حكيمٌ, with no verb, for ''Socrates [is] wise''), with كان reserved mainly for past/conditional uses — a genuinely different kind of translation challenge than any previous word.',
    'Functionally distinct from S050: the copula doesn''t assert that the subject EXISTS, only that the predicate applies to it — a distinction famously exploited in later philosophy of language (Russell on ''the present king of France is bald'').',
    NULL,
    'The single most frequent function of εἰμί across all periods and genres — so frequent the verb is regularly OMITTED (ellipsis of the copula) before certain predicates (ἀνάγκη, ἄξιον, δυνατόν, εἰκός, ῥᾴδιον, etc.), itself a notable feature students should recognize rather than assume a missing word is an error.',
    NULL,
    'If a predicate adjective/noun and a subject share the same case and a form of εἰμί links them (or is simply implied/omitted), you''re reading the plain grammatical copula — don''t look for a deeper ''meaning'' beyond the predication itself.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S053',
    'L007',
    'Dative of possession — ἔστι μοι, ''I have''',
    'لي، عندي (تعبيرًا عن الامتلاك)',
    'ἔστι μοι, literally ''it is to/for me,'' idiomatically ''I have'' — possession expressed not by a transitive ''to have'' verb (Greek does have ἔχω) but by attributing existence to a possessed object via a dative of the possessor: ἓξ δέ οἱ υἷες ἔασιν, ''and six sons are-to-him'' = ''he has six sons.''',
    'A genuine conceptual shift from S050: existence is predicated of the POSSESSED THING, with the possessor marked obliquely by the dative, rather than a transitive verb directly relating possessor to possession the way ἔχω does.',
    'Near-synonym: ἔχω (to have, transitive) — the two constructions describe the same relationship (X possesses Y) with different grammatical subjects: ἔχω makes the possessor the subject; ἔστι μοι makes the possessed thing the subject.',
    'Frequent from Homer onward across all periods and genres; not a specialized register, simply a standard alternate possession-construction available throughout the language''s history.',
    'ἔστι μοι — ''I have'' (literally ''it is to me'').',
    'Don''t translate ἔστι μοι word-for-word as ''it is to me'' — recognize this immediately as the standard Greek idiom for ''I have,'' with the possessed thing as grammatical subject and the possessor in the dative.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S054',
    'L007',
    'Genitive of origin, descent, quality, or class-membership',
    'أنا ابن... / أنا من... / أنتمي إلى...',
    'εἰμί + genitive marking descent/origin (πατρὸς δ'' εἴμ'' ἀγαθοῖο, ''I am of a good father'' = ''I am the son of a good man''), material composition (ἡ κρηπίς ἐστι λίθων μεγάλων, ''the foundation is [made] of great stones''), or class-membership (εἶ γὰρ τῶν φίλων, ''for you are one of the friends''; Κριτίας τῶν τριάκοντα ὤν, ''Critias, being one of the Thirty''). A single genitive construction covers what English needs several constructions for.',
    'A real generalization: the genitive marks the SOURCE/GROUP a subject''s identity is drawn from or belongs to — descent, material, or social/political membership are all structurally the same relationship in Greek, where English requires three different prepositional phrases.',
    NULL,
    'Descent/origin usage especially prominent in epic and tragedy (self-identification formulae); class-membership usage especially frequent in oratory and historiography.',
    'τῶν φίλων/τῶν τριάκοντα (κτλ.) εἶναι — ''to be one of the friends/the Thirty (etc.)'', i.e. to belong to a named group.',
    'εἰμί + a bare genitive noun can mean ''I am descended from X,'' ''this is made of X,'' or ''I belong to the group X'' — context tells you which of the three English translations to reach for.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S055',
    'L007',
    'Impersonal modal — ἔστι + infinitive, ''it is possible (to)''',
    'يمكن أن، من الممكن',
    'The impersonal 3rd singular ἔστι (or ἦν, ἔσται) governing an infinitive, expressing bare possibility: εἴ τί που ἔστι, ''if it is possible at all''; especially frequent negated, οὐκ ἔστι Διῒ μάχεσθαι, ''it is not possible to fight with Zeus.'' A related idiom, ἑκὼν εἶναι (''as far as it depends on being willing'' = ''voluntarily''), shows the infinitive εἶναι itself becoming a fixed, semantically bleached tag in certain set phrases.',
    'A modal, not existential or copular use: ἔστι here doesn''t assert that some thing exists or that a predicate applies to a subject, but that an action is POSSIBLE.',
    'Near-synonym: ἔξεστι (''it is permitted/possible'') — closely overlapping, though ἔξεστι tends toward permission and ἔστι toward bare possibility.',
    'Frequent from Homer through Attic prose; especially common negated (impossibility) across all genres.',
    'οὐκ ἔστι + infinitive — ''it is not possible to...''; ἑκὼν εἶναι — ''voluntarily, as far as willingness goes.''',
    'ἔστι/ἦν + a bare infinitive (no expressed subject) is almost always this modal-possibility idiom — mentally supply ''it is possible'' rather than forcing an existential or predication reading.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S056',
    'L007',
    'Existential + relative clause idiom — εἰσὶν οἵ / ἔστιν ἅ / ἔστιν ὅτε',
    'يوجد من... / بعض... / أحيانًا... (حسب السياق)',
    'εἰμί combined with a relative pronoun/particle forms a fixed idiom functioning like an indefinite pronoun or adverb: εἰσὶν οἵ, ''there are those who'' = Latin sunt qui = ''some (people)''; ἔστιν ἅ, ''some things''; ἔστιν ὅτε/ἔνθα/ὅπως, ''sometimes/somewhere/somehow.'' Notable quirk: εἰμί often stays SINGULAR (ἔστιν) even before a plural/differently-gendered relative clause (the schema Pindaricum) — the idiom is frozen, not fully re-agreeing with context.',
    'A grammaticalized idiom rather than a live existential claim: ''there are those who...'' functions as a fixed unit meaning roughly ''some (people)'', not really asserting existence as its main communicative point.',
    'Functionally equivalent to (and clearly the model for) Latin sunt qui, and English ''there are those who'' / ''some''.',
    'Attested from Homer (οὐκ ἔσθ'' ὃς...) through Attic prose (Thucydides, Plato) without significant change in the core idiom.',
    'εἰσὶν οἵ / ἔστιν οἵ — ''there are those who, some (people)''; ἔστιν ἔνθα/ὅπη/ὅπως/ὅτε — ''somewhere/somehow/sometimes.''',
    'εἰμί + a relative pronoun/particle, with no other clear subject, is very likely this fixed ''some/sometimes/somewhere'' idiom — translate the whole unit as an indefinite pronoun or adverb.'
);

-- Constructions (6 rows)
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C036',
    'S053',
    'ἔστι μοι (τι) — ''I have (something),'' literally ''it/something is to/for me'' — dative of the possessor with the possessed thing as grammatical subject of εἰμί.',
    'Dative (of the possessor).',
    'This is a dative of interest/advantage (specifically a ''dative of possession''): the possessor is marked as the one FOR WHOSE BENEFIT/IN WHOSE SPHERE the possessed thing exists, rather than as a direct grammatical possessor (which Greek could also express via a genitive) or an agent. Greek regularly prefers this oblique, benefit-marking dative construction for possession over a possessive genitive when the point is specifically ''having'' rather than mere association.',
    'Students accustomed to English''s transitive ''to have'' may struggle to identify the grammatical SUBJECT correctly — in ἓξ δέ οἱ υἷες ἔασιν (''six sons are to him''), υἷες (sons) is the subject and οἱ (dative, ''to him'') marks the possessor; a word-for-word translation without recognizing the idiom may misidentify who is doing what to whom.',
    'μοι/σοι/αὐτῷ etc., dative singular personal pronoun; εἰμί agrees in number/person with the POSSESSED thing (the grammatical subject), not with the possessor.',
    'The dative pronoun is an oblique dative of possession/interest; the possessed noun is the grammatical subject of εἰμί.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C037',
    'S054',
    'πατρὸς δ'' εἴμ'' ἀγαθοῖο — ''I am of a good father'' = ''I am the son of a good man'' — bare genitive marking descent/origin, no preposition required.',
    'Genitive (no preposition).',
    'A genitive of source/origin: Greek can mark ''descended from X'' with a bare genitive alone, the same general genitive-of-source logic already documented for δίκη''s C022 (λαμβάνειν, exacting FROM someone) — here applied to a completely different semantic domain (parentage/descent) via the same underlying case function. An equivalent, more explicit alternative exists using ἐκ + genitive (εἴμ'' ἐκ Παιονίης, ''I am from Paionia''), but the bare genitive alone is equally standard.',
    'Students may expect a preposition (ἐκ, ἀπό) before every ''descended from'' phrase and be surprised that the bare genitive alone is fully standard and, in some registers, more common — recognizing εἰμί + bare genitive as a complete, self-sufficient descent-construction (not an elliptical version of the ἐκ+genitive construction) avoids this confusion.',
    'πατρός, genitive singular of πατήρ (father).',
    'Adnominal/predicate genitive dependent on the implied predication, marking the source/origin of the subject''s identity.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C038',
    'S055',
    'ἔστι + bare infinitive (no expressed subject for ἔστι) — ''it is possible to...'', e.g. οὐκ ἔστι Διῒ μάχεσθαι, ''it is not possible to fight with Zeus.''',
    'N/A (governs an infinitive, not a case).',
    'This construction is included specifically to contrast with every other Construction in this database so far, all of which document a CASE εἰμί or another verb governs: here the governed complement is an INFINITIVE, not a noun in any case, and ἔστι itself has no expressed grammatical subject (it is impersonal) — recognizing when a construction''s key relationship is mood/verb-form-based rather than case-based is itself a skill this entry is well-positioned to teach.',
    'Students trained by this database''s heavy emphasis on case government may instinctively hunt for a governed case here and overlook that the real grammatical relationship is impersonal-verb-plus-infinitive, a different kind of syntactic dependency entirely.',
    'ἔστι, 3rd singular present indicative (impersonal use, no expressed subject); the following verb stands in the infinitive (e.g. μάχεσθαι, present middle/passive infinitive of μάχομαι).',
    'ἔστι functions impersonally; the infinitive is its logical complement, with any further noun in the dative (Διΐ) marking the person to whom the possibility/impossibility applies.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C039',
    'S051',
    'τῷ ὄντι — ''in reality, in fact, truly,'' literally ''in/by the thing-that-is'' — a fixed adverbial dative phrase built on the substantivized participle ὄν.',
    'Dative.',
    'A dative of manner/means, structurally similar to the λόγῳ/νόμῳ-type adverbial datives already documented across this database (λόγος''s C001, νόμος''s C010): the phrase marks the MANNER in which a claim holds true — ''in reality'' as opposed to merely ''in appearance'' — rather than a direct object or source. The fixed, idiomatic nature of the phrase (always dative, always with the article τῷ) makes it function almost as a single adverb rather than a live case-governed noun phrase, similar to δίκη''s fossilized X-δίκην idiom (C018), though here fossilized around the dative rather than the accusative.',
    'Students may translate this too literally (''by the being thing'') rather than recognizing the fully idiomatic ''in reality/truly'' sense — and should notice it directly continues the esse/videri (being/seeming) theme flagged in S051''s Nuance_Context, marking a claim as genuinely rather than merely apparently true.',
    'τῷ ὄντι, dative singular neuter of the substantivized participle ὤν/ὄν (from εἰμί), with the article τῷ.',
    'Fixed adverbial dative phrase modifying the truth-claim of the surrounding clause.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C040',
    'S052',
    'εἰμί + participle used periphrastically to represent a finite verb form, e.g. ἦν τεθνηκώς used for the pluperfect ἐτεθνήκει (''he had died''); πεφυκός ἐστι used for πέφυκε (''it is naturally so'').',
    'N/A (the participle agrees with the subject in case/number/gender as usual; no additional case is governed by this construction itself).',
    'Not a case-government point at all — the teaching value here is entirely about TENSE-FORMATION STRATEGY: Greek can build certain finite-verb meanings (especially pluperfect, and certain emphatic present/resultative senses) by combining εἰμί with a participle instead of using a single synthetic verb form, exactly the way English ''he had died'' periphrastically combines ''had'' + a participle. Recognizing εἰμί+participle as sometimes doing the job of an entirely different finite tense is essential for correctly identifying the tense/aspect actually being expressed.',
    'A student may translate ἦν τεθνηκώς as a simple imperfect (''he was dying/dead'' as an ongoing state) rather than recognizing it functions as a full pluperfect (''he HAD died'') — the periphrastic construction''s tense-value must be read off the PARTICIPLE''s own tense/aspect combined with εἰμί''s own tense, not assumed from εἰμί alone.',
    'τεθνηκώς, perfect active participle of θνῄσκω, agreeing with the subject; ἦν, imperfect indicative of εἰμί — the two combine to express a single pluperfect meaning.',
    'εἰμί functions as an auxiliary verb; the participle carries the primary lexical/aspectual content, together forming a single periphrastic finite-verb equivalent.',
    'The construction''s overall tense-value is NOT simply εἰμί''s own tense — ἦν (imperfect) + a perfect participle together yield a pluperfect meaning, a genuine case where combining two individually-simple forms produces a third, distinct grammatical value.'
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C041',
    'S056',
    'εἰσὶν οἵ / ἔστιν οἵ — ''there are those who,'' functioning as a fixed idiom equivalent to an indefinite pronoun (''some people'') — εἰμί + a relative pronoun with no other expressed antecedent.',
    'Nominative (οἵ, functioning as subject of its own clause) — though the idiom extends to oblique cases too (ἔστιν ὧν, ''of some'', genitive; ἔστιν οἷς, ''to/for some'', dative).',
    'Not fundamentally a case-choice teaching point (the relative pronoun simply takes whatever case its own clause requires) — the real teaching value is recognizing the WHOLE εἰμί+relative unit as a fixed, semi-grammaticalized idiom functioning like an indefinite pronoun, including the notable schema Pindaricum quirk: εἰμί frequently stays singular (ἔστιν) even before a plural or differently-gendered relative clause, since the idiom has become frozen rather than fully re-agreeing with its context each time.',
    'Students may try to identify a specific singular antecedent for ἔστιν when none exists, or be confused by the singular εἰμί appearing before what is clearly a plural or feminine referent (the schema Pindaricum) — recognizing the whole phrase as a fixed idiom for ''some/several'' resolves both confusions at once.',
    'οἵ, nominative masculine plural relative pronoun (or its case/gender/number variants: ἅ, ὅτε, ἔνθα, ὅπη, etc.); ἔστιν/εἰσίν, present indicative of εἰμί, often frozen in the singular regardless of what follows.',
    'εἰμί functions existentially/impersonally as the head of the idiom; the relative pronoun/particle introduces a headless relative clause functioning as the idiom''s real semantic content.',
    'The idiom''s frozen singular εἰμί (schema Pindaricum) despite plural/non-matching following relative clauses is itself a morphological quirk worth flagging as a named phenomenon, not an error.'
);

-- Citations (6 rows)
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit037',
    'C036',
    'Homer, Iliad 24.399 — ἓξ δέ οἱ υἷες ἔασιν (''and six sons are his'' = ''he has six sons'').',
    'The possessed sons, not the possessor, stand as grammatical subject of ἔασιν — a clean illustration of how Greek can express possession without a transitive ''have'' verb at all.',
    'له ستة أبناء / عنده ستة أبناء — Arabic له/عنده mirrors the same ''to/for him'' possession-marking structure as the Greek dative.',
    'Homer, Iliad, ed. West (Teubner) or Monro/Allen (OCT), Book 24, line 399.',
    'CONFIRMED — this exact citation (line reference and wording) is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit038',
    'C037',
    'Homer, Iliad 21.109 — πατρὸς δ'' εἴμ'' ἀγαθοῖο (''I am of a good father'').',
    'A formulaic self-identification pattern in heroic speech: naming one''s father via the bare genitive asserts both descent and, implicitly, inherited worth/status.',
    'أنا ابن رجل صالح / أبي رجل صالح',
    'Homer, Iliad, ed. West (Teubner) or Monro/Allen (OCT), Book 21, line 109.',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit039',
    'C038',
    'Homer, Iliad 21.193 — οὐκ ἔστι Διῒ μάχεσθαι (''it is not possible to fight with Zeus'').',
    'The impersonal construction lets the poet state a general, agentless truth about the limits of mortal power — ''one cannot'' rather than naming any specific person who fails to fight Zeus.',
    'لا يمكن محاربة زيوس / لا سبيل إلى قتال زيوس',
    'Homer, Iliad, ed. West (Teubner) or Monro/Allen (OCT), Book 21, line 193.',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit040',
    'C039',
    'Plato, Protagoras 328d — τῷ ὄντι, ''in reality, in fact'' (cf. also Phaedrus 244a, ἡ τῷ ὄντι ξυγγένεια, ''the genuinely real kinship'').',
    'Plato regularly deploys τῷ ὄντι to flag that a claim should be taken as truly, not merely apparently, the case — directly continuing the esse/videri distinction central to S051''s philosophical ''Being'' sense.',
    'في الواقع / حقًا / في حقيقة الأمر',
    'Plato, Protagoras and Phaedrus, ed. Burnet (OCT).',
    'CONFIRMED — this citation location is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit041',
    'C040',
    'Aeschylus, Agamemnon 869 — ἦν τεθνηκώς, used for the pluperfect ἐτεθνήκει (''he had died'').',
    'The periphrastic construction lets Aeschylus mark a completed prior state precisely, using the resultative force of the perfect participle (τεθνηκώς, ''having died, being dead'') combined with εἰμί''s own past tense.',
    'كان قد مات (استخدام العربية الوصفي المماثل: الفعل الناقص + اسم الفاعل)',
    'Aeschylus, Agamemnon, ed. Fraenkel or Denniston-Page (OCT/commentary editions).',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit042',
    'C041',
    'Thucydides 6.88 and 7.44; Plato, Meno 77d and Gorgias 503a — εἰσὶν οἵ / ἔστιν οἵ, ''there are those who'' (= Latin sunt qui), used exactly like the indefinite ἔνιοι (''some'').',
    'Four independent authors/works using the identical fixed idiom confirms this is a stable, grammaticalized construction across Classical prose genres (historiography and philosophical dialogue alike), not a one-off stylistic choice.',
    'يوجد من / هناك من / بعض الناس',
    'Thucydides, Historiae, ed. Jones & Powell (OCT); Plato, Meno and Gorgias, ed. Burnet (OCT).',
    'CONFIRMED — these citation locations are directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
