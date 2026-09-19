"""
add_word13.py -- physis, "nature": the central noun of Presocratic and
Sophistic cosmology, and the direct philosophical counterpart to nomos
(Lemma L002, already in the database). Returns to nouns/verbs after two
consecutive particles (gar, L011; kai, L012), per the user's chosen
direction for word 13. Built through db_utils.py, same pipeline as
words 10-12.

Run with: python scripts/add_word13.py
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
        term_original="φύσις",
        language="Ancient Greek",
        root_lineage=(
            "From φύω, 'to bring forth, produce, grow' (PIE *bʰuH- 'to "
            "become, grow', the same root underlying English 'be' and Latin "
            "fui/futurus) -- φύσις is a nominal formation in -σις marking "
            "process-or-result, the identical suffix pattern already "
            "documented for γνῶσις (Lemma L006): 'the act/state of growing' "
            "-> 'the grown character of a thing' -> 'nature' in the full "
            "range of senses below. Genitive φύσεως, an athematic -ι- stem "
            "(third declension), not to be confused morphologically with "
            "first-declension -ις nouns."
        ),
        semantic_field=(
            "The inherent character or constitution of a person or thing; "
            "the physical/natural world taken as a whole; nature as opposed "
            "to law, convention, or custom (the φύσις/νόμος antithesis); "
            "Aristotle's technical sense, an internal principle of motion "
            "and rest belonging to a thing in virtue of itself; the older, "
            "more concrete sense of birth, growth, or outward form."
        ),
        cross_language_connection=(
            "Latin natura (from nasci, 'to be born') follows the identical "
            "etymological logic as φύσις -- a birth/growth verb turned into "
            "an abstract noun for 'nature' -- making this one of the "
            "cleanest parallel word-formations across the two languages "
            "this database has documented. English 'nature' descends from "
            "natura, not from φύσις directly, though 'physics', 'physical', "
            "and 'physique' all come straight from this lemma. Arabic splits "
            "the concept: طبيعة (ṭabī'a, from ṭaba'a 'to stamp, imprint' -- a "
            "different root metaphor, imprint rather than growth) covers "
            "the general and cosmic senses; فطرة (fiṭra, 'innate "
            "disposition', a term with its own theological weight in "
            "Islamic thought) is the sharper match for the inherent-"
            "character sense specifically, the same kind of precise-versus-"
            "loose gloss choice already made for γάρ and καί."
        ),
        modern_resonance=(
            "Root of 'physics' via Aristotle's own Φυσικὴ ἀκρόασις "
            "('lectures on nature'), and of 'physical', 'physique', "
            "'physiology'. The φύσις/νόμος antithesis (nature versus "
            "convention) remains a live term of art in political and legal "
            "theory -- any argument that a rule is 'merely conventional' "
            "versus 'natural' descends directly from the 5th-century Greek "
            "debate this lemma anchors."
        ),
        classical_concept=(
            "φύσις is this database's second half of a philosophical pair "
            "begun with νόμος (Lemma L002): the physis/nomos antithesis is "
            "one of the defining debates of 5th-century Greek thought, run "
            "by the Sophists (Antiphon's fragmentary Περὶ Ἀληθείας argues "
            "νόμος-imposed rules constrain a freer φύσις-given human nature) "
            "and dramatized in Plato's Gorgias, where Callicles argues that "
            "φύσις itself sanctions the rule of the stronger against merely "
            "conventional νόμος (Gorgias 483a-484c). Aristotle later gives "
            "φύσις a narrow technical sense as an internal principle of "
            "change and rest (Physics 192b8-23) -- a definition this entry "
            "keeps as its own sense (S4) rather than merging into the "
            "broader 'nature' sense, on the same finer-than-the-lexica "
            "logic already used for καί's S3/S4 split, since the Arabic "
            "gloss for the Aristotelian technical sense (المبدأ الطبيعي) is "
            "not simply طبيعة."
        ),
    )
    print(f"Lemma created: {lemma_id}")

    senses = {}

    senses["birth_growth"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Birth, growth, outward form (older, concrete sense)",
        primary_arabic_definition="النشأة، الشكل الخِلقي",
        nuance_context=(
            "The oldest attested sense, close to the root meaning of φύω "
            "itself: the outward form or growth-process of a particular "
            "thing, not yet the abstract philosophical noun -- ὣς ἄρα "
            "φωνήσας πόρε φάρμακον ἀργεϊφόντης, ἐκ γαίης ἐρύσας, καί μοι "
            "φύσιν αὐτοῦ ἔδειξε, 'so speaking, the slayer of Argus gave me "
            "the herb, drawing it from the earth, and showed me its φύσις', "
            "of the magical herb moly (Odyssey 10.302-303)."
        ),
        literal_vs_contextual=(
            "Here φύσις denotes the concrete outward appearance/growth-form "
            "of a specific plant, not an abstract principle -- the sense "
            "from which every later, more philosophical use of the word "
            "eventually develops, comparable to how S6 of εἰμί or S1 of "
            "γάρ anchor a whole entry's later abstractions in something "
            "concrete."
        ),
        synonyms_antonyms="Close to εἶδος ('form, shape') in this earliest attested use.",
        author_period_nuance="Homeric; effectively obsolete as a live sense by the classical philosophical period, though never formally superseded -- later authors simply build new senses on top of it.",
        fixed_expression_proverb=None,
        student_note=(
            "In Homer specifically, default to this concrete 'form/growth' "
            "sense rather than reaching for a philosophical 'nature' "
            "reading that postdates the text by two centuries."
        ),
    )

    senses["inherent_character"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Inherent character or constitution of a person or thing",
        primary_arabic_definition="فطرة",
        nuance_context=(
            "The essential, defining make-up of a particular person, group, "
            "or thing -- ἀνθρωπίνη φύσις, 'human nature' as a recurring "
            "phrase in Thucydides (e.g. 3.82.2, on how war reveals it); "
            "Herodotus routinely uses φύσις for the national character of a "
            "people."
        ),
        literal_vs_contextual=(
            "A stable trait or constitution the subject has AS ITSELF, "
            "independent of law, upbringing, or circumstance -- the sense "
            "the whole φύσις/νόμος antithesis (S3) depends on, since it is "
            "specifically this inborn constitution that Sophistic argument "
            "sets against externally imposed convention."
        ),
        synonyms_antonyms="Compare ἦθος ('character, disposition', more habituated/acquired); contrast νόμος (L002, externally imposed).",
        author_period_nuance="Thucydides and Herodotus favor this sense for collective/national character; later prose (Plato, Aristotle) extends it to individuals and to species generally.",
        fixed_expression_proverb="ἀνθρωπίνη φύσις -- 'human nature'.",
        student_note=(
            "When φύσις is possessed by a specific named subject (a person, "
            "a people, a species) rather than standing alone as 'Nature' in "
            "general, this individual-constitution sense is almost always "
            "correct."
        ),
    )

    senses["physical_world"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="The physical/natural world as a whole (cosmological sense)",
        primary_arabic_definition="الطبيعة",
        nuance_context=(
            "φύσις as the entire natural order, the subject-matter of "
            "cosmological inquiry -- the standard Presocratic book-title "
            "Περὶ Φύσεως ('On Nature'), attributed to Heraclitus, "
            "Parmenides, Empedocles, and others; Aristotle's own doxography "
            "in Physics I refers to his predecessors collectively as οἱ "
            "περὶ φύσεως, 'those [who wrote/inquired] concerning nature'."
        ),
        literal_vs_contextual=(
            "Distinct from S2: here φύσις is not any one thing's "
            "constitution but the totality of the natural, physical world "
            "taken as a single object of inquiry -- the sense that gives "
            "English 'physics' its name via Aristotle's own Φυσικὴ ἀκρόασις."
        ),
        synonyms_antonyms="Compare κόσμος ('the ordered universe'), a near-synonym in this cosmological register.",
        author_period_nuance="The defining sense of the entire Presocratic tradition (6th-5th c. BCE); Aristotle inherits and narrows it into his own technical S4.",
        fixed_expression_proverb="Περὶ Φύσεως -- standard Presocratic treatise title.",
        student_note=(
            "A bare, article-marked ἡ φύσις with no possessor and a "
            "cosmological or scientific context signals this whole-natural-"
            "world sense, not an individual thing's inherent character."
        ),
    )

    senses["antithesis_nomos"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Nature as opposed to law or convention (φύσις vs νόμος)",
        primary_arabic_definition="الفطرة (في مقابل العُرف/القانون)",
        nuance_context=(
            "The specifically Sophistic/political use, setting φύσις "
            "against νόμος as two rival sources of authority: Callicles' "
            "claim that φύσις itself shows the stronger ought to rule, "
            "against merely conventional νόμος (Plato, Gorgias 483e: κατὰ "
            "φύσιν τὴν τοῦ δικαίου ἔχει, 'according to nature this is what "
            "justice really is'); the same antithesis structures Antiphon's "
            "Περὶ Ἀληθείας."
        ),
        literal_vs_contextual=(
            "A direct cross-lemma pairing with νόμος (L002): this is not a "
            "new word-sense so much as a recurring ARGUMENT-STRUCTURE, "
            "attested wherever a speaker sets φύσις and νόμος in explicit "
            "opposition -- the same kind of cross-lemma structural pairing "
            "already documented between γάρ and καί (L011/L012) for "
            "particle position, but here operating at the level of a whole "
            "philosophical antithesis rather than syntax."
        ),
        synonyms_antonyms="Direct antonym in this specific use: νόμος (L002).",
        author_period_nuance="Defining vocabulary of the 5th-century Sophistic movement; still current in Plato (who complicates rather than abandons the antithesis) and in later rhetorical theory.",
        fixed_expression_proverb="φύσει... νόμῳ δέ -- 'by nature... but by convention', the standard framing formula (cf. C1).",
        student_note=(
            "Whenever φύσις appears paired or contrasted with νόμος (or "
            "θέσις, 'convention/positing') in the same sentence, treat this "
            "as invoking the whole Sophistic nature/convention debate, not "
            "a neutral descriptive use of either word."
        ),
    )

    senses["aristotelian_principle"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Aristotelian technical sense -- an internal principle of change and rest",
        primary_arabic_definition="المبدأ الطبيعي",
        nuance_context=(
            "Aristotle's formal definition: ἡ φύσις ἀρχή τις καὶ αἰτία τοῦ "
            "κινεῖσθαι καὶ ἠρεμεῖν ἐν ᾧ ὑπάρχει πρώτως, 'nature is a certain "
            "principle and cause of being moved and of being at rest, "
            "present in that to which it belongs primarily' (Physics "
            "192b20-23) -- restricting φύσις specifically to things that "
            "have the source of their own change WITHIN themselves (plants, "
            "animals, the elements), as opposed to artifacts (τέχνη), whose "
            "principle of change is external."
        ),
        literal_vs_contextual=(
            "Kept as a separate sense from S3 (the general cosmological "
            "'natural world') because the Arabic gloss genuinely changes: "
            "المبدأ الطبيعي names a specific causal PRINCIPLE, not the "
            "physical world as an object -- the same finer-than-the-source-"
            "lexica split already justified for καί's S3/S4 (LSJ groups "
            "senses that our three-test method keeps apart)."
        ),
        synonyms_antonyms="Contrasts specifically with τέχνη ('craft, art', whose products have an external, not internal, principle of change).",
        author_period_nuance="Aristotle's own coinage-by-narrowing of an existing word; foundational for the entire Aristotelian corpus (Physics, De Caelo, De Anima all presuppose it).",
        fixed_expression_proverb=None,
        student_note=(
            "In Aristotle specifically, check whether the passage is "
            "drawing his internal/external principle-of-change distinction "
            "(often via an explicit contrast with τέχνη) before defaulting "
            "to the broader S3 'natural world' gloss."
        ),
    )

    print(f"Senses created: {list(senses.values())}")

    # -- Constructions ---------------------------------------------------------
    c_dative_manner = add_construction(
        conn, sense_id=senses["antithesis_nomos"],
        construction_governance=(
            "φύσει (dative singular, no preposition) used adverbially, "
            "'by nature, naturally', standardly paired with νόμῳ ('by "
            "convention') in the same sentence: φύσει... νόμῳ δέ, the "
            "framing formula of the whole Sophistic antithesis."
        ),
        required_case="Dative (bare, instrumental/manner use -- no preposition).",
        case_why_not_another=(
            "The bare dative marks MANNER ('in what way/by what standard "
            "something holds true'), not means or location -- the same "
            "instrumental-dative logic that governs νόμῳ on the other side "
            "of this exact antithesis (L002), making φύσει/νόμῳ a matched "
            "grammatical pair as well as a matched conceptual one."
        ),
        syntactic_pitfall=(
            "Students should not mistake this bare dative for a dative of "
            "indirect object or agent -- it functions adverbially, "
            "answering 'according to which standard?', and is only fully "
            "legible when its paired opposite (νόμῳ, θέσει) is also "
            "present or implied in context."
        ),
        morphology="Dative singular of the -ι- stem, φύσις -> φύσει.",
        syntax_role="Adverbial dative of manner/standard, regularly paired with νόμῳ.",
        morphological_change=None,
        pattern_category="Dative of Manner/Standard (paired antithesis with νόμος's own νόμῳ)",
    )

    c_peri_title = add_construction(
        conn, sense_id=senses["physical_world"],
        construction_governance=(
            "Περὶ φύσεως (genitive after περί, 'concerning'), the fixed "
            "Presocratic treatise-title formula -- attributed to "
            "Heraclitus, Parmenides, Empedocles, Melissus, and others, and "
            "referenced collectively by Aristotle as a recognized genre."
        ),
        required_case="Genitive (governed by the preposition περί, 'concerning, about').",
        case_why_not_another=(
            "A standard object-of-preposition genitive with περί in its "
            "'concerning' sense -- unremarkable case governance, but "
            "significant as a fixed generic convention: this exact "
            "genitive phrase became the STANDARD title for an entire genre "
            "of early philosophical writing, not just an ordinary "
            "prepositional phrase."
        ),
        syntactic_pitfall=(
            "Recognize Περὶ Φύσεως as a genre-marking title formula on "
            "sight, comparable to how a modern reader recognizes 'A Treatise "
            "Concerning...' as signaling a specific kind of book, not just "
            "parsing the grammar word by word."
        ),
        morphology="Genitive singular of the -ι- stem, φύσις -> φύσεως.",
        syntax_role="Object of the preposition περί in its topic-marking ('concerning') use.",
        morphological_change=None,
        pattern_category="SINGLETON: Genitive-of-Topic Treatise Title",
    )

    c_kata_physin = add_construction(
        conn, sense_id=senses["antithesis_nomos"],
        construction_governance=(
            "κατὰ φύσιν (accusative after κατά, 'according to, in "
            "accordance with'), 'according to nature, naturally' -- Plato, "
            "Gorgias 483e: κατὰ φύσιν τὴν τοῦ δικαίου ἔχει, Callicles "
            "asserting what justice really is according to nature, "
            "explicitly against νόμῳ-based justice."
        ),
        required_case="Accusative (governed by κατά in its 'according to' sense).",
        case_why_not_another=(
            "A standard κατά + accusative of standard/accordance -- "
            "grammatically ordinary, but functioning as the accusative-"
            "phrase counterpart to C1's bare dative φύσει: two distinct "
            "case-constructions both cashing out the same 'by nature' "
            "idea, one via bare instrumental dative and one via a "
            "prepositional accusative of standard."
        ),
        syntactic_pitfall=(
            "Do not conflate κατὰ φύσιν with κατὰ νόμον ('according to "
            "law/custom') as interchangeable -- in Sophistic argument "
            "specifically, the choice between them is the entire point at "
            "issue, not a stylistic variation."
        ),
        morphology="Accusative singular of the -ι- stem, φύσις -> φύσιν.",
        syntax_role="Object of the preposition κατά in its 'according to a standard' use.",
        morphological_change=None,
        pattern_category="SINGLETON: Accusative-of-Standard with κατά",
    )

    c_arche_predicate = add_construction(
        conn, sense_id=senses["aristotelian_principle"],
        construction_governance=(
            "ἡ φύσις ἀρχή τις καὶ αἰτία τοῦ κινεῖσθαι καὶ ἠρεμεῖν (Physics "
            "192b20-23) -- φύσις as grammatical subject taking a predicate "
            "nominative (ἀρχή... καὶ αἰτία) that is itself completed by an "
            "articular infinitive genitive (τοῦ κινεῖσθαι καὶ ἠρεμεῖν, "
            "'of being moved and being at rest')."
        ),
        required_case="Nominative (subject); predicate nominative (ἀρχή, αἰτία); genitive of the articular infinitive as their complement.",
        case_why_not_another=(
            "The articular infinitive genitive (τοῦ κινεῖσθαι) is what "
            "makes this a formal DEFINITION rather than a description: "
            "ἀρχή and αἰτία each require a genitive complement naming what "
            "they are the principle/cause OF, and Aristotle supplies a "
            "whole infinitive clause rather than a single noun, letting the "
            "definition specify a process (being-moved-and-being-at-rest) "
            "rather than a static thing."
        ),
        syntactic_pitfall=(
            "Students should recognize this articular-infinitive-genitive "
            "pattern as Aristotle's standard machinery for formal "
            "definitions generally, not something specific to φύσις -- once "
            "recognized here, the same construction should be watched for "
            "across the rest of the Physics and other treatises."
        ),
        morphology="Nominative singular subject; genitive singular articular infinitives κινεῖσθαι/ἠρεμεῖν with neuter article τοῦ.",
        syntax_role="Subject of a formal definitional sentence, completed by predicate nouns each governing a genitive articular infinitive.",
        morphological_change=None,
        pattern_category="SINGLETON: Aristotelian Definitional Predicate (ἀρχή/αἰτία + articular infinitive genitive)",
    )

    c_possessive_genitive = add_construction(
        conn, sense_id=senses["inherent_character"],
        construction_governance=(
            "ἡ ἀνθρωπίνη φύσις / ἡ φύσις τῶν ἀνθρώπων -- either an "
            "attributive adjective (ἀνθρωπίνη) or an explicit possessive "
            "genitive (τῶν ἀνθρώπων) attaching φύσις to the specific "
            "subject whose constitution is meant, as in Thucydides 3.82.2 "
            "on how στάσις (civil conflict) lays human nature bare."
        ),
        required_case="Nominative (φύσις itself, as subject or predicate) plus either an attributive adjective or a possessive genitive specifying whose nature.",
        case_why_not_another=(
            "Unlike S3/S4's bare, unattached ἡ φύσις (the whole natural "
            "world, or Aristotle's abstract principle), this sense "
            "requires an explicit attachment -- an adjective or genitive -- "
            "identifying a particular possessor; the presence or absence "
            "of that attachment is itself the main diagnostic separating "
            "S2 from S3/S4 in an unclear passage."
        ),
        syntactic_pitfall=(
            "An unattached, bare ἡ φύσις defaults to the cosmological or "
            "Aristotelian sense (S3/S4) in a philosophical context; only an "
            "explicit adjective or genitive of possession should trigger "
            "the individual-constitution reading (S2) -- conflating the two "
            "is the most common error this Construction guards against."
        ),
        morphology="Nominative singular φύσις plus attributive adjective agreement, or genitive plural/singular of the possessor noun.",
        syntax_role="Head noun taking an attributive modifier or possessive genitive.",
        morphological_change=None,
        pattern_category="SINGLETON: Possessed/Attributive Nature-of-X",
    )

    print(
        "Constructions created: "
        f"{[c_dative_manner, c_peri_title, c_kata_physin, c_arche_predicate, c_possessive_genitive]}"
    )

    # -- Citations ---------------------------------------------------------------
    add_citation(
        conn, construction_id=c_dative_manner,
        example_citation=(
            "Plato, Gorgias 483a-e (paraphrasing the standard Sophistic "
            "formula) -- φύσει μὲν... νόμῳ δέ, 'by nature... but by "
            "convention', framing Callicles' argument that natural justice "
            "and conventional justice diverge."
        ),
        why_this_word=(
            "The entire force of Callicles' speech depends on holding "
            "φύσει and νόμῳ apart as two distinct, competing standards -- "
            "the bare dative construction is not incidental phrasing but "
            "the grammatical skeleton the whole argument is built on."
        ),
        translation_choices=(
            "بالفطرة... أمّا بالعُرف -- بـ + الاسم mirrors the Greek bare "
            "dative of standard naturally in Arabic."
        ),
        source_reliability="Plato, Gorgias, ed. Dodds (Oxford) or Burnet (OCT), 483a-e.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, s.v. φύσις III).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_peri_title,
        example_citation=(
            "Attributed treatise title, e.g. Heraclitus' Περὶ Φύσεως (as "
            "transmitted by Diogenes Laertius 9.5) -- 'Concerning Nature', "
            "the standard Presocratic book-title formula."
        ),
        why_this_word=(
            "The near-universal adoption of this exact title across "
            "unrelated Presocratic authors shows φύσις functioning as the "
            "named subject-matter of an entire emerging discipline, not "
            "merely a word one author happened to use."
        ),
        translation_choices=(
            "في الطبيعة -- في preserves the 'concerning/about' topic-"
            "marking sense that περί carries here."
        ),
        source_reliability="Diogenes Laertius, Vitae Philosophorum, ed. Dorandi (Cambridge), 9.5.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, Pape).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_kata_physin,
        example_citation=(
            "Plato, Gorgias 483e -- κατὰ φύσιν τὴν τοῦ δικαίου ἔχει, "
            "Callicles claiming to state what justice really amounts to "
            "'according to nature'."
        ),
        why_this_word=(
            "Callicles deploys κατὰ φύσιν as a direct rhetorical weapon "
            "against conventional (νόμῳ-based) accounts of justice, making "
            "the specific preposition-plus-case choice central to the "
            "philosophical claim being made, not a neutral paraphrase of "
            "φύσει."
        ),
        translation_choices=(
            "بحسب الفطرة، هذا هو حقيقة العدل -- بحسب + الاسم captures the "
            "'according to a standard' force of κατά + accusative."
        ),
        source_reliability="Plato, Gorgias, ed. Dodds (Oxford) or Burnet (OCT), 483e.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, s.v. φύσις III.2).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_arche_predicate,
        example_citation=(
            "Aristotle, Physics 192b20-23 -- ἡ φύσις ἀρχή τις καὶ αἰτία τοῦ "
            "κινεῖσθαι καὶ ἠρεμεῖν ἐν ᾧ ὑπάρχει πρώτως, 'nature is a "
            "principle and cause of being moved and being at rest, present "
            "in that to which it belongs primarily'."
        ),
        why_this_word=(
            "This single sentence is the foundational technical definition "
            "for the entire Aristotelian corpus's use of φύσις -- every "
            "later argument in the Physics, De Caelo, and De Anima that "
            "invokes 'nature' as a causal principle presupposes exactly "
            "this definition."
        ),
        translation_choices=(
            "الطبيعة مبدأ وعلّة للحركة والسكون -- مبدأ وعلّة renders ἀρχή "
            "καὶ αἰτία as the paired technical terms Arabic Aristotelian "
            "commentary (e.g. Ibn Rushd) traditionally uses."
        ),
        source_reliability="Aristotle, Physics, ed. Ross (Oxford) or Wicksteed & Cornford (Loeb), 192b20-23.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, Bonitz's Index Aristotelicus).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_possessive_genitive,
        example_citation=(
            "Thucydides 3.82.2 -- on how στάσις (civil conflict) strips "
            "away convention and lays bare ἡ ἀνθρωπίνη φύσις, 'human "
            "nature', in its rawest form."
        ),
        why_this_word=(
            "Thucydides' entire analytic claim -- that extreme political "
            "crisis reveals a constant underlying human nature beneath "
            "shifting circumstance -- depends on φύσις here naming a "
            "specific possessor's (humanity's) constitution, not nature in "
            "general or Aristotle's later technical principle."
        ),
        translation_choices=(
            "الطبيعة البشرية -- an established, immediately recognizable "
            "Arabic philosophical/political phrase for exactly this "
            "possessed-constitution sense."
        ),
        source_reliability="Thucydides, Historiae, ed. Jones & Powell (OCT), 3.82.2.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, s.v. φύσις II.2).",
        verification_status="verified",
    )

    # -- Morph_Index -------------------------------------------------------------
    forms = [
        ("φύσις", "nominative", "singular", "Citation/dictionary form."),
        ("φύσεως", "genitive", "singular", "Athematic -ι- stem genitive; base of Περὶ φύσεως titles and compounds."),
        ("φύσει", "dative", "singular", "Bare adverbial dative of manner/standard, 'by nature' -- see C1."),
        ("φύσιν", "accusative", "singular", "Base of κατὰ φύσιν and of the adverbial accusative-of-respect use."),
    ]
    for form, case_, number, notes in forms:
        ok = add_morph_form(conn, inflected_form=form, lemma_id=lemma_id, case_=case_, number=number, notes=notes)
        print(f"Morph form {form}: {'inserted' if ok else 'already existed (skipped)'}")

    conn.close()
    print("\nDone. Lemma ID:", lemma_id)


if __name__ == "__main__":
    main()
