"""
add_word12.py -- kai, the single most frequent word in the Greek corpus.
A direct structural contrast to word 11 (gar): kai is PREPOSITIVE (opens
its own coordinated unit) where gar was POSTPOSITIVE (can never open a
clause). Built through db_utils.py, same pipeline as words 10-11.

Run with: python scripts/add_word12.py
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
        term_original="καί",
        language="Ancient Greek",
        root_lineage=(
            "Etymology genuinely disputed: one proposed PIE root is *ki-e (a "
            "deictic/locative element related to 'here, this'); DGE instead "
            "proposes *km-t- ('with, alongside, downward'), passing through "
            "*kati > *kasi > Cypriot κάς, tentatively connecting it to "
            "κασίγνητος ('sibling', literally something like 'one from the "
            "same side/household'). Indeclinable, like γάρ -- but structurally "
            "the OPPOSITE of γάρ in one crucial respect: καί is PREPOSITIVE, "
            "regularly opening its own coordinated word, phrase, or clause, "
            "where γάρ (Lemma L011) is POSTPOSITIVE and can never stand "
            "first. Extremely productive in CRASIS (vowel-contraction with a "
            "following word): κἀ- (καὶ ἀ-), κ- before ε/η/ι/ο/υ/ω (κἀγώ, χἠ, "
            "χἰ, χὠ, χὐ, χᾦ), forms so frequent in verse that recognizing "
            "crasis on sight is a basic decoding skill, not an edge case."
        ),
        semantic_field=(
            "Basic copulative 'and'; correlative 'both...and'; scalar 'even'; "
            "additive 'also, too'; concessive 'and yet'; interrogative-"
            "intensifying (marking surprise/objection); comparative 'as, "
            "like'; and apodotic 'and then, so' (resuming a main clause after "
            "a temporal/conditional protasis)."
        ),
        cross_language_connection=(
            "Closest functional parallel: Latin et/-que (copulative) and "
            "etiam/quoque (scalar 'even'/'also') -- but Latin splits across "
            "several words what καί covers with one, the reverse of γάρ's "
            "situation (where Latin's enim was a reasonably close single-word "
            "match). Arabic likewise needs several distinct particles: و "
            "(wa, the basic 'and'), حتى (hatta, 'even' -- a precise idiomatic "
            "match, not a loose gloss), أيضًا (aydan, 'also'), كما (kama, "
            "comparative 'as, like'), and فـ (fa-, the resultative/sequential "
            "'and then, so' -- an excellent natural match for the apodotic "
            "function specifically)."
        ),
        modern_resonance=(
            "No direct English derivative, as expected for a function word -- "
            "but the sheer frequency data (kai is reported as among the most "
            "common words in essentially every Greek author, Homer through "
            "the New Testament) makes it a standard test case in corpus "
            "linguistics and in NT Greek pedagogy specifically, where its "
            "Hebraic-influenced use to open successive narrative clauses "
            "(the 'and it came to pass... and...' style, LXX Genesis 24:30 "
            "and parallel NT passages) is a recognized translation-Greek "
            "phenomenon, paralleling this database's earlier documentation "
            "of θεός's LXX/Hebrew-calque sense (S071 in that entry)."
        ),
        classical_concept=(
            "καί is this database's first PREPOSITIVE particle, a direct "
            "structural contrast to γάρ's postpositive rule (L011, C060): "
            "where γάρ can never open a clause, καί almost always does, "
            "standing at the head of the unit it coordinates. Unlike γάρ, "
            "which had essentially no denotational content at all (pure "
            "discourse-structural function), καί carries real semantic "
            "weight in at least two of its functions -- true logical "
            "conjunction (S1) and scalar focus (S3, 'even') -- making it a "
            "genuine intermediate case between a fully 'meaningful' word "
            "(like θεός or ἀρετή) and a fully function-only one (like γάρ). "
            "DESIGN NOTE: S3 ('even') and S4 ('also') are kept as separate "
            "senses rather than merged, on the strength of the Arabic test "
            "(حتى vs. أيضًα are genuinely different words, not registers of "
            "the same word) even though LSJ, Pape, and Bailly all treat them "
            "under one broad heading -- a case where our three-test method "
            "produces a finer split than the source dictionaries themselves "
            "draw, the same kind of independent judgment call already made "
            "for δίκη's lawsuit/trial split and ψυχή's Homeric/Orphic "
            "boundary."
        ),
    )
    print(f"Lemma created: {lemma_id}")

    senses = {}

    senses["copulative"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Basic copulative -- 'and' (core function)",
        primary_arabic_definition="وَ",
        nuance_context=(
            "The default, most frequent function: joining two or more words, "
            "phrases, or clauses as equivalent, coordinate units -- ἦ, καὶ "
            "κυανέῃσιν ἐπ' ὀφρύσι νεῦσε Κρονίων, 'he spoke, and nodded his "
            "dark brows' (Iliad 1.528). Repeated freely across long lists "
            "(αἱ ἔλαφοι καὶ δορκάδες καὶ οἱ ἄγριοι οἶες καὶ οἱ ὄνοι, "
            "Xenophon), unlike English, which typically reserves 'and' for "
            "the final item only."
        ),
        literal_vs_contextual=(
            "The unmarked, default reading -- assume this function first for "
            "any καί joining grammatically parallel items, and look to the "
            "other senses in this entry only when a plain 'and' produces an "
            "incoherent or flat translation."
        ),
        synonyms_antonyms="Near-synonym: τε (also copulative, but typically closer/tighter-binding, cf. S2).",
        author_period_nuance="Universal across every period and genre of Greek from Homer onward.",
        fixed_expression_proverb=None,
        student_note=(
            "This is the safe default translation, 'and' -- Greek repeats καί "
            "before every item in a list where English uses it only once "
            "before the last item; don't be misled by the repetition into "
            "expecting extra emphasis unless other signals (S2, S3) are "
            "present."
        ),
    )

    senses["correlative"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Correlative καί...καί / τε...καί -- 'both...and'",
        primary_arabic_definition="كِلا...و... / سواء...أم...",
        nuance_context=(
            "καί paired with an earlier τε or a second καί creates a tighter, "
            "more emphatic bipartite coordination than plain sequential καί: "
            "κ. κατὰ γῆν κ. κατὰ θάλατταν, 'both by land and by sea' "
            "(Xenophon, Anabasis 1.1.7); ἀεί τε καὶ νῦν, 'both always and "
            "now' (Plato, Gorgias 523a)."
        ),
        literal_vs_contextual=(
            "A structural intensification of S1, not a different logical "
            "relationship: the same 'and'-coordination, but marked as a "
            "closely-bound PAIR rather than an open-ended list -- comparable "
            "to how English 'both X and Y' feels tighter than simply 'X and "
            "Y'."
        ),
        synonyms_antonyms=None,
        author_period_nuance="Attested across all periods; especially frequent in Xenophon's balanced antithetical prose style.",
        fixed_expression_proverb="τε καὶ / καὶ...καὶ -- 'both...and'.",
        student_note=(
            "A τε earlier in the clause, resumed by a later καί (or two "
            "parallel καί clauses), signals this tighter 'both...and' "
            "pairing rather than an open list -- translate accordingly, not "
            "as loose sequential 'and... and...'"
        ),
    )

    senses["scalar_even"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Scalar 'even' (marking an unexpected or extreme included member)",
        primary_arabic_definition="حتى",
        nuance_context=(
            "καί marking that even an unlikely, extreme, or unexpected item "
            "is included in a claim: τάχα κεν καὶ ἀναίτιον αἰτιόῳτο, 'he "
            "might blame even the innocent [man]' (Iliad 11.654); δόμεναι "
            "καὶ μεῖζον ἄεθλον, 'to give an even greater prize' (Iliad "
            "23.551)."
        ),
        literal_vs_contextual=(
            "A genuine semantic addition beyond plain coordination (S1): καί "
            "here doesn't merely join two items but asserts that the "
            "following item is a SURPRISING or EXTREME instance of the "
            "category under discussion -- the Arabic rendering حتى (unlike "
            "أيضًا, S4) captures exactly this scalar-extreme flavor."
        ),
        synonyms_antonyms="Near-synonym in this function: Latin etiam.",
        author_period_nuance="Attested from Homer onward; especially frequent before comparatives and superlatives to intensify them further.",
        fixed_expression_proverb=None,
        student_note=(
            "If καί precedes a word naming something surprising, extreme, or "
            "unlikely to be included (an innocent person being blamed, an "
            "already-large prize made larger), translate 'even', not 'and' "
            "or 'also'."
        ),
    )

    senses["additive_also"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Additive 'also, too' (simple inclusion, no surprise implied)",
        primary_arabic_definition="أيضًا",
        nuance_context=(
            "καί marking simple additional inclusion in a set, without any "
            "implication of surprise or extremity: κ. αὐτοί, 'they also, "
            "they too' (Xenophon, Anabasis 3.4.44); κ. ἐγώ, 'I also' (Iliad "
            "4.40)."
        ),
        literal_vs_contextual=(
            "Kept as a SEPARATE sense from S3 ('even') on the strength of "
            "the Arabic test specifically: أيضًا (simple 'also') and حتى "
            "('even', implying surprise) are genuinely different words, even "
            "though the standard lexica (LSJ, Pape, Bailly) group both under "
            "one broad 'also, even' heading -- a case where our method draws "
            "a finer line than the source dictionaries do."
        ),
        synonyms_antonyms="Near-synonym: Latin quoque.",
        author_period_nuance="Universal across all periods, especially frequent with personal pronouns (καὶ ἐγώ/σύ/αὐτός) marking simple parallel inclusion.",
        fixed_expression_proverb=None,
        student_note=(
            "If καί simply adds a parallel item to a set without any sense "
            "of 'even this?!' surprise, translate 'also, too' rather than "
            "'even' -- pronouns (καὶ αὐτός, καὶ ἐγώ) are the most reliable "
            "signal for this plain additive sense."
        ),
    )

    senses["concessive"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Concessive 'and yet' (= καίτοι)",
        primary_arabic_definition="ومع ذلك، إلا أنّ",
        nuance_context=(
            "καί functioning like the compound καίτοι, marking an adversative "
            "qualification of what precedes rather than a simple addition -- "
            "attested as a recognized alternate function alongside plain "
            "coordination (Aristophanes, Knights 1245; Euripides, Heracles "
            "509)."
        ),
        literal_vs_contextual=(
            "A genuine logical reversal from S1: rather than adding a "
            "consistent further item, καί here introduces a qualification "
            "that cuts against what was just said -- the reader must "
            "recognize the adversative force from context, since the "
            "particle's form gives no formal signal distinguishing this from "
            "plain 'and'."
        ),
        synonyms_antonyms="Effectively equivalent in this function to καίτοι (the compound form, more formally marked).",
        author_period_nuance="Attested in Old Comedy (Aristophanes) and tragedy; a colloquially compressed alternative to the fuller καίτοι.",
        fixed_expression_proverb=None,
        student_note=(
            "If a plain 'and' reading makes the sentence contradict or "
            "undercut itself, check whether an adversative 'and yet' reading "
            "resolves the apparent contradiction -- Greek can leave this "
            "shift entirely unmarked."
        ),
    )

    senses["interrogative"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Interrogative-intensifying (marks surprise or objection in a question)",
        primary_arabic_definition="فكيف؟ / وكيف ذلك؟",
        nuance_context=(
            "καί opening a question to mark surprise, objection, or "
            "incredulity, rather than requesting neutral information: καὶ "
            "τίς τόδ' ἐξίκοιτ' ἂν ἀγγέλων τάχος; 'but who could arrive with "
            "such speed as a messenger?' (Aeschylus, Agamemnon 280); καὶ πῶς "
            "...; 'but how...?' (Euripides, Phoenissae 1348)."
        ),
        literal_vs_contextual=(
            "A direct structural parallel to γάρ's own interrogative "
            "function (L011, S085): both particles can open an abrupt "
            "question to convey emotional force (surprise, objection) rather "
            "than seeking causal explanation or plain information -- worth "
            "recognizing as a recurring TYPE of function (particle-marked "
            "emotional-question-force) that this database has now confirmed "
            "in two independent words."
        ),
        synonyms_antonyms=None,
        author_period_nuance="Frequent in tragic dialogue's more emotionally charged exchanges, comparable to γάρ's own distribution.",
        fixed_expression_proverb=None,
        student_note=(
            "καί opening a question with no calm informational context "
            "signals surprise or objection -- translate 'but...?' or "
            "'what...?' rather than a flat 'and...?'"
        ),
    )

    senses["comparative"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Comparative 'as, like' (after words of sameness or likeness)",
        primary_arabic_definition="كما، مِثلَما",
        nuance_context=(
            "After words expressing sameness, equality, or likeness (ὅμοιος, "
            "ἴσος, αὐτός), καί functions not as 'and' but as a comparative "
            "particle meaning 'as, like': γνώμῃσι ἐχρέωντο ὁμοίῃσι καὶ σύ, "
            "'they held the same opinions as you' (Herodotus 7.50); ἴσα καὶ "
            "μάκαρας, 'the same as the blessed gods' (Euripides, Electra "
            "994)."
        ),
        literal_vs_contextual=(
            "A genuinely different syntactic function from every other "
            "sense in this entry: καί here does the job English 'as' does "
            "after 'the same', not the job 'and' does -- a comparative "
            "marker, not a coordinating one, despite using the identical "
            "particle form."
        ),
        synonyms_antonyms="Functionally equivalent here to ὡς (comparative 'as').",
        author_period_nuance="Attested from Herodotus through Attic tragedy and prose, always specifically following a sameness/likeness word.",
        fixed_expression_proverb="ὅμοιος/ἴσος/αὐτός... καί -- 'the same/equal/like...as'.",
        student_note=(
            "καί immediately following ὅμοιος, ἴσος, or αὐτός (or an adverb "
            "built from them) is functioning as 'as/like', not 'and' -- a "
            "genuinely different grammatical job hiding behind the same "
            "particle."
        ),
    )

    senses["apodotic"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Apodotic 'and then, so' (resumes the main clause after a temporal/conditional protasis)",
        primary_arabic_definition="فَـ (السببية أو الاستئنافية)",
        nuance_context=(
            "καί marking the resumption of the main clause after a fronted "
            "temporal or conditional clause, especially in Homer: ἦμος δ' "
            "ἠριγένεια φάνη ῥοδοδάκτυλος Ἠώς, καὶ τότ' ἀνάγοντο, 'and when "
            "rosy-fingered Dawn appeared, THEN they put out to sea' (Iliad "
            "1.478) -- the arrival of dawn and the departure are marked as "
            "simultaneous/consequent via this resumptive καί."
        ),
        literal_vs_contextual=(
            "A direct structural counterpart to γάρ's own anticipatory-"
            "clause construction (L011, S082/C061): both involve a fronted "
            "subordinate clause and a particle marking how the main clause "
            "picks it back up -- γάρ's version explains BACKWARD (the "
            "fronted clause gives the reason for what follows), while καί's "
            "apodotic use marks TEMPORAL SIMULTANEITY OR CONSEQUENCE rather "
            "than causation. Two different logical relationships, the same "
            "'fronted-clause-plus-resumptive-particle' architecture."
        ),
        synonyms_antonyms=None,
        author_period_nuance="Especially characteristic of Homeric narrative style, marking temporal correlation between clauses; less common in developed Attic periodic prose, which increasingly prefers explicit subordination instead.",
        fixed_expression_proverb=None,
        student_note=(
            "A temporal/conditional clause (often opening with ὅτε, ἐπεί, or "
            "εἰ) followed by καί introducing the next clause signals this "
            "resumptive function -- translate the καί as 'then' or leave it "
            "untranslated, not as 'and' joining two unrelated statements."
        ),
    )

    print(f"Senses created: {list(senses.values())}")

    # -- Constructions ---------------------------------------------------------
    c_prepositive = add_construction(
        conn, sense_id=senses["copulative"],
        construction_governance=(
            "καί is PREPOSITIVE: it regularly stands as the FIRST word of the "
            "unit it coordinates -- ἦ, καὶ κυανέῃσιν ἐπ' ὀφρύσι νεῦσε "
            "Κρονίων (Iliad 1.528), καί opening the clause describing the "
            "nod. A direct structural contrast to γάρ (Lemma L011, "
            "Construction C060), which is POSTPOSITIVE and can never open a "
            "clause."
        ),
        required_case="N/A -- καί is indeclinable, no case is governed.",
        case_why_not_another=(
            "A pure word-order fact, the same non-case Construction category "
            "already introduced for γάρ (L011) -- but with the opposite "
            "value: γάρ's postpositive rule and καί's prepositive tendency "
            "are the two logically possible positions for a connective "
            "particle relative to its own clause, and this database now has "
            "a confirmed example of each, making this a genuine PAIRED "
            "pattern rather than two unrelated singletons."
        ),
        syntactic_pitfall=(
            "Students should use καί's clause-initial position as a positive "
            "signal for locating where a new coordinated unit begins -- the "
            "reverse of the skill γάρ's postpositive rule teaches (finding "
            "where a clause has ALREADY started, one or more words before "
            "the particle)."
        ),
        morphology="Indeclinable; no case, number, gender, tense, or mood forms exist.",
        syntax_role="Coordinating conjunction, structurally required to precede the unit it introduces.",
        morphological_change=None,
        pattern_category="Prepositive/Postpositive Particle Position (paired with gar's C060)",
    )

    c_concessive_ptc = add_construction(
        conn, sense_id=senses["scalar_even"],
        construction_governance=(
            "καί + participle = 'even though, although' -- Ἕκτορα καὶ "
            "μεμαῶτα μάχης σχήσεσθαι ὀΐω, 'I think that Hector, EVEN THOUGH "
            "raging, will be held back from battle' (Iliad 9.655), "
            "equivalent in force to καὶ εἰ + finite verb but compressed onto "
            "a bare participle."
        ),
        required_case="N/A -- the participle's own case is determined by its role in the clause, not by καί.",
        case_why_not_another=(
            "Not a case-governance point: καί here converts an ordinary "
            "circumstantial participle into a CONCESSIVE one purely through "
            "its scalar-extreme force (S3) -- 'even [while] raging' implies "
            "'no matter how much he rages', the same logical move as English "
            "'even so'. The participle's case still simply agrees with "
            "whatever noun it modifies, exactly as an uninflected "
            "circumstantial participle normally would."
        ),
        syntactic_pitfall=(
            "Students should recognize καί immediately before a participle as "
            "a strong signal for a concessive ('even though') rather than a "
            "merely temporal or causal circumstantial reading -- the same "
            "participle without καί would default to a much more neutral "
            "circumstantial sense."
        ),
        morphology="The following participle takes whatever case, number, and gender its own head noun requires.",
        syntax_role="καί intensifies the participle into a concessive reading.",
        morphological_change=None,
        pattern_category="SINGLETON: Concessive Participle Marker",
    )

    c_comparative = add_construction(
        conn, sense_id=senses["comparative"],
        construction_governance=(
            "γνώμῃσι ἐχρέωντο ὁμοίῃσι καὶ σύ (Herodotus 7.50) -- 'they held "
            "opinions similar to yours', literally 'similar...as you' -- καί "
            "functioning as a comparative particle after ὁμοίῃσι rather than "
            "as a coordinator."
        ),
        required_case="N/A -- καί itself governs no case; σύ here is simply nominative as the compared subject.",
        case_why_not_another=(
            "A genuine syntactic-function point, not a case-choice one: the "
            "presence of ὅμοιος/ἴσος/αὐτός earlier in the clause is what "
            "triggers reading καί as 'as' rather than 'and' -- the same "
            "particle form doing an entirely different grammatical job "
            "depending on this triggering context, a clean example of "
            "context-dependent function shift documented for a single "
            "unchanging particle."
        ),
        syntactic_pitfall=(
            "A literal 'and' translation here produces nonsense ('they held "
            "similar opinions and you') -- recognizing the triggering "
            "sameness-word (ὅμοιος, ἴσος, αὐτός) earlier in the clause is "
            "essential for correctly resolving καί as comparative rather "
            "than copulative."
        ),
        morphology=None,
        syntax_role="Comparative particle, functionally equivalent to ὡς, introducing the standard of comparison.",
        morphological_change=None,
        pattern_category="SINGLETON: Comparative Particle (Post-Sameness-Word)",
    )

    c_apodotic = add_construction(
        conn, sense_id=senses["apodotic"],
        construction_governance=(
            "ἦμος δ' ἠριγένεια φάνη ῥοδοδάκτυλος Ἠώς, καὶ τότ' ἀνάγοντο "
            "(Iliad 1.478) -- a fronted temporal clause (ἦμος...) resumed by "
            "καὶ τότε in the main clause, marking temporal correlation "
            "between the two."
        ),
        required_case="N/A",
        case_why_not_another=(
            "A discourse-structural pattern directly paired with γάρ's own "
            "anticipatory-clause construction (L011, C061): both put a "
            "subordinate clause first and use a particle in the main clause "
            "to mark how the two relate -- γάρ's inverted use signals "
            "CAUSATION (the fronted clause explains the main one), while "
            "καί's apodotic use signals TEMPORAL SIMULTANEITY OR SEQUENCE. "
            "Recognizing this as the same architectural pattern serving two "
            "different logical relationships is a mature cross-lemma "
            "reading skill this database is specifically positioned to "
            "teach, now that both words are present."
        ),
        syntactic_pitfall=(
            "Students should recognize καί (often paired with τότε) opening "
            "the second half of a temporal/conditional sentence as marking "
            "resumption, not fresh coordination -- treating it as ordinary "
            "'and' loses the correlation between the fronted clause and "
            "what follows."
        ),
        morphology=None,
        syntax_role="Marks the main clause as temporally correlated with a preceding fronted subordinate clause.",
        morphological_change=None,
        pattern_category="SINGLETON: Apodotic Resumption (paired with gar's Anticipatory Clause-Fronting)",
    )

    c_interrogative = add_construction(
        conn, sense_id=senses["interrogative"],
        construction_governance=(
            "καὶ τίς τόδ' ἐξίκοιτ' ἂν ἀγγέλων τάχος; (Aeschylus, Agamemnon "
            "280) -- καί opening an abrupt question to mark incredulity, "
            "directly parallel to γάρ's own interrogative use (L011, C063)."
        ),
        required_case="N/A",
        case_why_not_another=(
            "Not a case point -- the parallel with γάρ's interrogative "
            "Construction (documented for a DIFFERENT particle entirely) "
            "confirms that 'particle marking emotional force in an abrupt "
            "question' is a recurring FUNCTIONAL CATEGORY in Greek, "
            "independent of which specific particle happens to be doing the "
            "marking."
        ),
        syntactic_pitfall=(
            "A flat 'and who...?' translation misses the incredulous force "
            "the speaker intends -- compare directly against γάρ's τίς γάρ "
            "σε...; (Iliad 18.182) to see the same rhetorical move achieved "
            "with a different particle."
        ),
        morphology=None,
        syntax_role="Intensifies the emotional force of the question that follows.",
        morphological_change=None,
        pattern_category="SINGLETON: Interrogative-Intensifying Particle (cf. gar's parallel use)",
    )

    print(f"Constructions created: {[c_prepositive, c_concessive_ptc, c_comparative, c_apodotic, c_interrogative]}")

    # -- Citations ---------------------------------------------------------------
    add_citation(
        conn, construction_id=c_prepositive,
        example_citation="Homer, Iliad 1.528 -- ἦ, καὶ κυανέῃσιν ἐπ' ὀφρύσι νεῦσε Κρονίων, 'he spoke, and the son of Cronus nodded with his dark brows'.",
        why_this_word=(
            "Zeus's nod (confirming his promise to Thetis) is marked as "
            "immediately following his speech via prepositive καί opening "
            "the clause -- the word order itself iconically enacts the "
            "immediacy of the divine confirmation."
        ),
        translation_choices="تحدّث، وأومأ ابن كرونوس بحاجبيه الداكنين -- و is placed naturally at the head of the second clause, mirroring the Greek.",
        source_reliability="Homer, Iliad, ed. West (Teubner) or Monro/Allen (OCT), Book 1, line 528.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_concessive_ptc,
        example_citation="Homer, Iliad 9.655 -- Ἕκτορα καὶ μεμαῶτα μάχης σχήσεσθαι ὀΐω, 'I think that Hector, even though raging for battle, will be held back'.",
        why_this_word=(
            "Achilles' assessment of Hector's limits depends specifically on "
            "the concessive force here -- not merely 'Hector, who rages for "
            "battle' (a neutral description) but 'Hector, however much he "
            "rages' (a claim about a limit that even his rage cannot "
            "overcome)."
        ),
        translation_choices="أظن أن هكتور، حتى وهو مندفع نحو القتال، سيُصَدّ -- حتى وهو captures the concessive force naturally in Arabic.",
        source_reliability="Homer, Iliad, ed. West (Teubner) or Monro/Allen (OCT), Book 9, line 655.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, Bailly, Pape all cite this exact passage).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_comparative,
        example_citation="Herodotus 7.50 -- γνώμῃσι ἐχρέωντο ὁμοίῃσι καὶ σύ, 'they held opinions similar to yours' (literally 'similar...as you').",
        why_this_word=(
            "Xerxes' advisors are being described as sharing the king's own "
            "prior view -- the comparative καί construction lets Herodotus "
            "state this shared-opinion relationship in a single compact "
            "clause rather than a fuller subordinate comparison."
        ),
        translation_choices="كانت لديهم آراء مماثلة لآرائك -- كما لديك preserves the comparative sense naturally.",
        source_reliability="Herodotus, Historiae, ed. Wilson (OCT), Book 7, section 50.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, Pape, Bailly all cite this exact passage independently).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_apodotic,
        example_citation="Homer, Iliad 1.478 -- ἦμος δ' ἠριγένεια φάνη ῥοδοδάκτυλος Ἠώς, καὶ τότ' ἀνάγοντο, 'and when rosy-fingered Dawn appeared, then they put out to sea'.",
        why_this_word=(
            "The formulaic dawn-description marks a standard narrative time-"
            "transition in Homeric epic; the resumptive καὶ τότε makes the "
            "correlation between the time-marker and the narrated action "
            "explicit, a structural device that recurs across many similar "
            "passages."
        ),
        translation_choices="وحين ظهرت الفجر ذات الأصابع الوردية، عندئذ أبحروا -- فَـ or عندئذ both naturally mark this resumption in Arabic.",
        source_reliability="Homer, Iliad, ed. West (Teubner) or Monro/Allen (OCT), Book 1, line 478.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (Pape).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_interrogative,
        example_citation="Aeschylus, Agamemnon 280 -- καὶ τίς τόδ' ἐξίκοιτ' ἂν ἀγγέλων τάχος; 'but who could arrive with such speed as a messenger?'",
        why_this_word=(
            "The chorus's incredulous question challenges Clytemnestra's "
            "claim to have already learned of Troy's fall -- the intensified "
            "interrogative force of καί here conveys genuine skepticism, not "
            "neutral curiosity about the messenger's identity."
        ),
        translation_choices="ولكن من ذا الذي يبلغ هذه السرعة رسولًا؟ -- ولكن naturally conveys the objecting force of the Greek.",
        source_reliability="Aeschylus, Agamemnon, ed. Fraenkel or Denniston-Page, line 280.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ).",
        verification_status="verified",
    )

    # -- Morph_Index (crasis forms, per Root_Lineage) ---------------------------
    forms = [
        ("καί", None, None, "Citation/dictionary form."),
        ("κἀγώ", None, None, "Crasis: καὶ ἐγώ ('I also'), extremely frequent in tragic dialogue."),
        ("χὠ", None, None, "Crasis: καὶ ὁ ('and the...'), before a word starting with omicron plus rough breathing pattern."),
        ("κεἰ", None, None, "Crasis: καὶ εἰ ('and if' / 'even if')."),
    ]
    for form, case_, number, notes in forms:
        ok = add_morph_form(conn, inflected_form=form, lemma_id=lemma_id, case_=case_, number=number, notes=notes)
        print(f"Morph form {form}: {'inserted' if ok else 'already existed (skipped)'}")

    conn.close()
    print("\nDone. Lemma ID:", lemma_id)


if __name__ == "__main__":
    main()
