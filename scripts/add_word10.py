"""
add_word10.py — ὕβρις, built through the new parameterized pipeline.
Run with: python scripts/add_word10.py
(from the lexicon_project/ directory)

This is the actual test of the infrastructure pass: no hand-written SQL,
no manually-tracked IDs, no manual quote-escaping. Every ID below is
printed as it's generated so you can see them being assigned live rather
than pre-guessed.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from db_utils import get_connection, add_lemma, add_sense, add_construction, add_citation, add_morph_form

DB_PATH = str(Path(__file__).parent.parent / "classical.db")


def main():
    conn = get_connection(DB_PATH)

    lemma_id = add_lemma(
        conn,
        term_original="ὕβρις",
        language="Ancient Greek",
        root_lineage=(
            "Etymology disputed but plausibly connected to ὑπέρ ('over, beyond') — the "
            "core idea being 'a going-beyond, an overstepping of the proper measure.' "
            "Descendants: English 'hubris' is a direct, largely unchanged borrowing "
            "(rare among the words in this database — most give a derived/compound "
            "form like 'psychology' or 'agnostic', not the bare word itself). Feminine "
            "noun, 3rd declension, genitive ὕβρεως (also Epic/Ionic ὕβριος, and a "
            "poetic-metrical alternation between short and long upsilon depending on "
            "position in the verse)."
        ),
        semantic_field=(
            "Wanton violence/insolence arising from pride or passion, sexual license, "
            "animal unruliness, a concrete outrageous act, sexual violation, a specific "
            "Athenian legal crime category, nautical/storm damage, and the personified "
            "goddess Hybris."
        ),
        cross_language_connection=(
            "English borrows the word directly as 'hubris' — unlike every other word "
            "in this database, this is a loanword, not a translation or a derived "
            "compound. Arabic has no single native word covering the same range; "
            "renderings split across الغطرسة (arrogance/hubris, general sense), الفجور "
            "(lewdness), جماح (an animal's unruliness — a precise, idiomatic Arabic term, "
            "not a generic 'violence' gloss), and انتهاك/اغتصاب (violation/assault, legal "
            "sense)."
        ),
        modern_resonance=(
            "'Hubris' as a direct English loanword is now a standard term in psychology, "
            "political commentary, and literary criticism for exactly the pattern Greek "
            "tragedy dramatizes: overweening pride inviting downfall (nemesis). Modern "
            "usage often assumes a tight hubris-then-nemesis causal link that isn't "
            "actually guaranteed in every Greek source — worth flagging as a possible "
            "retrojection of tragedy's specific plot logic onto the word's full semantic "
            "range."
        ),
        classical_concept=(
            "ὕβρις sits at the center of one of Greek ethical thought's most productive "
            "oppositions: ὕβρις vs. δίκη/εὐνομίη (wanton overreach vs. right order), "
            "already visible in Homer's suitors and fully developed in Hesiod's Works "
            "and Days ('to those who deal in evil ὕβρις, Zeus ordains δίκη'). The "
            "Athenian legal sense (S6) directly parallels δίκη's own νόμος/γραφή "
            "distinction already documented in this database — ὕβρις was remedied by "
            "γραφή (public indictment), the lesser offense αἰκία by δίκη (private "
            "suit), the identical public/private institutional split δίκη's own entry "
            "already established for a different crime category. DESIGN NOTE: the "
            "personification sense (S8, Pindar's 'Hybris, mother of Koros') is this "
            "database's THIRD confirmed instance of the personification-as-syntactic-"
            "role pattern (after Δίκη and Ἀρετή) — strong enough now to treat as a "
            "settled, load-bearing pattern rather than a coincidence."
        ),
    )
    print(f"Lemma created: {lemma_id}")

    senses = {}

    senses["general"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="General wanton violence/insolence (arising from pride or passion)",
        primary_arabic_definition="الغطرسة، التعدي الوقح",
        nuance_context=(
            "The foundational sense, dominant in the Odyssey: arrogant, violent overreach "
            "arising from excessive confidence in one's own strength or from unchecked "
            "passion — almost always describing the suitors, τῶν ὕβρις τε βίη τε σιδήρεον "
            "οὐρανὸν ἵκει, 'whose insolence and violence reach the iron heaven.' "
            "Systematically opposed to εὐνομίη (good order) and δίκη (right)."
        ),
        literal_vs_contextual=(
            "The base, most general sense — an abstract quality of character or conduct, "
            "prior to any of the narrower technical specializations (sexual, legal, "
            "nautical) built on it below."
        ),
        synonyms_antonyms=(
            "Frequently paired with κόρος (surfeit, satiety leading to arrogance) as its "
            "psychological cause. Antonym: εὐνομίη (good civic order), δίκη (right, "
            "justice)."
        ),
        author_period_nuance=(
            "Overwhelmingly the Odyssey's usage for the suitors; the ὕβρις/δίκη "
            "opposition becomes a major structuring theme in Hesiod (Works and Days) "
            "and later ethical/political thought generally."
        ),
        fixed_expression_proverb=None,
        student_note=(
            "This is the safe default reading — arrogant overreach, especially where "
            "δίκη or εὐνομίη appears nearby as the explicit contrast."
        ),
    )

    senses["lewdness"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Lust, lewdness (opposed to σωφροσύνη)",
        primary_arabic_definition="الفجور، الانغماس الشهواني",
        nuance_context=(
            "A narrower specialization: unchecked sensual/sexual excess specifically, "
            "explicitly opposed to σωφροσύνη (self-control, moderation) rather than to "
            "δίκη — Theognis 379, Xenophon's Cyropaedia 8.4.14."
        ),
        literal_vs_contextual=(
            "A domain-narrowing of the general sense (S1): the 'overstepping proper "
            "measure' idea applied specifically to bodily appetite rather than violent "
            "conduct generally."
        ),
        synonyms_antonyms="Antonym: σωφροσύνη (self-control, temperance, moderation).",
        author_period_nuance="Attested from Archaic elegy (Theognis) through Xenophon.",
        fixed_expression_proverb=None,
        student_note=(
            "If ὕβρις is explicitly paired against σωφροσύνη rather than δίκη/εὐνομίη, "
            "you're in this narrower sensual-excess sense, not the general one."
        ),
    )

    senses["animal"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Animal unruliness, skittishness, wildness",
        primary_arabic_definition="الجموح (عند الحيوان)",
        nuance_context=(
            "Applied to animals rather than moral agents: a horse's unruliness or "
            "riotous over-fed restiveness — Herodotus 1.189 (a horse plunges into a "
            "river ὑπὸ ὕβριος, 'out of unruliness'); Pindar uses it of the snakes "
            "attacking the infant Heracles (Nemean 1.50) and, generally, of animal "
            "violence (Pythian 10.36)."
        ),
        literal_vs_contextual=(
            "A genuinely separate domain from the moral/legal senses — no claim of "
            "moral culpability is implied, just uncontrolled animal energy or "
            "aggression."
        ),
        synonyms_antonyms=None,
        author_period_nuance="Attested in Herodotus and Pindar specifically.",
        fixed_expression_proverb=None,
        student_note=(
            "ὕβρις describing a horse, snake, or other animal is this sense — "
            "'unruliness/wildness', not moral arrogance."
        ),
    )

    senses["concrete_outrage"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="A concrete outrage or insult (= ὕβρισμα, a specific act)",
        primary_arabic_definition="إهانة، فعلة شائنة",
        nuance_context=(
            "Where ὕβρις names a specific wrongful ACT rather than the abstract quality "
            "of arrogance — Iliad 1.203/214, ὕβριν τεῖσαι (Odyssey 24.352, 'to pay for "
            "the outrage'); the fixed idiom ὕβρεις ὑβρίζειν, 'to commit outrages' "
            "(Euripides), treats ὕβρις as a countable, repeatable event."
        ),
        literal_vs_contextual=(
            "A concrete/abstract split parallel to this database's countable-plural "
            "pattern (ψυχαί, ἀρεταί): here a plural ὕβρεις names discrete acts, not "
            "more of one continuous quality."
        ),
        synonyms_antonyms="Near-synonym: ὕβρισμα (an outrage, the concrete-noun form).",
        author_period_nuance="Attested from Homer onward; the plural is especially telling.",
        fixed_expression_proverb="ὕβρεις ὑβρίζειν — 'to commit outrages' (cognate accusative).",
        student_note=(
            "A plural ὕβρεις, or ὕβρις as the object of a verb of 'paying for' or "
            "'committing', names specific acts — not the abstract quality."
        ),
    )

    senses["violation"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Sexual violation, assault on the person",
        primary_arabic_definition="انتهاك جسدي، اغتصاب",
        nuance_context=(
            "A technical narrowing of S4 (concrete outrage) to specifically sexual "
            "violation/assault: Pindar Pythian 2.28, Lysias 1.2, Isocrates 4.114 "
            "(παίδων ὕβρεις, 'the violation of boys'), Aeschines 1.116/188."
        ),
        literal_vs_contextual=(
            "A referential narrowing, not a new metaphor: the same 'outrage against "
            "a person' idea (S4), specialized to the gravest category — bodily/"
            "sexual violation."
        ),
        synonyms_antonyms=None,
        author_period_nuance="Prominent in Classical Attic oratory (Lysias, Isocrates, Aeschines).",
        fixed_expression_proverb=None,
        student_note=(
            "In oratory concerning a person's body specifically (not property or "
            "civic honor), ὕβρις very often means sexual violation, not general "
            "insolence."
        ),
    )

    senses["legal"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Athenian legal technical term (public-indictment crime category)",
        primary_arabic_definition="جريمة الاعتداء الجسيم",
        nuance_context=(
            "In Attic law, ὕβρις names a specific, serious category of personal "
            "injury — broader than mere assault — remedied by γραφή (public "
            "indictment), in stable technical opposition to the lesser offense "
            "αἰκία, remedied instead by δίκη (private suit). Demosthenes 21 (Against "
            "Meidias) is the central surviving text; the law itself is quoted at "
            "21.47 (ὁ τῆς ὕβρεως νόμος)."
        ),
        literal_vs_contextual=(
            "A fully institutional specialization: this is not primarily about "
            "moral character but about which of two distinct legal PROCEDURES "
            "applies to a given injury — the same public/private institutional "
            "split already documented for a different crime under δίκη's own S027."
        ),
        synonyms_antonyms=(
            "Stable technical opposition: ὕβρις (grave injury, γραφή, public "
            "action) vs. αἰκία (lesser assault, δίκη, private action) — directly "
            "parallel to δίκη's own νόμος/γραφή institutional distinction."
        ),
        author_period_nuance="Classical Athenian forensic oratory (Demosthenes, Isocrates, Aeschines).",
        fixed_expression_proverb="ὁ τῆς ὕβρεως νόμος — 'the law concerning ὕβρις' (Demosthenes 21.47).",
        student_note=(
            "In a forensic-oratory context, check whether ὕβρις is contrasted with "
            "αἰκία — if so, you're reading this specific procedural distinction "
            "(public vs. private legal action), not a general moral judgment."
        ),
    )

    senses["nautical"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Nautical damage or loss (storm-related)",
        primary_arabic_definition="الضرر أو الخسارة (في عرض البحر)",
        nuance_context=(
            "A late, technical, fully detached sense: damage or loss from a storm at "
            "sea — Acts 27:10/27:21 (NT), and Pindar's compound ναυσίστονος "
            "('ship-groaning') applied to a comparable idea."
        ),
        literal_vs_contextual=(
            "A complete domain shift from every moral/legal sense above: no "
            "arrogance, violation, or crime is implied — purely material/nautical "
            "damage."
        ),
        synonyms_antonyms=None,
        author_period_nuance="Koine/NT usage; essentially absent from Classical literary Greek in this sense.",
        fixed_expression_proverb=None,
        student_note=(
            "In a nautical/travel narrative (especially NT Acts), ὕβρις very "
            "likely names storm damage or loss, not any moral quality."
        ),
    )

    senses["personified"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Ὕβρις, the personified goddess",
        primary_arabic_definition="هيبريس (تجسيد الغطرسة كإلهة)",
        nuance_context=(
            "Pindar personifies Ὕβρις as a goddess, genealogically linked to Κόρος "
            "(Excess/Satiety): Ὕβριν, Κόρου ματέρα θρασύμυθον, 'Hybris, the bold-"
            "tongued mother of Koros' (Olympian 13.10) — reversing the usual "
            "cause-and-effect pairing of the two concepts (elsewhere κόρος is "
            "treated as producing ὕβρις; here Hybris is imagined as Koros's parent)."
        ),
        literal_vs_contextual=(
            "A referential shift, not merely emphasis: the reader must imagine an "
            "actual mythological agent with genealogy, not an abstract quality — "
            "the third confirmed instance in this database of this exact "
            "personification pattern (after Δίκη and Ἀρετή)."
        ),
        synonyms_antonyms="Genealogically linked (as mother) to Κόρος (personified Excess/Satiety).",
        author_period_nuance="Distinctly Pindaric personification (5th c. BCE epinician poetry).",
        fixed_expression_proverb=None,
        student_note=(
            "If Ὕβρις appears with a genealogical epithet ('mother of X') or as "
            "the grammatical subject of a verb of agency, you're reading this "
            "personified sense, not the abstract quality."
        ),
    )

    print(f"Senses created: {list(senses.values())}")

    # -- Constructions -------------------------------------------------------
    c_manner = add_construction(
        conn, sense_id=senses["general"],
        construction_governance=(
            "A cluster of adverbial case/preposition variants all marking manner or "
            "cause 'out of wantonness': bare dative ὕβρει (Sophocles, Electra 881); "
            "ἐφ' ὕβρει, dative governed by ἐπί (Euripides, Orestes 1581; Demosthenes "
            "21.38); διὰ τὴν ὕβριν, accusative governed by διά (Xenophon, Hellenica "
            "2.2.10)."
        ),
        required_case="Dative (bare, and governed by ἐπί) / Accusative (governed by διά)",
        case_why_not_another=(
            "Three distinct case/preposition strategies converge on roughly the same "
            "manner/cause meaning: the bare dative ὕβρει is a dative of manner "
            "(structurally identical to this database's already-confirmed λόγῳ/"
            "νόμῳ/ὕβρει pattern); ἐπί+dative marks purpose/attendant circumstance "
            "('with a view to outrage'); διά+accusative marks direct cause ('because "
            "of the outrage'). Greek does not need to pick one strategy — all three "
            "coexist as live options for the same broad semantic job."
        ),
        syntactic_pitfall=(
            "Students should not expect one 'correct' construction here — recognizing "
            "that ὕβρει, ἐφ' ὕβρει, and διὰ τὴν ὕβριν are near-synonymous manner/cause "
            "expressions (not marking meaningfully different nuances the way ἀπό vs. "
            "ἐκ does elsewhere in this database) avoids over-interpreting the choice "
            "between them."
        ),
        morphology="ὕβρει, dative singular; τὴν ὕβριν, accusative singular, governed by διά.",
        syntax_role="Each functions as an adverbial phrase of manner or cause.",
        morphological_change=None,
        pattern_category="Dative of Respect/Manner (Antithesis)",
    )

    c_legal = add_construction(
        conn, sense_id=senses["legal"],
        construction_governance=(
            "ὁ τῆς ὕβρεως νόμος (Demosthenes 21.47) — 'the law concerning ὕβρις' — "
            "a genitive of specification identifying which law is meant, within the "
            "stable ὕβρις(γραφή)/αἰκία(δίκη) procedural opposition."
        ),
        required_case="Genitive (τῆς ὕβρεως)",
        case_why_not_another=(
            "A genitive of specification/domain — the same recurring pattern already "
            "documented across six other words in this database (λόγος, νόμος, ψυχή, "
            "ἀρετή ×3, γνῶσις) — here marking which specific law (among Athens's many) "
            "is meant. The real teaching content isn't the case, which is entirely "
            "ordinary, but the institutional fact the phrase encodes: this law "
            "specifically handles the graver, publicly-prosecuted injury category, "
            "directly paralleling δίκη's own established νόμος/γραφή institutional "
            "split."
        ),
        syntactic_pitfall=(
            "Students who've built the δίκη entry in this database should actively "
            "recognize this as the SAME public/private institutional logic applied "
            "to a different crime category, not a new grammatical pattern to learn."
        ),
        morphology="τῆς ὕβρεως, genitive singular of ὕβρις, -εως, ἡ (3rd declension feminine).",
        syntax_role="Adnominal genitive dependent on νόμος, specifying which law is meant.",
        morphological_change=None,
        pattern_category="Genitive of Specification/Domain",
    )

    c_cognate = add_construction(
        conn, sense_id=senses["concrete_outrage"],
        construction_governance=(
            "ὕβρεις ὑβρίζειν (Euripides, Heracles Furens 741; Bacchae 247) — 'to "
            "commit outrages' — a cognate accusative construction, the verb and its "
            "object noun sharing the same root."
        ),
        required_case="Accusative (ὕβρεις, cognate/internal object of ὑβρίζειν)",
        case_why_not_another=(
            "A cognate-accusative construction — the SECOND confirmed instance in "
            "this database of this exact pattern (after δίκη's δίκην δικάζειν), "
            "upgrading it from a singleton to an established, recurring "
            "construction type. The accusative here doesn't mark a pre-existing "
            "external object but names the very act the verb performs, exactly as "
            "with δίκην δικάζειν."
        ),
        syntactic_pitfall=(
            "As with δίκην δικάζειν, students may look for ὕβρεις to refer to some "
            "separately-existing set of outrages being 'committed', rather than "
            "recognizing that the phrase names the act of outraging itself."
        ),
        morphology="ὕβρεις, accusative plural of ὕβρις; ὑβρίζειν, present active infinitive.",
        syntax_role="ὕβρεις = cognate/internal direct object of ὑβρίζειν.",
        morphological_change=None,
        pattern_category="Cognate/Internal Accusative Object",
    )

    c_target = add_construction(
        conn, sense_id=senses["violation"],
        construction_governance=(
            "Multiple competing constructions all mark the person an outrage is "
            "directed against: bare genitive objecti (ὕβρις τινός, 'an outrage "
            "towards him'); εἰς + accusative (Ἥρας μητέρ' εἰς ἐμὴν ὕβρις, Euripides "
            "Bacchae 9, 'an outrage against my mother Hera'); κατά + accusative (ἡ "
            "κατ' Ἀργείους ὕβρις, Sophocles fr. 368)."
        ),
        required_case="Genitive (bare) / Accusative (governed by εἰς or κατά)",
        case_why_not_another=(
            "Greek has at least three live grammatical strategies for marking the "
            "victim/target of an outrage, with no single construction winning out — "
            "a genitive objecti (treating the outrage as inherently 'of' its "
            "target, the way an objective genitive works generally in this "
            "database, cf. γνῶσις's C035), εἰς+accusative (directional, 'against/"
            "towards'), and κατά+accusative (a distinct 'against' sense, distinct "
            "from κατά's own accordance-sense documented elsewhere for λόγος/νόμος)."
        ),
        syntactic_pitfall=(
            "Students should not expect one canonical construction for 'victim of "
            "an outrage' — recognizing that Greek freely varies between a bare "
            "objective genitive and two different prepositional strategies for "
            "the same semantic role is itself the lesson."
        ),
        morphology="τινός, genitive; ἐμὴν (μητέρα), accusative governed by εἰς; Ἀργείους, accusative governed by κατά.",
        syntax_role="Each marks the object/target of the outrage named by ὕβρις.",
        morphological_change=None,
        pattern_category="Genitive of Specification/Domain",
    )

    c_personified = add_construction(
        conn, sense_id=senses["personified"],
        construction_governance=(
            "Ὕβριν, Κόρου ματέρα θρασύμυθον (Pindar, Olympian 13.10) — 'Hybris, the "
            "bold-tongued mother of Koros' — Ὕβρις as the head of a genealogical, "
            "personifying apposition."
        ),
        required_case="Accusative (Ὕβριν, object of the verb of address/invocation)",
        case_why_not_another=(
            "Not a case-choice teaching point — the signal is the appositive "
            "genealogical epithet (Κόρου ματέρα, 'mother of Koros') attached to the "
            "noun, the same personification-marking strategy already confirmed "
            "twice elsewhere in this database (Δίκη as subject of active verbs; "
            "Ἀρετή as speaking character) — this is now the THIRD independent "
            "confirmation of the pattern, strong enough to treat as settled."
        ),
        syntactic_pitfall=(
            "A student who has only met ὕβρις as an abstract quality may flatten "
            "this into loose personification-as-figure-of-speech, rather than "
            "recognizing Pindar is constructing an actual genealogical relationship "
            "(a literal mother-child pair) between two personified abstractions."
        ),
        morphology="Ὕβριν, accusative singular; Κόρου, genitive singular of Κόρος, dependent on ματέρα.",
        syntax_role="Ὕβριν as the addressed/named entity; Κόρου ματέρα as an appositive genealogical epithet.",
        morphological_change=None,
        pattern_category="Personification-Marking (Syntactic Role)",
    )

    c_animal = add_construction(
        conn, sense_id=senses["animal"],
        construction_governance=(
            "ὑπὸ ὕβριος ἐσβὰς ἐς τὸν ποταμόν (Herodotus 1.189) — 'having gone into "
            "the river out of unruliness' — ὑπό + genitive marking the internal "
            "impulse/cause of a spontaneous action, not an external agent."
        ),
        required_case="Genitive (governed by ὑπό)",
        case_why_not_another=(
            "A distinct function of ὑπό+genitive from the one already documented "
            "in this database as ἀπό's foil (marking the AGENT of a passive verb, "
            "cf. ἀπό's C043): here ὑπό+genitive instead marks an internal "
            "psychological/behavioral CAUSE or impulse driving a spontaneous, "
            "active-voice action (the horse's own unruliness drove it into the "
            "river) — genuinely a second, separate function for the same "
            "preposition-plus-case combination."
        ),
        syntactic_pitfall=(
            "Students who learned ὑπό+genitive only as 'the agent of a passive "
            "verb' from this database's ἀπό entry should notice this is a "
            "structurally identical construction doing a different job — an "
            "internal-cause reading, not an external-agent reading, since the verb "
            "here (ἐσβάς, 'having gone in') is active, not passive."
        ),
        morphology="ὕβριος, genitive singular (Ionic form of ὕβρεως), governed by ὑπό.",
        syntax_role="Adverbial prepositional phrase marking the internal cause of the action.",
        morphological_change=None,
        pattern_category="SINGLETON: Hypo + Genitive (Internal Cause, not Agent)",
    )

    print(f"Constructions created: {[c_manner, c_legal, c_cognate, c_target, c_personified, c_animal]}")

    # -- Citations ------------------------------------------------------------
    add_citation(
        conn, construction_id=c_manner,
        example_citation=(
            "Sophocles, Electra 881 — οὐχ ὕβρει λέγω τάδε, 'I do not say this in "
            "wantonness'; cf. Euripides, Orestes 1581 (ἐφ' ὕβρει) and Xenophon, "
            "Hellenica 2.2.10 (διὰ τὴν ὕβριν)."
        ),
        why_this_word=(
            "Electra needs to preemptively disclaim any accusation of speaking out "
            "of mere insolence — the bare dative ὕβρει functions almost as a fixed "
            "disclaimer formula in this kind of self-defensive framing."
        ),
        translation_choices="لا أقول هذا عن غطرسة — a natural Arabic rendering preserving the disclaiming force.",
        source_reliability="Sophocles, Electra, ed. Lloyd-Jones/Wilson (OCT); Euripides and Xenophon per standard OCT editions.",
        verification_notes=(
            "CONFIRMED via direct textual excerpt in the source lexicon material this entry was "
            "built from (all three citations independently given across the English and German sources)."
        ),
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_legal,
        example_citation=(
            "Demosthenes 21.47 — the text of ὁ τῆς ὕβρεως νόμος, 'the law concerning "
            "ὕβρις', quoted within Against Meidias."
        ),
        why_this_word=(
            "Demosthenes needs the technical legal noun specifically (not a looser "
            "synonym) because his entire prosecutorial strategy depends on "
            "establishing that Meidias's assault meets the legal threshold for "
            "ὕβρις (triggering public prosecution) rather than merely αἰκία (a "
            "private matter)."
        ),
        translation_choices="قانون جريمة الاعتداء الجسيم — a translator's note should flag this as a specific legal-procedural term, not general 'insolence'.",
        source_reliability="Demosthenes, Orations, ed. Dilts (OCT), Oration 21 (Against Meidias), section 47.",
        verification_notes=(
            "CONFIRMED — directly given in the source lexicon material (Middle Liddell "
            "explicitly cites 21.47 for the law's text and describes the γραφή/δίκη "
            "procedural split)."
        ),
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_cognate,
        example_citation=(
            "Euripides, Heracles Furens 741; Bacchae 247 — ὕβρεις ὑβρίζειν, 'to "
            "commit outrages'."
        ),
        why_this_word=(
            "The cognate construction lets Euripides name a pattern of repeated, "
            "specific outrageous acts rather than a single continuous quality — "
            "fitting both plays' concern with escalating, countable transgressions "
            "against divine and social order."
        ),
        translation_choices="ارتكاب الفظائع/الإهانات — natural Arabic preserving the 'committing acts' sense.",
        source_reliability="Euripides, Heracles and Bacchae, ed. Diggle (OCT).",
        verification_notes="CONFIRMED — directly given in the source lexicon material (Pape).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_target,
        example_citation=(
            "Euripides, Bacchae 9 — Ἥρας μητέρ' εἰς ἐμὴν ὕβρις, 'an outrage against "
            "my mother, on Hera's part' [i.e. Hera's outrage against Dionysus's "
            "mother Semele]."
        ),
        why_this_word=(
            "Dionysus opens the play naming the specific divine grievance driving "
            "the whole plot — the εἰς-phrase pins down exactly who suffered the "
            "outrage (Semele), essential for the audience to track the god's "
            "motive for revenge."
        ),
        translation_choices="عدوان [هيرا] ضد أمي — natural Arabic preserving the directional 'against' sense.",
        source_reliability="Euripides, Bacchae, ed. Dodds (standard commentary) or Diggle (OCT).",
        verification_notes="CONFIRMED — directly given in the source lexicon material (Pape, LSJ).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_personified,
        example_citation=(
            "Pindar, Olympian 13.10 — Ὕβριν, Κόρου ματέρα θρασύμυθον, 'Hybris, the "
            "bold-tongued mother of Koros'."
        ),
        why_this_word=(
            "Pindar personifies and genealogizes both abstractions specifically to "
            "warn his patron's city against the very civic vice (arrogance born of "
            "excess/success) an epinician ode for an athletic victory risks "
            "encouraging — the personification makes the moral warning vivid within "
            "a poem that is otherwise pure celebration."
        ),
        translation_choices="هيبريس، أم كوروس الجريئة اللسان — proper-name treatment kept distinct from the common abstract noun, consistent with this database's treatment of Δίκη and Ἀρετή's personifications.",
        source_reliability="Pindar, Olympian Odes, ed. Snell-Maehler (Teubner) or the dedicated Pindaric lexicon.",
        verification_notes="CONFIRMED — directly given in the source lexicon material (the Pindaric-specific lexicon entry).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_animal,
        example_citation=(
            "Herodotus 1.189.1 — ὑπὸ ὕβριος ἐσβὰς ἐς τὸν ποταμόν, 'having gone into "
            "the river out of unruliness' [of a horse]."
        ),
        why_this_word=(
            "Herodotus needs to explain WHY the sacred horse's death by drowning "
            "provoked Cyrus's famously excessive retaliation against the river "
            "itself — attributing the horse's fatal plunge to its own unruliness "
            "(rather than the river's malice) sets up the narrative irony of "
            "Cyrus's disproportionate response."
        ),
        translation_choices="بدافع الجموح، من فرط الجماح — جماح is the precise, idiomatic Arabic term for an animal's unruliness, not a generic 'violence' gloss.",
        source_reliability="Herodotus, Historiae, ed. Wilson (OCT), Book 1, section 189.",
        verification_notes="CONFIRMED — directly given in the source lexicon material (the Dutch dictionary entry).",
        verification_status="verified",
    )

    # -- Morph_Index -----------------------------------------------------------
    forms = [
        ("ὕβρις", "nominative", "singular", "Citation/dictionary form."),
        ("ὕβρεως", "genitive", "singular", "From C_legal (ὁ τῆς ὕβρεως νόμος) -- standard Attic genitive."),
        ("ὕβριος", "genitive", "singular", "Epic/Ionic genitive variant -- from C_animal (Herodotus 1.189)."),
        ("ὕβρει", "dative", "singular", "From C_manner (ὕβρει, ἐφ' ὕβρει)."),
        ("ὕβριν", "accusative", "singular", "From C_personified (Pindar) and the genitive-objecti target construction."),
        ("ὕβρεις", "accusative", "plural", "From C_cognate (ὕβρεις ὑβρίζειν) -- countable-plural 'outrages' sense."),
    ]
    for form, case_, number, notes in forms:
        ok = add_morph_form(conn, inflected_form=form, lemma_id=lemma_id, case_=case_, number=number, notes=notes)
        print(f"Morph form {form}: {'inserted' if ok else 'already existed (skipped)'}")

    conn.close()
    print("\nDone. Lemma ID:", lemma_id)


if __name__ == "__main__":
    main()
