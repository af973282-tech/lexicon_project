-- Classical Language Database — θεός (L009), full detail
-- Run AFTER logos, nomos, psyche, dike, arete, gnosis, eimi, and apo are already loaded.
-- S072 (astrological) intentionally has NO Construction/Citation row, consistent with established
-- practice for rare/unverified senses. All 6 citations here are CONFIRMED directly from source
-- lexicon material provided (LSJ, Pindar-lexicon, Bailly, Pape), not reconstructed from memory.

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

-- Lemma: θεός
INSERT INTO Lemmas (
    Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field, Cross_Language_Connection, Modern_Resonance, Classical_Concept
) VALUES (
    'L009',
    'θεός',
    'Ancient Greek',
    'Etymology genuinely disputed even in antiquity: Herodotus (2.52) derived it from τίθημι (''to place, arrange''), reasoning the Greeks called the gods θεοί because they had ''arranged all things in order''; Plato (Cratylus 397d) instead derived it from θέω (''to run''), reflecting his theory that the earliest Greeks worshipped sun, moon, and stars as gods for their perpetual motion. Modern etymology rejects both folk-etymologies, tracing θεός to PIE *dhh1es- (''divine, sacred''), cognate with Latin fas/fanum/feriae/festus — NOT cognate with Latin deus (which descends from a different PIE root, *deiwos, ''sky, day'', shared instead with Greek Ζεύς/Ζηνός and Sanskrit deva). Two of the most common IE words for ''god'' in Greek and Latin are, despite surface resemblance, NOT directly cognate — a real false-friend trap. Dialect forms: Boeotian/Cypriot/Cretan θιός, Laconian σιός, Doric θεύς. Common-gender noun (same form for masculine ''god'' and feminine ''goddess'', disambiguated by the article ὁ/ἡ), though a distinct feminine form θεά also exists and is more common for ''goddess'' in later/Attic usage.',
    'The divine/providence in general, an individual named or unnamed deity, a goddess (common-gender usage), a deified/divinized abstract quality, a divinized human ruler (ruler-cult), a euphemism for the ordinary dead, a Septuagint-specific calque for human judges/magistrates, and (rare, unverified) an astrological technical term for a planet or horoscope-house.',
    'NOT cognate with Latin deus, despite the surface resemblance (see Root_Lineage) — a genuine false-friend pitfall for students moving between Greek and Latin. Arabic إله (ilāh, ''a god'', root of Allāh) covers the general/individual-deity senses reasonably well, but has no equivalent for the Hellenistic/Roman ruler-cult sense (S069) or the LXX judge-calque sense (S071), both of which need entirely different Arabic vocabulary — another case, like νόμος and ἀρετή, where a single Greek word''s institutional/technical branches force a much wider Arabic split than the core meaning alone would suggest.',
    'The disputed Herodotean/Platonic folk-etymologies (from τίθημι or θέω) are frequently cited in modern discussions of ancient Greek popular etymology. The ruler-cult sense (S069) is the direct historical background for later imperial-cult scholarship and for understanding early Christian resistance to emperor-worship (refusing to call a Roman emperor θεός was a politically loaded theological statement, not merely a private belief).',
    'θεός is a RADIAL network similar in overall shape to λόγος and ἀρετή, but its most historically consequential branch — the ruler-cult/divinization sense (S069) — is politically rather than philosophically driven, a genuinely different kind of specialization from anything documented so far in this database (contrast ψυχή''s philosophical reworkings or γνῶσις''s religious-technical branch). DESIGN NOTE: the Septuagint judge-calque sense (S071) is included on the same basis as γνῶσις''s headcount sense reinforced by Hebrew nephesh — a translation-Greek usage directly reflecting a source-language (Biblical Hebrew Elohim) semantic range ordinary Greek θεός does not otherwise carry, worth flagging explicitly so a student doesn''t assume this sense generalizes outside LXX/Biblical-translation Greek. S072 (astrological) is flagged rare/unverified and receives no Construction or Citation, consistent with this database''s established practice for such cases (cf. δίκη''s Pythagorean-number sense, ἀρετή''s military-engine/plaster senses).'
);

-- Senses (8 rows)
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S065',
    'L009',
    'General/unspecified ''god, the divine, providence''',
    'الله، الإله (بمعنى عام غير محدد)',
    'The oldest, characteristically Homeric usage: θεός (often anarthrous, without the article, and often without any specific deity named) referring to a vague, general divine agency or providence governing events — θεὸς δὲ τὸ μὲν δώσει τὸ δʼ ἐάσει, ''god will grant this but withhold that.'' Homeric scholars (cf. Nägelsbach''s Homerische Theologie) have long noted this usage need not point to any one specific god; it names an undifferentiated divine force or fate operating behind events, closer to ''providence'' than to a specific personal deity.',
    'The least referentially specific sense — no particular deity''s name, epithet, or cult is implied, only a generalized divine causal force.',
    'Overlaps significantly with μοῖρα (fate/destiny) in Homeric usage — ''θεοῦ μοῖρα'' shows the two concepts operating closely together as near-synonyms in this general-providence sense.',
    'Overwhelmingly characteristic of Homeric epic; the specifically anarthrous, unspecified usage becomes less frequent (though never disappears) as Greek religious and philosophical thought develops more differentiated theological vocabulary in later periods.',
    'σὺν θεῷ — ''with god''s help, God willing''; ἄνευ θεοῦ / οὐ θεῶν ἄτερ — ''without divine sanction, against the gods'' will.''',
    'If θεός appears without the article and without any name, epithet, or specific cult context, you''re very likely in this general ''providence/the divine'' sense — resist the urge to identify a specific god unless context clearly points to one.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S066',
    'L009',
    'A specific individual deity, contextually identified without being named',
    'الإله (المقصود تحديدًا حسب السياق، دون تسميته)',
    'ὁ θεός (with the article) used to refer to one PARTICULAR, contextually-understood deity, without naming them explicitly — ὁ θ. ὕει, ''the god rains'' (Zeus, understood); ἔσεισεν ὁ θ., ''the god shook [the earth]'' (Poseidon, understood); of the sun as a divine phenomenon (Helios, understood); of consulting an oracle, μαντεύσατο δʼ ἐς θεὸν ἐλθών, ''having gone to consult the god'' (the Delphic oracle/Apollo, understood). The identity of the specific god is left to be supplied by context, not stated.',
    'A referential narrowing from S065: here a genuinely SPECIFIC deity is meant, but the text relies on contextual/pragmatic inference (rather than a name) to convey which one — a real interpretive skill, not merely vague reference.',
    NULL,
    'Attested across periods, especially frequent in contexts involving natural phenomena (weather, earthquakes, the sun) and oracular consultation, where the relevant god''s domain makes their identity unambiguous without naming them.',
    'θεὸς ὥς / ὥς τε θεός — ''like a god'' (a simile praising a mortal''s excellence as god-like, distinct from this sense''s contextual-reference use but built on the same underlying concept).',
    'ὁ θεός (with the article) describing weather, earthquakes, the sun, or an oracle is a real puzzle to solve, not a vague reference — ask which god''s recognized domain matches the described phenomenon.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S067',
    'L009',
    'θεός used of a goddess (common-gender feminine usage)',
    'الإلهة (باستخدام صيغة النوع المشترك)',
    'θεός functioning as a common-gender noun: the identical form ὁ θεός also serves as ἡ θεός, ''goddess'', distinguished only by the article''s gender — μήτε θήλεια θεός, μήτε τις ἄρσην, ''neither a female god nor a male one.'' Especially notable at Athens, where ἡ θεός (no further specification needed) was the standard way to refer to Athena specifically. A separate, exclusively feminine form θεά also exists and becomes more common for ''goddess'' generally in later/Attic Greek, existing alongside rather than fully replacing the common-gender ἡ θεός usage.',
    'A grammatical/morphological point as much as a semantic one: no separate word or ending is required to specify ''goddess'' rather than ''god'' — the SAME noun form serves both, gender carried entirely by the article.',
    'θεά — a distinct, exclusively feminine noun form, existing alongside (not replacing) the common-gender ἡ θεός usage, especially in later Greek.',
    'ἡ θεός as the standard Athenian way of referring to Athena specifically is a distinctly Attic institutional usage (inscriptions, official decrees); the common-gender pattern itself is attested from Homer onward.',
    'νὴ/μὰ τὼ θεώ — ''by the two goddesses!'' (a women''s oath invoking Demeter and Persephone, using the dual form of this common-gender noun).',
    'Don''t assume θεός always means a MALE god — check the accompanying article (ὁ vs. ἡ): ἡ θεός (feminine article) at Athens, without further specification, very often means Athena specifically.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S068',
    'L009',
    'Metaphorical apotheosis — an abstract quality/experience called ''a god''',
    'إله (استعارة لتعظيم صفة أو تجربة مجردة)',
    'A rhetorical technique, especially favored in tragedy, of elevating a prized abstract quality or experience to divine status by directly predicating θεός of it: ἡ φρόνησις ἁγαθὴ θεὸς μέγας, ''good sense/wisdom is a great god''; θεὸς γὰρ καὶ τὸ γιγνώσκειν φίλους, ''recognizing one''s friends [when in trouble] is also a god''; ὁ πλοῦτος τοῖς σοφοῖς θεός, ''wealth is a god to the wise''; φθόνος κάκιστος θεός, ''envy [is] the worst god.'' A direct identity-predication (X ἐστι θεός), not a simile (contrast S066''s θεὸς ὥς, ''like a god'').',
    'A bold metaphorical extension: the sentence structure directly identifies an abstraction WITH divinity itself, rather than merely comparing something to a god (simile) or invoking an actual deity — the rhetorical force depends on this identity-claim reading as a deliberate, striking exaggeration, not literal theology.',
    NULL,
    'Especially characteristic of Attic tragedy (Sophocles, Euripides) as a gnomic/aphoristic technique for elevating human values and experiences to cosmic significance within a single memorable line.',
    NULL,
    '''[Abstract noun] ἐστι θεός'' is a rhetorical move elevating that quality to supreme importance — read it as ''X matters as much as anything divine does'', not as a literal theological claim about a new deity.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S069',
    'L009',
    'Ruler-cult — a divinized human ruler (Hellenistic/Roman imperial cult)',
    'إله (لقب سياسي-ديني يُمنح لحاكم بشري، = اللاتينية divus)',
    'θεός as a formal political-religious TITLE conferred on a living or deceased human ruler, most famously in the Hellenistic Ptolemaic dynasty and the Roman imperial cult: θεῶν ἀδελφῶν, ''of the sibling gods'' (Ptolemy II and Arsinoe II); Πτολεμαῖος ὑπάρχων θεὸς ἐκ θεοῦ καὶ θεᾶς, ''Ptolemy, being a god from a god and a goddess''; θεὸς ἐκ θεοῦ, applied to Augustus; = Latin Divus for deified Roman emperors after death. A formal institution with real cultic, calendrical, and administrative consequences, not merely poetic flattery.',
    'A wholly institutional/political specialization: unlike S065-S068 (concerning how humans conceive of or speak about actual or metaphorical divinity), this sense concerns a formal STATUS conferred by political-religious institutions on a specific historical human being, verifiable by inscriptions, coinage, and administrative documents.',
    'Direct Latin equivalent: Divus (the standard Latin term for a deified emperor) — this database''s first case of a Greek sense whose closest comparandum is a specific, named Latin institutional term rather than a looser conceptual overlap.',
    'Distinctly Hellenistic (Ptolemaic Egypt, 3rd-1st c. BCE) and Roman Imperial-period usage; essentially unattested as an institutional practice in Classical Athens, where declaring a living human θεός would have been religiously and politically unthinkable.',
    'θεὸς ἐκ θεοῦ — ''a god [born/descended] from a god'' (the standard ruler-cult genealogical-legitimacy formula).',
    'θεός applied to a named historical ruler (a Ptolemy, an Augustus) in an inscription or official document is this institutional ruler-cult sense — a political-religious title, not a claim comparable to Homer''s or tragedy''s uses of the same word.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S070',
    'L009',
    'Euphemism for the ordinary dead',
    'من الأموات (كناية عن الموت، لا ادعاء التأله السياسي)',
    'θεός/θεοί used as a mild euphemism for ORDINARY dead humans (not divinized rulers): καὶ ζῶντός σου καὶ εἰς θεοὺς ἀπελθόντος, ''[whether] you are alive or have departed to the gods'' [died]; θεοῖς χθονίοις, ''to the chthonic/underworld gods'' = Latin Dis Manibus. Distinguished from S069''s specifically POLITICAL ruler-cult title: this sense applies to any deceased person as a soft, indirect way of naming death, without claiming any special divine status or historical ruler-cult institution.',
    'A euphemistic, not a literal theological or political claim: calling an ordinary dead person one of ''the gods'' does not assert the institutional divine status S069 documents — closer to how English ''departed'' or ''with the angels'' softens death without asserting a specific afterlife doctrine.',
    NULL,
    'Attested in later (Hellenistic/Roman-period) funerary papyri and inscriptions; a natural semantic neighbor of, but institutionally and rhetorically distinct from, the ruler-cult sense (S069) that develops in the same broad period.',
    'θεοῖς χθονίοις — ''to the chthonic gods'' (= Latin Dis Manibus, a standard funerary inscription formula).',
    'θεοί in a funerary inscription or a phrase like ''departed to the gods'' is a soft euphemism for death itself — don''t read this as claiming the deceased received the formal ruler-cult status documented in S069.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S071',
    'L009',
    'Septuagint/Hebrew calque — human judges or magistrates',
    'قاضٍ، حاكم (استخدام خاص بالترجمة السبعينية لكلمة عبرية)',
    'A narrow, translation-Greek-specific sense confined to the Septuagint: θεοί rendering Hebrew Elohim in legal contexts where the Hebrew word (which can denote ''God'', ''gods'', or, contextually, human judges/magistrates acting with divinely-delegated authority) is translated literally rather than interpretively — τὸ κριτήριον τοῦ θεοῦ, ἐνώπιον τοῦ θεοῦ (Exodus 21:6, 22:8-9), ''[bring him] before the judges/the tribunal''; θεοὺς οὐ κακολογήσεις (Exodus 22:28), ''you shall not curse the judges/magistrates.'' This sense exists ONLY because of the specific Hebrew source-text being translated.',
    'A pure calque: the Greek word''s form (θεός) is retained, but its actual referent (a human judge/magistrate) is imported wholesale from the Hebrew source text''s specific legal usage of Elohim, not from any independent development within Greek itself — comparable to how γνῶσις''s headcount sense was reinforced by Hebrew nephesh''s parallel usage, but here the calque is even more direct and total.',
    'In ordinary (non-calqued) Greek, this same referent would be κριτής (judge) or ἄρχων (magistrate) — θεός is NOT a normal Greek synonym for either outside this specific translation context.',
    'Confined to the Septuagint''s translation of specific Exodus legal passages; a genuine hapax-like phenomenon within the overall semantic history of θεός, not a usage that spread into wider Koine or later Greek.',
    NULL,
    'If you meet θεός/θεοί in a Septuagint legal passage (especially Exodus) and a straightforward ''god/gods'' reading makes the sentence about judges, tribunals, or legal proceedings incoherent, you are very likely looking at this specific Hebrew-calque sense — check the underlying Hebrew (Elohim) if in doubt.'
);
INSERT INTO Senses (
    Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context, Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance, Fixed_Expression_Proverb, Student_Note
) VALUES (
    'S072',
    'L009',
    'Astrological technical term (rare, unverified — treat with caution)',
    'الكواكب أو بيت فلكي محدد (استخدام تنجيمي نادر وغير مؤكد)',
    'A reported late-antique astrological technical usage: θεοί = ἀστέρες (''the stars/planets''), and θεός (sc. Ἥλιος) as the name of the 9th τόπος (''house'') in a horoscope. This entry does NOT independently confirm the precise scope or reliability of this usage beyond noting it is reported in specialized astrological-technical sources; treat as a rare, marginal technical development pending direct verification against the primary astrological corpus.',
    NULL,
    NULL,
    'Late antique (Imperial-period) technical astrological Greek; essentially unrelated in practical usage to any of the other senses documented in this entry.',
    NULL,
    'Extremely rare and technical — you are very unlikely to meet this sense outside a text specifically engaged in ancient astrological technical vocabulary; do not rely on this entry alone for teaching this specific meaning.'
);

-- Constructions (6 rows)
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C048',
    'S065',
    'σὺν θεῷ, ''with god[’s help]'' (σύν governing the dative) contrasted with ἄνευ θεοῦ / οὐ θεῶν ἄτερ, ''without god[''s sanction]'' (ἄνευ/ἄτερ governing the genitive) — two opposed circumstantial idioms marking divine favor versus its absence.',
    'Dative (σύν) vs. Genitive (ἄνευ/ἄτερ).',
    'σύν, ''with, together with'', regularly governs the dative to mark accompaniment/attendant circumstance — ''acting IN THE COMPANY OF divine favor.'' ἄνευ and ἄτερ, both meaning ''without'', regularly govern the genitive, the standard case for marking absence/separation (the same genitive-of-separation logic documented for ἀπό''s own spatial sense). The two idioms are grammatically unrelated constructions (different governing words, different cases) that happen to form a natural semantic pair (with/without divine sanction), not a single construction varying by case.',
    'Students should not expect σύν and ἄνευ/ἄτερ to be a same-word case-alternation (like κατὰ νόμον/παρὰ νόμον) — they are different governing words entirely, each with its own fixed case requirement, that happen to form a meaningful antonym PAIR at the level of meaning, not grammar.',
    'θεῷ, dative singular; θεοῦ/θεῶν, genitive singular/plural, depending on which idiom and number.',
    'Each phrase functions as an adverbial modifier of manner/attendant circumstance on the main verb, marking whether an action proceeds with or without divine sanction.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C049',
    'S066',
    'ὁ θεὸς ὕει, ''the god rains'' [understood: Zeus]; ἔσεισεν ὁ θεός, ''the god shook [the earth]'' [understood: Poseidon] — the definite article ὁ marking a SPECIFIC, identifiable referent, while the specific god''s identity is supplied entirely by context rather than by name.',
    'Nominative (ὁ θεός, subject of the verb) — not primarily a case-teaching point.',
    'Not a case-choice construction at all — the definite article ὁ (rather than an anarthrous θεός, as in S065''s general sense) is doing the real referential work here, signaling ''a SPECIFIC, identifiable god'' rather than ''divine providence in general.'' The identity-resolution itself depends on recognizing which god''s traditional domain (weather, earthquakes, prophecy, the sun) matches the described phenomenon, a purely pragmatic/cultural inference, not a grammatical one.',
    'A student may treat ὁ θεός here as simply ''the general concept of god/providence'' (conflating this sense with S065) rather than recognizing the article specifically signals a determinate, particular deity whose identity the reader is expected to infer from the type of event being described.',
    'ὁ θεός, nominative singular with the definite article.',
    'Subject of the verb describing the natural phenomenon or event; the specific identity of the referent is resolved pragmatically, not grammatically.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C050',
    'S069',
    'Πτολεμαῖος... θεὸς ἐκ θεοῦ καὶ θεᾶς, ''Ptolemy... a god from a god and a goddess'' — a predicate nominative (θεός) combined with ἐκ + genitive marking the claimed unbroken chain of divine ancestry legitimizing the ruler''s own divine status.',
    'Genitive (governed by ἐκ).',
    'ἐκ + genitive here marks IMMEDIATE, direct descent (recall ἀπό''s own S059/C042: ἐκ regularly marks more direct/immediate origin than ἀπό does) — a deliberate choice in this specific political formula, since the whole legitimizing force of the claim depends on asserting an unbroken, DIRECT chain of divine parentage (a god born directly FROM a god), not a vague or remote connection to divinity that a looser ἀπό-phrase might imply.',
    'Students who have learned ἀπό''s own S059 (marking more remote descent) from this database''s earlier ἀπό entry should specifically notice that THIS ruler-cult formula deliberately uses ἐκ, not ἀπό, precisely because remoteness would undercut the political-religious legitimacy the formula is designed to assert.',
    'θεοῦ, genitive singular (masculine, ''god''); θεᾶς, genitive singular (feminine, ''goddess'') — note the exclusively feminine form θεά used here rather than the common-gender θεός, since the formula specifically distinguishes the divine father from the divine mother.',
    'θεός functions as a predicate nominative identifying the ruler''s own status; the ἐκ-phrase is an adnominal/adverbial modifier specifying the immediate divine parentage legitimizing that status.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C051',
    'S070',
    'θεοῖς χθονίοις, ''to the chthonic/underworld gods'' (= Latin Dis Manibus) — a dative of dedication in standard Greco-Roman funerary inscription formulae.',
    'Dative.',
    'A dative of dedication/honor — the standard case for marking the recipient/honoree of a dedicatory inscription, here formulaically applied to ''the gods below'' as an indirect way of consecrating a tomb to/on behalf of the deceased, rather than naming the deceased person directly as the dedication''s recipient.',
    'Students encountering this formula on an inscription (often abbreviated, as in the Latin D.M.) should recognize it as a fixed, largely ritual/formulaic opening rather than expecting fresh compositional meaning each time — the phrase functions almost as a genre-marker identifying the inscription type (funerary) before any personal content follows.',
    'θεοῖς, dative plural of θεός; χθονίοις, dative plural of the adjective χθόνιος (''of/under the earth''), agreeing with θεοῖς.',
    'Dative of dedication, typically standing alone as a formulaic opening phrase at the head of a funerary inscription.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C052',
    'S071',
    'θεοὺς οὐ κακολογήσεις (Exodus 22:28 LXX), ''you shall not curse the judges/magistrates'' — θεούς as the direct object of κακολογέω (''to speak ill of, curse''), a calqued rendering of Hebrew Elohim in its judicial-authority sense.',
    'Accusative (direct object of κακολογήσεις).',
    'An entirely ordinary direct-object accusative grammatically — the real interpretive challenge is not case but REFERENCE: recognizing that θεούς here does not mean ''the gods'' (which would produce a strange or theologically fraught command in context) but specifically ''the judges/magistrates'', following the underlying Hebrew legal text''s own usage of Elohim for human authorities exercising divinely-sanctioned judicial power.',
    'A reader unfamiliar with this specific LXX calque may default to ''you shall not curse the gods'' (a strange, seemingly polytheism-tolerant command from a monotheistic legal text) rather than recognizing the coherent legal-authority sense the underlying Hebrew actually intends — checking the Hebrew Vorlage (source text) resolves the apparent oddity immediately.',
    'θεούς, accusative plural of θεός.',
    'Direct object of the verb κακολογήσεις.',
    NULL
);
INSERT INTO Constructions (
    Construction_ID, Sense_ID, Construction_Governance, Required_Case, Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role, Morphological_Change
) VALUES (
    'C053',
    'S068',
    'ἡ φρόνησις ἁγαθὴ θεὸς μέγας (Sophocles fr. 922), ''good sense is a great god'' — an abstract noun (φρόνησις) directly identified with θεός via a predicate-nominative construction, both standing in the nominative case.',
    'Nominative (both the subject and predicate noun).',
    'Not a case-choice teaching point (ordinary predicate-nominative agreement, subject and predicate sharing the nominative case) — the real teaching value is recognizing this as a deliberate rhetorical IDENTITY-CLAIM (''X literally IS a god'') rather than a simile (''X is LIKE a god'', which would use a comparative particle such as ὡς or ὥστε instead, as documented in S066''s Fixed_Expression_Proverb note) — the grammar itself (direct predication vs. simile-marking particle) signals which rhetorical move is being made.',
    'Students should distinguish this direct-identity predicate-nominative construction sharply from the θεὸς ὥς / ὥς τε θεός simile construction (S066) — the presence or absence of a comparative particle is the grammatical signal distinguishing ''X IS divine'' (bold metaphorical identity-claim) from ''X is LIKE a god'' (a comparison, however extravagant).',
    'θεός, nominative singular, agreeing with the subject noun in case (though not necessarily gender, since θεός is common-gender and can agree with a feminine abstract subject like φρόνησις).',
    'Predicate nominative, directly identifying the abstract subject with divinity itself.',
    NULL
);

-- Citations (6 rows)
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit049',
    'C048',
    'Homer, Iliad 9.49 — σὺν θεῷ, ''with god''s help''; contrasted with Pindar, Pythian 5.76 — οὐ θεῶν ἄτερ, ''not without the gods'' [sanction]''.',
    'Both idioms mark whether a human action or outcome proceeds with or without divine backing — a basic evaluative frame running through Greek narrative and lyric poetry for assessing the legitimacy or likely success of an undertaking.',
    'بعون الله / بمشيئة الله (لِـσὺν θεῷ) مقابل بغير إذن الآلهة (لِـἄτερ/ἄνευ)',
    'Homer, Iliad, ed. West (Teubner) or Monro/Allen (OCT); Pindar, Pythian Odes, ed. Snell-Maehler (Teubner).',
    'CONFIRMED — both citations are directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit050',
    'C049',
    'Xenophon, Hellenica 4.7.4 — ἔσεισεν ὁ θεός, ''the god (Poseidon, understood) shook [the earth]''.',
    'Xenophon relies on his audience''s cultural knowledge that earthquakes are Poseidon''s domain to make the reference unambiguous without naming him — a compact, culturally-loaded shorthand.',
    'زلزل الإله (بوسيدون المقصود ضمنًا) الأرض',
    'Xenophon, Hellenica, ed. Marchant (OCT), Book 4, chapter 7, section 4.',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit051',
    'C050',
    'OGI 90.10 (the Rosetta Decree, 196 BCE) — Πτολεμαῖος ὑπάρχων θεὸς ἐκ θεοῦ καὶ θεᾶς, ''Ptolemy, being a god from a god and a goddess''; cf. OGI 655.2 (Egypt, 24 BCE) — θεὸς ἐκ θεοῦ, applied to Augustus.',
    'The formula''s precise wording (a god FROM a god, using ἐκ for direct/immediate descent) is doing real political-legitimizing work, not merely honorific flattery — it asserts an unbroken, direct chain of divine parentage justifying the ruler''s own claimed divinity.',
    'بطليموس، إله من إله وإلهة — a translator''s note should flag that this is a specific royal/imperial title formula, not an ordinary theological statement.',
    'Orientis Graeci Inscriptiones Selectae (OGI), ed. Dittenberger — nos. 90 and 655.',
    'CONFIRMED — both citations are directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit052',
    'C051',
    'IG 14.30 — θεοῖς χθονίοις, ''to the chthonic gods'' (= Latin Dis Manibus, the standard Roman funerary dedication formula).',
    'This exact Greek formula is used specifically because it mirrors the standard Latin funerary formula word-for-word in function, in a bilingual epigraphic culture (Roman-period Greek inscriptions) where the two formulae operated as direct equivalents.',
    'للآلهة السفلية (تكريمًا للمتوفى) — a translator''s note should flag the formula''s function as a funerary genre-marker, comparable to ''R.I.P.'' in modern usage.',
    'Inscriptiones Graecae (IG), vol. 14 (inscriptions of Sicily, Italy, and the western Mediterranean), no. 30.',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit053',
    'C052',
    'Exodus 22:28 (LXX; verse numbering varies, cf. 22:27 in some editions) — θεοὺς οὐ κακολογήσεις, ''you shall not curse the judges/magistrates'' (rendering Hebrew Elohim in its judicial-authority sense, not as ''gods'').',
    'The LXX translators chose a maximally literal rendering of the underlying Hebrew term rather than an interpretive Greek equivalent (κριτής, ''judge''), preserving the ambiguity of the Hebrew source at the cost of creating a potentially confusing Greek text for readers unfamiliar with this specific calque.',
    'لا تسبَّ القضاة — an Arabic translation aiming for sense-for-sense clarity would render this directly as ''judges/magistrates'', following the same interpretive move as most modern English Bible translations of the underlying Hebrew.',
    'Septuaginta, ed. Rahlfs-Hanhart; Exodus 22:28 (or 22:27, depending on versification).',
    'CONFIRMED — this exact citation (with its noted verse-numbering variation) is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
INSERT INTO Citations (
    Citation_ID, Construction_ID, Example_Citation, Why_This_Word, Translation_Choices, Source_Reliability, Verification_Notes
) VALUES (
    'Cit054',
    'C053',
    'Sophocles, fragment 922 (Radt) — ἡ φρόνησις ἁγαθὴ θεὸς μέγας, ''good sense/wisdom is a great god''.',
    'The direct predicate-nominative identity-claim (rather than a mere simile) gives the line its gnomic, aphoristic force — precisely the rhetorical effect a tragic chorus or character aims for in a memorable maxim about what truly matters in human life.',
    'الحكمة الصالحة إله عظيم — preserving the direct identity-predication structure rather than softening it into a simile (''like a god''), to keep the line''s rhetorical boldness intact.',
    'Sophocles, Fragments, ed. Radt (TrGF), fr. 922.',
    'CONFIRMED — this exact citation is directly given in the source lexicon material this entry was built from, not reconstructed from memory.'
);
