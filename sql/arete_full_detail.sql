-- Classical Language Database — ἀρετή (L005), full detail
-- Run AFTER logos, nomos, psyche, and dike are already loaded.
-- 3 of the 10 senses (S035 prosperity, S039 military engine, S040 medicinal plaster) intentionally
-- have NO Construction/Citation rows -- S035 for lack of distinctive grammar to teach; S039/S040
-- because they are UNVERIFIED senses flagged for direct LSJ/TLG checking, not to be guessed at.

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

-- Lemma: ἀρετή
INSERT INTO Lemmas (
    Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field, Cross_Language_Connection, Modern_Resonance, Classical_Concept
) VALUES (
    'L005',
    'ἀρετή',
    'Ancient Greek',
    'Connected to ἀρείων/ἄριστος (''better/best''), NOT primarily to ἀνήρ (''man'') despite the Latin virtus (vir, ''man'') analogy sometimes drawn — that analogy is useful for understanding how a ''manly excellence'' specialization developed independently in both languages, not evidence of shared etymology. Descendants: Modern Greek αρετή (virtue); ''aristocracy'' (ἄριστος + κράτος, ''rule by the best'') shares the root family, though not a direct derivative of ἀρετή itself. Arabic has no cognate; renderings split extremely widely by sense — تفوق/امتياز (general excellence), بسالة/شجاعة (martial prowess), فضيلة (moral virtue), جودة/كفاءة (functional quality), مجد/شرف (glory) — arguably the widest Arabic-rendering split of any word in this database so far, wider even than δίκη.',
    'General excellence/superiority/merit, martial prowess, functional quality of a person/animal/thing, moral virtue, meritorious service, prosperity/well-being, distinction/glory, mighty deeds/divine manifestations, the personified figure Arete, and (disputed, unverified) a military engine and a medicinal plaster.',
    'Latin virtus is the classic comparandum — both words move from ''excellence in a specific capacity'' toward ''moral virtue'' via a martial-excellence specialization, though independently (virtus from vir, ''man''; ἀρετή from ἀρείων/ἄριστος, ''better/best'', not ἀνήρ). Arabic فضيلة is the standard rendering for the moral-philosophical sense ONLY — using it for Homer''s ποδῶν ἀρετή (''excellence of feet/running'') would be a serious translation error, exactly the risk this entry is built to prevent.',
    '''Aristocracy'' preserves the root''s ''best/excellent'' sense (rule by the ἄριστοι). Aristotle''s ἀρετή/κακία-based virtue ethics is a direct ancestor of modern virtue ethics as a category distinct from consequentialism and deontology. The function-argument use anticipates later teleological and functionalist accounts of goodness.',
    'ἀρετή is best understood as a strongly RADIAL semantic network centered on ''excellence or superior quality in relation to some capacity, function, or standard'' — structurally closer to λόγος''s radial pattern than to ψυχή''s diachronic replacement or δίκη''s institutional branching. From this core, Greek develops: heroic/martial excellence, functional excellence, moral virtue (via the stable ἀρετή/κακία opposition), meritorious service, mighty deeds, and social distinction/glory. DESIGN NOTE: the single greatest translation risk with this word is defaulting to فضيلة (''virtue'') for every occurrence — correct only for the specifically philosophical moral sense (S033) and badly distorting Homer and most non-philosophical Greek, where ''excellence/prowess/quality'' is meant instead. Two senses (S039 military engine, S040 medicinal plaster) are flagged UNVERIFIED — reported in some lexicographic sources but not confirmed here against primary attestation; treat as provisional pending direct LSJ/TLG verification.'
);

-- Senses (10 rows)
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S031',
    'L005',
    'General excellence, superiority, or outstanding quality (incl. martial prowess as a specialization)',
    'تفوق، امتياز، براعة، كفاءة',
    'The broadest and most fundamental sense: the quality of being especially good, capable, or outstanding in some respect — covers Homer''s παντοίας ἀρετάς (''excellences of every kind''), spanning physical ability, fighting skill, speed, intelligence, counsel, and (for women) attractiveness/admirable qualities. A historically prominent SPECIALIZATION within this same sense, not an independent sense, is heroic/martial excellence — prowess, valor, courage as displayed by a warrior in battle. Kept as a sub-case here rather than a separate Sense row because it remains fundamentally ''excellence displayed in a particular human capacity'' — the same mental model as the general sense, just narrowed to a historically dominant domain (combat).',
    'Close to literal: ''being especially good at X,'' where X is supplied by context — no moral claim is implied at this broadest level.',
    'Overlaps with κράτος (strength/power) and κῦδος (glory resulting from excellence, cf. S036) in Homeric usage; the martial specialization overlaps with Latin virtus as a cross-linguistic analogy (independent development, not shared etymology).',
    'Pervasive in Homer as ''excellence in some named capacity''; the martial specialization is especially prominent in heroic epic and remains dominant through the Archaic period before the functional (S032) and moral (S033) senses develop distinct technical weight.',
    NULL,
    'Ask ''excellent AT WHAT?'' — the answer supplied by context (running, fighting, counsel) is doing the real work; don''t default to ''virtue'' here, especially in Homer, where a purely moral sense is essentially absent.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S032',
    'L005',
    'Functional excellence; quality or fitness of a person, animal, or thing',
    'جودة، كفاءة، ميزة، خصوبة (بحسب السياق)',
    'A major generalization beyond human/heroic qualities: ἀρετή belongs to a horse (ἀρετὴ ἵππου), a tool (ἀρετὴ σκεύους), fertile land (a field''s ἀρετή = its productiveness), a craft, or a constitution (ἀρετὴ πολιτείας) — any thing considered in light of how well it performs what it is for. Becomes philosophically load-bearing in Plato''s and Aristotle''s ''function argument'' (ἔργον-based reasoning): a thing''s ἀρετή is what allows it to perform its characteristic function well.',
    'A genuine conceptual shift from S031: not ''what admirable quality does a person possess'' but ''how well does this thing perform or realize what it is for'' — applies naturally to inanimate objects in a way the heroic/personal sense does not.',
    'Related technical term in the function-argument: ἔργον (the characteristic function a thing performs), of which ἀρετή is the excellence in performing.',
    'Attested in ordinary Greek across all periods (a good horse, good land) but becomes a loaded philosophical technical term via Plato''s Republic I function argument and Aristotle''s teleological ethics.',
    NULL,
    'If ἀρετή belongs to a horse, tool, field, or constitution rather than a person''s character, you''re in this functional sense — think ''fitness for purpose,'' not ''moral goodness.'''
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S033',
    'L005',
    'Moral virtue; excellence of character',
    'فضيلة، فضيلة أخلاقية',
    'The famous philosophical sense — but NOT the word''s original or semantically central meaning; a technical specialization built on the general-excellence core (S031), defined by a stable technical opposition: ἀρετή ↔ κακία (virtue versus vice/badness). For Aristotle (Nicomachean Ethics II), ἀρετή is systematically defined as a settled disposition (ἕξις) concerned with choice — a technical transformation of the broader excellence-concept, not simply ''more of the same'' as Homeric prowess.',
    'Achilles''s ἀρετή in battle (S031, superior performance/capacity) versus ''justice is an ἀρετή'' (this sense, moral character) are genuinely different claims — the first about capability, the second about character.',
    'Defining antonym: κακία (vice, badness of character) — the strongest technical-opposition evidence in the entire entry for treating this as an independent sense.',
    'Distinctly Classical philosophical usage (Socratic dialogues, Plato, especially Aristotle''s systematic virtue ethics); THE sense a default translation to فضيلة is correct for — and most likely to be wrongly imported into Homeric or everyday passages.',
    NULL,
    'Only use ''virtue'' here if κακία (vice) is doing real opposing work nearby, or the passage is explicitly philosophical/ethical — otherwise you''re very likely looking at S031 or S032 instead.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S034',
    'L005',
    'Merit or excellence demonstrated through beneficial service',
    'خدمة جليلة، إحسان، فضل',
    'ἀρετὴ εἰς τινα / ἀρετὴ περί τινα — merit demonstrated TOWARD someone through beneficial action: service, benefaction, meritorious conduct. Extremely well-attested in Athenian honorific-decree formulae (e.g. ''on account of his ἀρετή and goodwill toward the city''), where ἀρετή names a benefactor''s record of good service, not an abstract personal quality or moral-philosophical virtue.',
    'A shift from ''a quality someone possesses'' (S031/S033) to ''a beneficial action or service someone performs toward another party'' — from static possession to a directed, relational act.',
    'Near-synonym in honorific-decree formulae: εὔνοια (goodwill) — ἀρετή and εὔνοια are frequently paired as the twin grounds for civic honors.',
    'Especially prominent in Hellenistic and Classical Athenian honorific inscriptions (decrees awarding citizenship, crowns, or honors to benefactors).',
    'τῆς ἀρετῆς ἕνεκα καὶ εὐνοίας (τῆς εἰς ...) — ''on account of his virtue/merit and goodwill (toward ...)'' — a standard honorific-decree formula.',
    'In an honorific inscription, ἀρετή names a track record of civic service/benefaction being rewarded — not an abstract personal virtue in the philosophical sense.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S035',
    'L005',
    'Prosperity, well-being, flourishing',
    'رخاء، ازدهار، رفاه',
    'A sense answering more to εὖ (''well'') than to ἀγαθός (''good'') — worth flagging explicitly, since it would be a mistake to force this meaning into the moral-virtue historical line (S033) simply because both ultimately relate to a broad concept of ''goodness.'' Here the reference is to a flourishing condition, not a possessed quality or moral character.',
    'A genuinely different conceptual model from every other sense so far: not ''a quality possessed by an individual'' but ''a state of flourishing or prosperity'' — closer to εὐδαιμονία''s territory than to any excellence/virtue sense.',
    'Close synonym: ὄλβος, εὐδαιμονία (prosperity/flourishing/happiness) in this specific usage.',
    NULL,
    NULL,
    'If ἀρετή is describing a state of flourishing or prosperity rather than a quality someone possesses or displays, you''re in this sense — don''t force a virtue or excellence reading onto it.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S036',
    'L005',
    'Distinction, honor, glory, or recognized merit',
    'مجد، شرف، منزلة، مآثر',
    'Where ἀρετή refers to the recognized distinction or lasting honor RESULTING FROM excellence, rather than the excellence itself — e.g. ''his ἀρετή is immortal'' directs attention to lasting glory/reputation rather than a possessed capacity. The key question is whether ἀρετή names the excellence itself or the glory it produces; this boundary is treated as moderately porous with S031 rather than fully resolved.',
    '''He possesses ἀρετή'' (S031, a quality) versus ''his ἀρετή is immortal'' (this sense, lasting distinction/fame) — a shift from possession to social recognition/legacy.',
    'Near-synonym: κῦδος, δόξα (glory, reputation) — sits close to the outcome-side of the excellence-produces-glory relationship.',
    'Present across epic, lyric, and epigraphic (funerary/honorific) usage wherever lasting reputation, rather than present capability, is the focus.',
    NULL,
    'Ask whether the passage is about a capability someone HAS or a reputation/legacy they''ve LEFT BEHIND — the latter is this sense, and the boundary with plain ''excellence'' (S031) is genuinely blurry, not a hard line.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S037',
    'L005',
    'Mighty or praiseworthy deeds; manifestations of excellence or power (esp. divine)',
    'مآثر، أعمال عظيمة، عجائب، معجزات',
    'Especially in the plural (ἀρεταί) and especially concerning gods: mighty deeds, glorious acts, manifestations of divine power, miracles. The focus falls on discrete EVENTS or DEEDS a god has performed, not an abstract quality the god possesses — translating this automatically as فضائل (''virtues'') would badly mislead in religious/devotional contexts, where ''mighty acts'' or ''wonders'' is meant instead.',
    'A significant shift in countability as much as meaning: ἀρετή as an abstract mass-noun quality (S031/S033) becomes ἀρεταί as a countable plural naming discrete events — structurally the SAME countability shift already documented for ψυχή/ψυχαί (S019 in that entry), now recurring in a second, unrelated lemma.',
    'Near-synonym in this religious-devotional register: θαύματα (wonders), δυνάμεις (mighty works/powers).',
    'Prominent in later religious/devotional Greek (Hellenistic and Imperial-period hymns, aretalogies — literally ''ἀρετή-accounts'' of a god''s deeds, a genre named directly after this sense).',
    NULL,
    'A countable plural ἀρεταί, especially describing what a god has done, means ''mighty deeds/wonders'' — not ''virtues.'' The genre cataloguing these is literally called an ''aretalogy,'' named after this exact sense.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S038',
    'L005',
    'Ἀρετή, the personified figure of Excellence/Virtue',
    'أريتي، تجسيد الفضيلة',
    'A distinct referential category, not merely a phase of the abstract sense: in Prodicus''s allegory ''The Choice of Heracles'' (reported by Xenophon, Memorabilia 2.1.21-34), Ἀρετή and Κακία appear as two women who approach the young Heracles at a crossroads, each urging him toward her own way of life — Ἀρετή promising a hard road toward genuine honor, Κακία promising an easy road toward pleasure. The personification embodies S033''s defining ἀρετή/κακία opposition as two literal characters with speech and agency.',
    '''Justice is an ἀρετή'' (S033, abstract quality) versus ''Ἀρετή spoke to Heracles'' (this sense, an agent with speech and a persuasive argument) — the reader must imagine a character, not a concept.',
    'Directly opposed, as a personified pair, to Κακία (personified Vice) in the same allegory — the abstract opposition (S033) made literal as two speaking characters.',
    'Attributed to the sophist Prodicus (5th c. BCE), known to us through Xenophon''s report rather than a surviving text by Prodicus himself; comparable to how Δίκη''s personification is known through Hesiod.',
    NULL,
    'If Ἀρετή is speaking, persuading, or making an offer to a hero at a crossroads, you''re reading the personified allegorical figure (most famously the Choice of Heracles), not the abstract philosophical concept.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S039',
    'L005',
    'A military engine (UNVERIFIED — treat with caution)',
    'آلة حربية (غير مؤكد)',
    'A reported technical/dialectal sense, completely detached from the excellence/virtue semantic network — some lexicographic sources list ἀρετή as a term for a piece of military equipment. This entry does NOT confirm this sense against a primary attestation or a specific LSJ citation; included provisionally pending independent verification against LSJ/TLG directly.',
    NULL,
    NULL,
    NULL,
    NULL,
    'Extremely rare, unverified technical sense — do not rely on this entry alone; check LSJ directly before citing this sense in any teaching material.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S040',
    'L005',
    'A medicinal plaster (UNVERIFIED — treat with caution)',
    'مرهم أو لصقة طبية (غير مؤكد)',
    'A second reported technical/dialectal sense, likewise completely detached from the excellence/virtue network and likewise NOT confirmed here against a primary attestation. Included provisionally on the same basis as S039 — verify against LSJ/TLG directly before teaching or publishing this as a confirmed sense.',
    NULL,
    NULL,
    NULL,
    NULL,
    'Extremely rare, unverified technical sense — check LSJ directly before relying on this entry for this specific meaning.'
);

-- Constructions (6 rows)
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C024',
    'S031',
    'ἀρετή + dependent genitive naming the specific capacity in which excellence is displayed (e.g. a phrase of the pattern ''X-ῶν ἀρετή,'' ''excellence of/in X'').',
    'Genitive.',
    'A genitive of specification/domain: the genitive noun names the particular capacity or sphere the excellence belongs to (running, fighting, counsel), not a possessor in the ordinary sense and not a source. Structurally the same genitive function later built for ψυχή''s C015 (ἐντελέχεια σώματος) and echoed again in this entry''s C026 (ἀρετὴ τῆς ψυχῆς) — a recurring genitive-of-specification pattern worth recognizing across the whole database, not just within one lemma.',
    'Students may default to reading this genitive as simple possession (''the excellence belonging to running'') rather than specification of domain (''excellence IN the sphere of running'') — a subtle but real difference in emphasis.',
    'Genitive singular or plural of the noun naming the capacity/domain, varying by context.',
    'Adnominal genitive dependent on ἀρετή, specifying the domain of the excellence named.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C025',
    'S032',
    'ἀρετή + genitive of the organ/tool/thing whose functional excellence is meant (e.g. Plato''s function argument, Republic I, asking whether eyes (ὀφθαλμοί) and ears (ὦτα) each have their own ἀρετή).',
    'Genitive.',
    'The same genitive-of-specification function as C024, but the philosophical weight here is in what kind of noun can fill the genitive slot: extending it to inanimate organs/tools (rather than only capacities like running or fighting) is precisely what generalizes ἀρετή from a heroic/personal quality (S031) into a fully general functional concept (S032) applicable to anything with a characteristic ἔργον.',
    'Students trained on Homeric ἀρετή (heroic prowess) may resist accepting that a mere tool or body-part can have its own ἀρετή — recognizing that the genitive slot generalizes freely to any functional item is the actual philosophical move Plato is making, not a loose or metaphorical extension.',
    'ὀφθαλμῶν, genitive plural of ὀφθαλμός; ὤτων, genitive plural of οὖς (ear).',
    'Adnominal genitive dependent on ἀρετή, naming the functional item whose excellence is under discussion.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C026',
    'S033',
    'ἀρετή + genitive naming the faculty or entity of which moral excellence is predicated (e.g. ἀρετὴ τῆς ψυχῆς, ''excellence/virtue of the soul,'' the standard Aristotelian way of specifying that a virtue belongs to the character-bearing part of a person).',
    'Genitive.',
    'The same genitive-of-specification function built for C024/C025, now applied to the specifically moral-philosophical sense — directly parallel to and cross-referencing ψυχή''s own C015 construction (ἐντελέχεια σώματος), which used the same genitive function to specify what a different abstract noun (ἐντελέχεια) was the actuality OF. Recognizing this recurring genitive pattern across ἀρετή, ψυχή, and (differently) δίκη''s genitive-of-source contrast (C022) is itself a mature cross-lemma reading skill this database is specifically designed to build.',
    'Given how many different genitive functions this database has now documented (specification/domain here; source in δίκη''s λαμβάνειν construction; reference in λόγος''s διδόναι construction), students should not assume all X+genitive constructions work the same way — the verb or governing noun always determines which genitive function is active.',
    'τῆς ψυχῆς, genitive singular of ψυχή, -ῆς, ἡ.',
    'Adnominal genitive dependent on ἀρετή, specifying the entity (the soul, in Aristotelian usage) whose excellence is meant.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C027',
    'S034',
    'τῆς ἀρετῆς ἕνεκα καὶ εὐνοίας τῆς εἰς (τὸν δῆμον) — ''on account of his virtue/merit and goodwill toward (the people),'' εἰς governing the accusative to mark the beneficiary/target of the meritorious service.',
    'Accusative (governed by εἰς).',
    'εἰς + accusative marks the direction/target the goodwill and service are aimed at (''toward, in the direction of the people/city'') — the standard case for a benefit''s recipient in this formula. Some honorific formulae instead use περί + accusative (''concerning, regarding''), a subtly different framing (the city as a topic of concern) rather than εἰς''s directed-benefit framing (the city as the recipient of directed service) — the choice between the two prepositions in a given decree is not random.',
    'Students may treat εἰς and περί as interchangeable in these honorific formulae since both can be loosely translated ''toward/regarding'' in English — recognizing the directed-benefit versus topic-of-concern distinction sharpens the reading of exactly what kind of service is being honored.',
    'τὸν δῆμον (or similar), accusative singular, governed by εἰς.',
    'Adverbial prepositional phrase modifying εὐνοίας/ἀρετῆς, marking the beneficiary of the service being honored.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C028',
    'S037',
    'ἀρεταί (plural), naming discrete mighty deeds/manifestations rather than an abstract mass-noun quality — structurally the same countability shift already documented for ψυχή/ψυχαί in that entry''s C016.',
    'Nominative or accusative plural, depending on syntactic role.',
    'Not primarily a case-choice teaching point — the real signal, exactly as with ψυχαί, is NUMBER and countability: an abstract quality noun appearing as a directly countable plural (able to be listed, recounted, or witnessed one by one) is the grammatical marker flagging the ''discrete deeds'' sense rather than case morphology alone. This is the second time this exact countability-shift pattern has appeared in the database (cf. ψυχή S019/C016), suggesting it may be a general feature of Greek abstract-quality nouns worth watching for in future words.',
    'A student who encounters ἀρεταί and defaults to ''virtues'' (plural of the moral sense, S033) may miss that in a religious/devotional or aretalogical context, discrete recountable ''mighty deeds'' is meant instead — check whether the deeds are being listed/narrated as events.',
    'ἀρεταί, nominative plural of ἀρετή; ἀρετάς, accusative plural.',
    'Functions as a countable plural subject or object, naming a list of discrete events rather than a single abstract quality.',
    'The shift from a mass-noun to count-noun reading is signaled by the plural form itself combined with a context of enumeration/narration, not by any change in case.'
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C029',
    'S038',
    'Ἀρετή as grammatical subject of verbs of speech and persuasion (e.g. addressing, promising, urging) in Prodicus''s allegory of the Choice of Heracles (reported in Xenophon, Memorabilia 2.1.21-34) — the same personification-signaling pattern already built for Δίκη''s C019, now recurring in a second lemma.',
    'Nominative (subject).',
    'Not a case-choice teaching point — the signal is syntactic role, exactly as with Δίκη: Ἀρετή taking an active verb of speech/persuasion as its subject, and appearing alongside a second personified figure (Κακία) as a dialogue partner/rival, is what flags personification rather than the abstract sense (S033).',
    'A student who has only encountered ἀρετή as an abstract quality may flatten ''Ἀρετή spoke to him, promising...'' into a metaphorical figure of speech rather than recognizing Prodicus''s allegory as constructing an actual scene with two speaking characters making competing offers.',
    'Ἀρετή, nominative singular, capitalized in modern editions to mark personification.',
    'Subject of verbs of speech, persuasion, and offering; paired with Κακία as a rival speaking character in the same scene.',
    NULL
);

-- Citations (6 rows)
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit024',
    'C024',
    'Formulaic across Homeric epic — ἀρετή + a genitive naming a specific capacity (running, fighting, counsel) is a recurring pattern rather than tied to one canonical locus.',
    'The pattern''s productivity across the Iliad and Odyssey is itself the point: ἀρετή is generically available to name excellence in any specified domain, not fixed to one context.',
    'براعة في / تفوق في (context-dependent, following the genitive noun''s domain).',
    'General usage pattern across Homeric epic (OCT/Teubner editions).',
    'FLAG: describes a usage pattern, not one verbatim citation — select a specific Iliad/Odyssey passage and verify exact wording against TLG before publishing a pinned example.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit025',
    'C025',
    'Plato, Republic I, 352d-354a — the ''function argument'' (Socrates asking whether eyes, ears, and other things each have their own characteristic ἔργον and therefore their own ἀρετή).',
    'Plato needs ἀρετή rather than a narrower word because his argument specifically requires the same term to apply uniformly across persons, organs, and tools — building toward the claim that the soul too has a characteristic function and therefore its own ἀρετή (justice), the dialogue''s guiding question.',
    'كفاءة العين / جودة أداء الأذن — a technical philosophical rendering emphasizing fitness-for-function rather than فضيلة, which would be badly out of place for eyes and ears.',
    'Plato, Republic, ed. Slings (OCT), Book I, Stephanus 352d-354a.',
    'FLAG: verify exact Stephanus range and Greek wording against the OCT before quoting verbatim — this entry paraphrases the argument''s structure rather than quoting extended Greek directly.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit026',
    'C026',
    'Aristotle, Nicomachean Ethics II.6 (Bekker 1106a-1107a) — the definition of ἀρετή (of the soul/character) as a settled disposition (ἕξις) concerned with choice, lying in a mean relative to us.',
    'Aristotle retains ἀρετή rather than coining a new term because he wants continuity with the ordinary Greek concept of excellence while giving it a precise technical definition — the argument depends on ἀρετή still meaning ''excellence,'' now specified for a rational soul''s character.',
    'فضيلة النفس (اعتيادًا راسخًا يتعلق بالاختيار) — the standard Arabic Aristotelian-tradition rendering, drawing on the historical Arabic Aristotle translation vocabulary.',
    'Aristotle, Nicomachean Ethics, ed. Bywater (OCT), Bekker 1106a-1107a.',
    'FLAG: verify the precise Greek wording and Bekker line reference against the OCT before quoting verbatim — this is a famous, frequently-cited definition worth getting exact if quoted directly.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit027',
    'C027',
    'Standard formula across Athenian honorific decrees (IG II² inscriptions) — τῆς ἀρετῆς ἕνεκα καὶ εὐνοίας τῆς εἰς τὸν δῆμον, ''on account of his virtue/merit and goodwill toward the people.''',
    'The formula pairs ἀρετή (a benefactor''s track record of good service) with εὔνοια (goodwill) as the two standard grounds cited across hundreds of surviving Athenian honorific decrees for awarding citizenship, crowns, or other honors.',
    'بسبب فضله وحسن نيته تجاه الشعب — فضل here captures the honorific ''meritorious service'' sense better than the philosophical فضيلة would.',
    'Inscriptiones Graecae II² (IG II²), the standard corpus of Athenian inscriptions.',
    'FLAG: describes a widely recurring formula rather than one single verbatim inscription — pin to a specific IG II² decree number and verify exact wording before publishing a specific citation.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit028',
    'C028',
    'The aretalogy genre (Hellenistic and Imperial-period hymns and inscriptions cataloguing a god''s ἀρεταί, e.g. the Isis aretalogies) — ἀρεταί as a list of the god''s mighty deeds and manifestations of power, recounted for worshippers.',
    'The genre is literally named after this sense of the word (an ''aretalogy'' = an ''ἀρετή-account''), and the deeds are presented as an enumerable list — precisely the countable-plural pattern C028 documents.',
    'مآثر الإلهة / أعمال الإلهة العظيمة — مآثر captures the countable, enumerable ''mighty deeds'' sense correctly, where فضائل (virtues) would badly mislead a reader into a moral-philosophical register.',
    'Surviving Isis aretalogies (e.g. the Kyme inscription); general genre description per standard classical scholarship on Hellenistic religion.',
    'FLAG: describes a genre and its general content rather than one pinned verbatim citation — select a specific aretalogy inscription (e.g. the Kyme text) and verify exact wording against a critical edition before publishing a specific quotation.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit029',
    'C029',
    'Xenophon, Memorabilia 2.1.21-34 — Prodicus''s allegory of the Choice of Heracles: Ἀρετή and Κακία, personified as two women, each approach Heracles at a crossroads and argue for their own way of life.',
    'The allegory embodies the abstract ἀρετή/κακία opposition (S033) as two literal speaking characters, making a moral-philosophical abstraction vivid and dramatically persuasive — precisely the same rhetorical move Hesiod makes personifying Δίκη.',
    'أريتي (تجسيدًا) / الفضيلة متجسدة — as with personified Δίκη, proper-name treatment of the personification is kept distinct from the common abstract noun.',
    'Xenophon, Memorabilia, ed. Marchant (OCT), Book 2, chapter 1, sections 21-34.',
    'FLAG: verify exact section numbers and Greek wording against the OCT before quoting verbatim — this entry paraphrases the allegory''s content and structure rather than quoting extended Greek directly. Note also that Xenophon reports Prodicus''s allegory secondhand; no text by Prodicus himself survives.'
);
