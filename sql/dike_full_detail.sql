-- Classical Language Database — δίκη (L004), full detail
-- Run AFTER logos, nomos, and psyche are already loaded.
-- 3 of the 9 senses (S023 right/fitting, S024 abstract Justice, S030 Pythagorean number)
-- intentionally have NO Construction/Citation rows in this pass -- S023/S024 because the
-- boundary is porous and the teaching value is lexical/semantic rather than grammatical;
-- S030 because primary sourcing is genuinely disputed and should not be guessed at.

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

-- Lemma: δίκη
INSERT INTO Lemmas (
    Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field, Cross_Language_Connection, Modern_Resonance, Classical_Concept
) VALUES (
    'L004',
    'δίκη',
    'Ancient Greek',
    'Possibly connected to δείκνυμι, ''to show, point out'' (disputed etymology) — if correct, the oldest sense may be ''the way pointed out / customary way.'' Descendants: Modern Greek δίκη (trial, lawsuit); ''theodicy'' (θεός + δίκη, ''justification of God''s justice,'' Leibniz''s coinage) preserves the abstract-justice sense in English. Arabic has no cognate; renderings split across عرف/عادة (custom), حق/عدل (right/justice), حكم/قضاء (judgment), دعوى (lawsuit), and جزاء/عقوبة (penalty) — one of the widest Arabic-rendering splits of any word in this database so far.',
    'Custom/manner, right order, abstract Justice, the personified goddess Dike, judicial judgment, lawsuit/legal action, trial/proceedings, penalty/retribution, and (marginally, disputed) a Pythagorean symbolic number.',
    'Latin ius (right/law) and iustitia (justice) roughly track δίκη''s normative senses, while lis/actio track the lawsuit sense and poena tracks the penalty sense — Latin, like Arabic, needs several distinct words for δίκη''s range. Parallels the νόμος entry''s design note: a wide institutional/normative range, here centered on ''what is due/right'' rather than ''what is customary/enacted.''',
    '''Theodicy'' (θεοδικία) draws directly on δίκη. The δίκη/βία (right/force) opposition anticipates later just-war and legal-positivism-vs-natural-right debates; the δίκη/γραφή (private/public action) distinction is a direct ancestor of the modern civil/criminal law split.',
    'δίκη is the semantic and institutional core of Greek legal and ethical thought: from Hesiod''s Works and Days (Dike as a wronged goddess reporting unjust judges to Zeus), through Athenian legal vocabulary (a δίκη as a private lawsuit, contrasted with a γραφή, a public prosecution), to Aeschylus''s Oresteia, whose plot arguably traces how δίκη should be institutionally realized — from cyclical private vengeance (Sense 8) to the new Athenian court system (Sense 6, founding of the Areopagus). DESIGN NOTE: unlike ψυχή (Arabic mostly unchanged across radically different concepts), δίκη behaves more like νόμος — most senses DO trigger a different Arabic word. Two genuinely porous boundaries stay flagged rather than resolved: Sense 2 (right/fitting) vs. Sense 3 (abstract Justice) shade into each other; a disputed ''Truth'' gloss sometimes given for Pindaric δίκη is deliberately NOT promoted to its own sense — provisionally folded into Sense 2/3 pending passage-level verification, per the house rule against multiplying senses from a single dictionary gloss alone.'
);

-- Senses (9 rows)
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S022',
    'L004',
    'Custom, usage, established way / manner',
    'عرف، عادة، طريقة',
    'The oldest recoverable sense: the way something is normally done, an established custom or characteristic manner — e.g. αὕτη δίκη ἐστὶ βροτῶν, ''this is the way of mortals.'' Includes the adverbial idiom X-δίκην + genitive, ''in the manner of X'' (e.g. λύκου δίκην, ''wolf-fashion''), treated as a constructional development of this sense rather than an independent lexical sense.',
    'No court, judge, or moral claim is implied here — the reader imagines a customary pattern or characteristic manner, not right/wrong.',
    'Near-synonym: ἔθος, νόμος (S007, custom sense) — δίκη and νόμος overlap significantly in this oldest layer, before their institutional paths diverge.',
    'Archaic and poetic usage; the base layer the normative senses (S023 onward) develop from.',
    'X-δίκην + genitive — ''in the manner/fashion of X'' (fossilized adverbial accusative, functioning almost like a preposition).',
    'The ''thin'' sense — just ''the customary way,'' no justice-claim yet. If δίκην follows a genitive noun directly, you''re very likely in this idiomatic ''in the manner of'' construction, not the legal sense.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S023',
    'L004',
    'Right, what is fitting, proper, or due',
    'حق، صواب، ما هو مناسب أو مستحق',
    'The principal normative sense: the proper order of things, what is fitting or due — often opposed to βία (force). δίκη ἐστί can mean simply ''it is right/fitting.'' NOTE: this boundary with S024 (abstract Justice) is genuinely porous; not every occurrence can be mechanically assigned to one or the other. A disputed ''Truth'' gloss occasionally given for Pindaric δίκη is provisionally folded into this sense pending passage-level verification, rather than promoted to its own sense.',
    'A real conceptual step beyond S022: ''that is our custom'' (what normally happens) versus ''that is what is right'' (what ought properly to happen) are different claims, even before any legal machinery is invoked.',
    'Opposed to βία (force) — a normative rather than narrowly technical opposition.',
    NULL,
    NULL,
    'This sense answers ''what is the right thing here?'' in a specific situation — more localized than S024''s ''Justice'' as a governing cosmic principle.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S024',
    'L004',
    'Justice as an abstract normative or cosmic principle',
    'العدل، العدالة',
    'Justice as an abstract moral or cosmic principle governing right and wrong, rather than a judgment about one particular situation (contrast S023). Heavily present in tragedy (Aeschylus''s Oresteia is centrally about δίκη as a governing principle) and later political/philosophical thought.',
    '''This action is fitting'' (S023) versus ''Justice punishes the wicked'' (this sense) — the latter invokes a governing normative power distributing right and wrong generally, not a verdict on one case.',
    'Antonym: ὕβρις (arrogant transgression) — a major structuring opposition in tragedy and archaic poetry.',
    'Central to Aeschylus and to archaic ethical poetry (Hesiod, Solon); later absorbed into philosophical and political theory as an abstract governing principle.',
    NULL,
    'This sense invokes a systemic, governing principle — ''what principle distributes right and wrong generally'' — not just ''what''s right in front of me right now'' (S023).'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S025',
    'L004',
    'Δίκη, the personified/divine embodiment of Justice',
    'ديكي، إلهة العدالة',
    'Not merely a capitalization convention: personification changes what kind of thing δίκη is. In Hesiod''s Works and Days, Δίκη is a maiden goddess, daughter of Zeus, who reports unjust, bribe-taking judges to her father when men give crooked judgments against her.',
    '''Justice must prevail'' (S024, abstract principle) versus ''Dike, daughter of Zeus, sees the wrongdoing'' (this sense, an agent who sees, reports, and acts) — the reader must imagine a person with genealogy and agency, not a principle.',
    NULL,
    'Archaic religious/poetic personification (Hesiod, 8th-7th c. BCE); the mythological ancestor that the abstract principle (S024) is arguably derived from, though treated here as a distinct referent, not merely an earlier phase of the same sense.',
    NULL,
    'If Δίκη is the grammatical subject of verbs like ''sees,'' ''reports,'' or ''sits beside (Zeus),'' you''re reading personification, not the abstract principle — she is a character in these passages, not a concept.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S026',
    'L004',
    'Judgment, adjudication, judicial decision',
    'حكم، قضاء',
    'An authoritative decision or verdict concerning what is right — e.g. δίκην εἰπεῖν, ''to pronounce judgment,'' δίκην δικάζειν, ''to render a verdict.'' Distinguished from S027 (lawsuit, the case itself) and S024 (Justice, the abstract principle being applied): this sense names the institutional act of applying the norm, not the norm itself or the proceeding that produces the act.',
    'Justice (S024) is a principle; a judgment is an ACT performed by an adjudicator applying that principle to a specific case — norm versus institutional application of norm.',
    NULL,
    'Embedded throughout Athenian judicial vocabulary and oratory.',
    NULL,
    'A judgment is the decision an adjudicator hands down — keep this distinct from ''lawsuit'' (the case brought) and ''Justice'' (the abstract principle being applied).'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S027',
    'L004',
    'Lawsuit, legal action (especially private suit)',
    'دعوى قضائية، دعوى خاصة',
    'A legal action brought before a court — especially, in the technical Athenian system, a PRIVATE action, standing in a stable, well-documented technical opposition to γραφή, a PUBLIC prosecution/indictment. δίκην λαγχάνειν (τινί) — ''to bring a suit (against someone).'' This δίκη/γραφή contrast is one of the strongest technical-opposition splits in this entire database.',
    'The reader imagines a plaintiff, a defendant, and a specific claim — a concrete legal action, not an abstract principle or a verdict.',
    'Stable technical opposition: δίκη (private action) versus γραφή (public prosecution) — roughly the ancestor of the modern civil/criminal law distinction.',
    'Central, highly technical Athenian legal vocabulary (Demosthenes, Lysias, Aristotle''s Athenian Constitution).',
    'δίκην λαγχάνειν (τινί) — ''to bring a suit against someone''; δίκην φεύγειν — ''to be a defendant, stand trial''; δίκην αἱρεῖν/νικᾶν — ''to win one''s case.''',
    'If the text is naming a specific case with a plaintiff and defendant, especially contrasted with a γραφή nearby, you''re in the technical private-lawsuit sense, not abstract justice.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S028',
    'L004',
    'Trial, hearing, legal proceedings',
    'محاكمة، إجراءات قضائية',
    'The process of hearing and determining a case, as distinct from the case itself (S027) or the verdict it produces (S026) — e.g. δίκην ὀφλεῖν/ὀφλισκάνειν, ''to lose one''s case'' (literally ''to incur/owe a δίκη''), naming an outcome of the proceeding.',
    '''A lawsuit'' names the case brought; ''a trial'' names the process of hearing and determining it — related but distinct institutional stages within the same juridical branch as S026/S027.',
    NULL,
    'Athenian judicial procedure vocabulary; frequently the target of comedy (e.g. Aristophanes'' Wasps, built around an old Athenian''s obsession with jury service and litigation).',
    'δίκην ὀφλεῖν / ὀφλισκάνειν — ''to lose one''s case'' (literally ''to incur a δίκη'' as a liability).',
    'Distinguish: the case itself (S027, lawsuit) versus the process of trying it (this sense) versus its outcome (S026, judgment, or S029, penalty).'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S029',
    'L004',
    'Due satisfaction, retribution, punishment, or penalty',
    'جزاء، عقوبة، قصاص، تعويض',
    'What someone receives or suffers as a consequence of a wrong — δίκην διδόναι, ''to pay the penalty / suffer punishment''; δίκην λαμβάνειν (τινός), ''to exact punishment/satisfaction from someone.'' Punishment (punitive, for the offender) and satisfaction/compensation (for the injured party) are treated as contextual realizations of one broader sense — the settlement or consequence owed because of an act — rather than split into separate senses. ''Vengeance'' (a common English gloss for λαβεῖν δίκην) is likewise not given its own sense: it is a translation outcome of this sense in context, not a distinct lexical item — English ''vengeance'' risks over-personalizing/emotionally coloring what Greek δίκη is doing here.',
    '''δίκη = justice'' (S024) versus ''δίκην διδόναι = suffer punishment'' (this sense) — the second is not an abstract principle but the result or settlement that principle demands: wrong → claim → adjudication → what is due → satisfaction/penalty.',
    NULL,
    'Recurring reciprocal legal/narrative formula across historiography (Herodotus, Thucydides) and oratory: διδόναι δίκην, λαμβάνειν δίκην, τίνειν/ἐκτίνειν δίκην.',
    'δίκην διδόναι — ''to pay the penalty''; δίκην λαμβάνειν (τινός) — ''to exact punishment from someone''; τίνειν/ἐκτίνειν δίκην — ''to pay/discharge the penalty.''',
    'This is the ''settling up'' sense — what''s actually paid or exacted once justice has been applied, not the principle or the verdict itself.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S030',
    'L004',
    'Pythagorean symbolic designation for a number (disputed)',
    'تسمية عددية رمزية (غير مؤكدة)',
    'A reported Pythagorean practice of associating δίκη symbolically with a specific number as part of a broader numerological system linking abstract concepts to numbers. TREAT WITH CAUTION: ancient and modern sources genuinely disagree on which number was associated with δίκη in this tradition, and this entry deliberately does NOT assert a specific number pending verification against a specialist source (e.g. Burkert, Lore and Science in Ancient Pythagoreanism) — do not guess or repeat an unverified number claim in teaching material.',
    'A completely separate technical-symbolic mental model from every other sense in this entry — the reader must imagine a numerological code, not a legal, moral, or narrative concept at all.',
    NULL,
    'Reported Pythagorean doctrine, known to us only secondhand through later sources; NOT primary Pythagorean testimony.',
    NULL,
    'Extremely rare and technical — you are very unlikely to meet this sense outside a text specifically discussing Pythagorean number-symbolism. [FLAG: no specific number is asserted in this entry; verify against a specialist secondary source before teaching a specific number claim.]'
);

-- Constructions (5 rows)
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C018',
    'S022',
    'X-δίκην + genitive — ''in the manner/fashion of X'' (e.g. λύκου δίκην, ''wolf-fashion''), a fossilized adverbial use of the accusative.',
    'Genitive (governed by the fossilized adverbial δίκην, not by a live preposition).',
    'δίκην here has stopped functioning as an ordinary case-governed noun and instead behaves almost like a postposition meaning ''in the manner of,'' taking a genitive the way a preposition would — a genuinely different construction type from every other pattern built so far in this database (not κατά/παρά/ἐν/ὑπέρ + case, and not a live direct object): it is a noun that has grammaticalized into something closer to a fixed adverbial marker.',
    'Students may try to parse δίκην here as a normal accusative direct object of a nearby verb and get confused when no verb fits — recognizing the fossilized idiom (genitive noun + δίκην = ''in the fashion of [noun]'') resolves this immediately.',
    'δίκην, accusative singular of δίκη, functioning adverbially; governs a genitive.',
    'Fossilized adverbial phrase, functioning almost like a preposition/suffix rather than a live case-governed noun phrase.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C019',
    'S025',
    'Δίκη as grammatical subject of verbs of perception/action (e.g. ''sees,'' ''reports,'' ''sits beside [Zeus]'') — the naming signal for personification.',
    'Nominative (subject).',
    'Not primarily a case-choice point (ordinary nominative subject) — the real teaching signal is syntactic role: Δίκη taking an active verb of perception, speech, or motion as its subject (rather than appearing as an abstract predicate or object of a normative verb) is what flags personification, parallel to how νόμος ὄρθιος''s attributive-adjective naming pattern flagged the musical sense.',
    'A student trained to read δίκη only as an abstract noun may flatten ''Dike sees the wrongdoing and tells her father'' into ''justice is done,'' losing the mythological agent Hesiod is actually describing.',
    'Δίκη, nominative singular, capitalized in modern editions to mark personification (the ancient text itself would not have marked this typographically).',
    'Subject of active verbs describing perception, speech, or motion.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C020',
    'S026',
    'δίκην δικάζειν — ''to render a verdict / give judgment,'' a cognate-object construction (verb and object share the same root sense).',
    'Accusative (δίκην, cognate/internal object of δικάζειν).',
    'A cognate-accusative construction: δικάζειν (''to judge'') takes δίκην (''a judgment'') as its direct object, the noun and verb sharing the same underlying idea — comparable to English ''to live a life'' or ''to fight a fight.'' The accusative here doesn''t mark a pre-existing external object being acted on, but names the very act the verb performs.',
    'Students may look for δίκην to refer to some separate, already-existing lawsuit being ''judged,'' rather than recognizing that the phrase names the act of judging itself.',
    'δίκην, accusative singular of δίκη; δικάζειν, present active infinitive.',
    'δίκην = cognate/internal direct object of δικάζειν.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C021',
    'S027',
    'δίκην λαγχάνειν (τινί) — ''to bring a suit against someone,'' accusative object + dative of the person against whom the suit is brought.',
    'Accusative (δίκην) + dative (the defendant).',
    'The dative here marks the person against/toward whom the legal action is directed — a dative of disadvantage/interest, the person the suit is ''aimed at.'' Greek does not require a preposition for this relationship; the bare dative alone signals ''against this person'' in this specific legal-procedural idiom.',
    'Students may expect a preposition (e.g. κατά + genitive, the more intuitively ''against''-feeling construction) and be surprised that this specific idiom instead uses a bare dative — a reminder that Greek legal formulae often have their own fixed case-patterns that don''t generalize from ordinary prose rules.',
    'δίκην, accusative singular; λαγχάνειν, present active infinitive of λαγχάνω (''to obtain by lot,'' hence ''to bring [a suit]'').',
    'δίκην = direct object of λαγχάνειν; the dative noun marks the person the suit is brought against.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C022',
    'S029',
    'δίκην λαμβάνειν (τινός) — ''to exact punishment/satisfaction from someone,'' accusative object + genitive of the wrongdoer.',
    'Accusative (δίκην) + genitive (the wrongdoer, source of the exacted penalty).',
    'This genitive is a genitive of source: it marks the person FROM WHOM the penalty is exacted — compare directly with S004''s λόγον διδόναι (τινός) built for λόγος, which used a genitive of REFERENCE (''an account concerning X''), not source. Same accusative-plus-genitive surface pattern across the database, two different genitive functions depending on the verb''s meaning — a useful cross-lemma teaching contrast.',
    'Students who learned λόγον διδόναι''s genitive-of-reference pattern may wrongly assume every X-noun+διδόναι/λαμβάνειν+genitive construction works the same way — here the genitive marks source, not topic, precisely because λαμβάνειν (''to take/exact'') implies taking FROM someone in a way διδόναι''s ''giving an account ABOUT'' does not.',
    'δίκην, accusative singular; λαμβάνειν, present active infinitive of λαμβάνω.',
    'δίκην = direct object of λαμβάνειν; the genitive noun marks the source the penalty is exacted from.',
    NULL
);

-- Citations (5 rows)
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit018',
    'C018',
    'Formulaic idiom across tragedy and Attic prose — X-δίκην (''in the fashion of X'') is a productive, recurring construction rather than tied to one canonical locus.',
    'The idiom''s productivity across genres and centuries is itself the point: δίκη here has grammaticalized into a near-preposition available for any comparison (X-δίκην = ''like X''), not a one-off poetic flourish.',
    'على طريقة / كأنه (context-dependent — Arabic typically needs a comparison particle plus a noun rather than a single fixed equivalent).',
    'General usage pattern across tragedy and Attic prose.',
    'FLAG: describes a productive idiom pattern, not one verbatim citation — select a specific attested instance (e.g. a specific tragic passage) and verify exact wording against TLG before publishing a pinned example.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit019',
    'C019',
    'Hesiod, Works and Days (c. lines 213-224 and 256-262) — Dike, dishonored and dragged about wherever bribe-devouring men give crooked judgments, reports the wrongdoing to her father Zeus.',
    'Hesiod personifies δίκη specifically to dramatize the consequence of unjust judging — an abstract complaint about corrupt judges becomes vivid and morally urgent once Dike is a wronged daughter appealing to Zeus, rather than a bare principle being violated.',
    'ديكي (تجسيدًا) / إلهة العدالة المهانة — proper names of personified abstractions are typically kept distinct from their common-noun form in translation, the way الحكمة (wisdom) differs from a personified Sophia.',
    'Hesiod, Works and Days, ed. West (OCT).',
    'FLAG: verify exact line numbers and Greek wording against West''s edition before quoting verbatim — this entry paraphrases the passage''s content rather than quoting extended Greek directly.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit020',
    'C020',
    'Formulaic across Athenian judicial vocabulary and oratory — δίκην δικάζειν is standard legal Greek for rendering a verdict, without one single canonical locus.',
    'The cognate-object construction itself (judge a judgment) is the teaching point rather than any one author''s specific usage — it shows Greek''s general comfort with cognate accusatives in formal/legal registers.',
    'الفصل في القضية / إصدار الحكم',
    'General usage across Attic legal vocabulary and oratory (Demosthenes, Aristotle''s Athenian Constitution).',
    'FLAG: describes a usage pattern, not one verbatim citation — pin to a specific oration and verify against TLG before publishing.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit021',
    'C021',
    'Formulaic across Demosthenes'' forensic orations — δίκην λαγχάνειν (τινί) is the standard technical phrase for initiating a private lawsuit against someone, extremely frequent across the corpus.',
    'This exact idiom, rather than a looser paraphrase, is the actual technical Athenian legal formula for ''suing someone'' — a student who can recognize it can identify the opening move of a private legal action anywhere it occurs in Attic prose.',
    'أقام دعوى ضد / رفع دعوى على',
    'Demosthenes'' forensic orations generally (OCT editions); Aristotle, Athenaion Politeia for the procedural background.',
    'FLAG: extremely well-attested pattern but describes a recurring formula, not one verbatim citation — pin to a specific oration (e.g. Demosthenes 21 or 54) and verify exact wording against TLG before publishing.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit022',
    'C022',
    'Recurring in Herodotus''s and Thucydides''s narratives of revenge and retribution between states or individuals — δίκην λαμβάνειν (τινός) as the standard phrase for exacting satisfaction/punishment from a wrongdoer.',
    'Historiographical narrative repeatedly frames international and personal conflict in terms of who owes and who is owed a δίκη — the phrase is load-bearing for how Herodotus in particular structures cycles of Greek-versus-non-Greek retribution in the History''s opening chapters.',
    'أخذ حقه من / اقتص من / استوفى حقه من',
    'Herodotus, Historiae, ed. Wilson (OCT); Thucydides, Historiae, ed. Jones & Powell (OCT).',
    'FLAG: describes a recurring narrative pattern rather than one verbatim citation — pin to a specific passage (e.g. Herodotus''s proem, 1.1-5, which explicitly frames the whole work around reciprocal δίκη-taking between peoples) and verify exact wording against TLG before publishing.'
);
