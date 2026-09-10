"""
add_word11.py — γάρ, a discourse particle. The hardest grammatical
category attempted in this database so far: no case government, no
real morphology, arguably no "meaning" in the sense every prior word
had. Built through db_utils.py, same as word 10.

Run with: python scripts/add_word11.py
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
        term_original="γάρ",
        language="Ancient Greek",
        root_lineage=(
            "A compound of the two particles γε and ἄρα (γε-ἄρα > γάρ), already "
            "recognized as such by ancient grammarians. Ancient scholars also debated "
            "a related crasis-form τάρ (= τε ἄρα), attested in Homeric variant "
            "readings (e.g. Il. 1.8, τίς τάρ for τίς γὰρ). Prosodically short in "
            "Attic without exception (any apparently long γάρ in the tragedians is "
            "textually corrupt, per LSJ); in Homer occasionally lengthened metri "
            "gratia before two short syllables, rarely before one long one. "
            "Indeclinable -- unlike every prior word in this database, γάρ has no "
            "morphological paradigm at all: no case, number, gender, tense, or mood "
            "to vary."
        ),
        semantic_field=(
            "Causal/explanatory connection ('for'), anticipatory/inverted "
            "explanation ('since, as'), elliptical confirmation or denial, "
            "introduction of proof or supporting narration, marking surprise in "
            "questions, strengthening a wish, and a fixed rhetorical-confirmation "
            "idiom (τί γάρ;)."
        ),
        cross_language_connection=(
            "Closest functional parallel: Latin enim (postpositive causal "
            "particle, similarly never sentence-initial). Arabic has no single "
            "particle covering this range -- natural renderings split across فَـ "
            "(the causal/sequential fa-), لأنّ (li-anna, 'because'), بما أنّ / إذ "
            "(bima anna / idh, 'since, given that'), and يا ليت (ya layta, the "
            "standard Arabic wish-particle, a near-perfect match for the "
            "optative-strengthening function). CRITICAL TRANSLATION POINT: the "
            "elliptical yes/no function (S3) has no Arabic particle equivalent at "
            "all -- a natural Arabic rendering must SUPPLY the implicit yes/no "
            "Greek leaves entirely to context (نعم...لأنّ / لا...لأنّ), a genuine "
            "translation gap, not just a vocabulary choice."
        ),
        modern_resonance=(
            "No direct English derivative (unlike ὕβρις's 'hubris' or εἰμί's "
            "'ontology') -- discourse particles rarely survive as loanwords since "
            "their function is language-internal. The postpositive-particle "
            "phenomenon itself (a connective that can never open a sentence) is a "
            "recurring typological curiosity discussed in general linguistics "
            "coursework on Greek and its Indo-European relatives."
        ),
        classical_concept=(
            "γάρ is fundamentally different in kind from every word in this "
            "database so far, including the two prior 'stress test' words (εἰμί, "
            "ἀπό). It has no case to govern (unlike ἀπό), no independent lexical "
            "content even in the thin sense εἰμί's copula retained (asserting "
            "predication), and no morphological paradigm at all. Its entire "
            "content is DISCOURSE-STRUCTURAL: how does the clause it introduces "
            "relate to the surrounding text -- explaining what precedes, "
            "anticipating what follows, filling a gap left by an omitted yes/no, "
            "introducing evidence, or marking a speaker's surprise or wish? DESIGN "
            "NOTE: 'Required_Case' is N/A across every Construction row in this "
            "entry -- there is no case for this word to govern or be governed by. "
            "The real teaching content instead concerns CLAUSE POSITION (does the "
            "γάρ-clause precede or follow what it explains?), ELLIPSIS (what "
            "unstated content does γάρ imply?), and the POSTPOSITIVE constraint "
            "(γάρ can never open a sentence, a genuine word-order rule with no "
            "equivalent elsewhere in this database). If this entry proves the "
            "Sense/Construction model can flex this far without breaking, that is "
            "real evidence the schema is sound; if it strains visibly, that is "
            "equally valuable information."
        ),
    )
    print(f"Lemma created: {lemma_id}")

    senses = {}

    senses["causal"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Causal/explanatory (core function) -- 'for'",
        primary_arabic_definition="فَـ (السببية)، لأنّ",
        nuance_context=(
            "The basic, most frequent function: γάρ introduces the reason or cause "
            "for the statement immediately preceding it -- τῷ γὰρ ἐπὶ φρεσὶ θῆκε "
            "θεὰ λευκώλενος Ἥρη, 'for the white-armed goddess Hera put it in his "
            "mind' (Iliad 1.56). This is the function every other use in this "
            "entry radiates from or departs from."
        ),
        literal_vs_contextual=(
            "The default, unmarked reading -- assume this function first whenever "
            "γάρ appears without any of the special discourse conditions "
            "(ellipsis, inversion, a question, a wish) documented in the other "
            "senses below."
        ),
        synonyms_antonyms="Near-synonym: Latin enim; contrast δέ (mere continuation, no causal claim).",
        author_period_nuance="Universal across every period and genre of Greek from Homer onward.",
        fixed_expression_proverb=None,
        student_note=(
            "This is the safe default translation, 'for' -- reach for the other "
            "senses in this entry only when the plain causal reading genuinely "
            "doesn't fit the context."
        ),
    )

    senses["anticipatory"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Anticipatory/inverted -- 'since, as' (γάρ-clause precedes what it explains)",
        primary_arabic_definition="بما أنّ، إذ",
        nuance_context=(
            "Here the γάρ-clause comes FIRST, and the clause it explains follows "
            "-- the logical order is reversed from S1: πολλοὶ γὰρ τεθνᾶσιν "
            "Ἀχαιοί... τῷ σε χρὴ πόλεμον παῦσαι, 'since many Achaeans have died... "
            "you must stop the war' (Iliad 7.328). The reason precedes its "
            "consequence rather than following it."
        ),
        literal_vs_contextual=(
            "A genuine reordering of the same causal relationship (S1), not a "
            "different logical connection -- 'X, for Y' and 'since Y, X' state the "
            "identical relationship in opposite clause order, which matters for "
            "translation but not for the underlying logic."
        ),
        synonyms_antonyms=None,
        author_period_nuance=(
            "Especially frequent in Homer and in emotionally urgent direct "
            "address (commands, warnings) across all periods -- the reason-first "
            "ordering suits contexts where the speaker wants to justify an "
            "instruction before giving it."
        ),
        fixed_expression_proverb=None,
        student_note=(
            "If γάρ opens a clause that's immediately followed by an imperative "
            "or a strong directive, check whether the γάρ-clause is actually "
            "explaining what comes AFTER it, not before -- translate 'since/as', "
            "not 'for'."
        ),
    )

    senses["elliptical"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Elliptical yes/no -- γάρ implies an unstated affirmation or denial",
        primary_arabic_definition="نعم... لأنّ / لا... لأنّ (يفترض جوابًا ضمنيًا)",
        nuance_context=(
            "In answers to a question or challenge, γάρ can give the REASON for an "
            "implicit yes or no that is never actually stated: Creon: 'And you "
            "dared to transgress these laws?' Antigone: οὐ γάρ τί μοι Ζεὺς ἦν ὁ "
            "κηρύξας τάδε, literally 'for it was not Zeus who proclaimed these "
            "things to me' -- meaning '[No], for...' The negative answer itself is "
            "never spoken; γάρ alone signals that a reason for an implied answer "
            "is being given (Sophocles, Antigone 450)."
        ),
        literal_vs_contextual=(
            "A genuinely different discourse function from S1/S2: γάρ here is not "
            "explaining a stated proposition but standing in for an entire omitted "
            "clause (the yes or no itself), which the hearer must reconstruct from "
            "context. CRITICAL: Arabic has no equivalent structure -- a natural "
            "translation must make the implicit yes/no explicit, since Arabic "
            "connectives don't carry this ellipsis the way Greek γάρ does."
        ),
        synonyms_antonyms=None,
        author_period_nuance=(
            "Especially frequent in tragic dialogue (stichomythia) and Platonic "
            "dialogue, where rapid question-and-answer exchanges favor this "
            "compressed form."
        ),
        fixed_expression_proverb="ἔστι γὰρ οὕτω -- '[yes], for so it is' (a fixed formula of assent).",
        student_note=(
            "If a γάρ-clause seems to answer a question without any visible "
            "yes/no, mentally supply one before translating -- the reason is "
            "carrying an implicit answer, not standing alone."
        ),
    )

    senses["epexegetic"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Epexegetic -- introduces proof, example, or promised narration",
        primary_arabic_definition="وهذا دليل ذلك، فعلى سبيل المثال",
        nuance_context=(
            "γάρ regularly opens supporting evidence or a promised narrative "
            "after a formulaic lead-in phrase: τεκμήριον δέ... [γάρ clause], "
            "'and here is the proof: for...' (Thucydides 1.8, 2.39, a "
            "characteristic historiographical pattern); or introduces a narration "
            "already announced: ἔχει γὰρ [ἡ χώρα] πεδία κάλλιστα, 'for [the "
            "country] has the most beautiful plains' following λεκτέα ἃ γιγνώσκω, "
            "'I must relate what I know' (Xenophon, Anabasis 5.6.6)."
        ),
        literal_vs_contextual=(
            "A rhetorical/structural specialization of S1: the causal-explanatory "
            "function is redirected specifically toward introducing SUPPORTING "
            "MATERIAL (evidence, narration) rather than explaining an immediately "
            "preceding claim."
        ),
        synonyms_antonyms=None,
        author_period_nuance=(
            "A hallmark of Thucydidean and forensic-oratorical argumentation "
            "structure (Demosthenes, Lysias) -- the τεκμήριον/σημεῖον/μαρτύριον "
            "δέ...γάρ pattern is essentially a technical rhetorical device for "
            "marking 'here comes the evidence.'"
        ),
        fixed_expression_proverb=(
            "τεκμήριον δέ (...γάρ) -- 'and here is the proof (for...)'; μαρτύριον "
            "δέ, σημεῖον δέ -- the same pattern with near-synonymous lead-ins."
        ),
        student_note=(
            "τεκμήριον/σημεῖον/μαρτύριον δέ immediately followed by a γάρ-clause "
            "is a recognizable rhetorical formula -- expect concrete supporting "
            "evidence for the argument just made, not a fresh causal explanation."
        ),
    )

    senses["interrogative"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Interrogative -- marks surprise or incredulity in abrupt questions",
        primary_arabic_definition="فكيف إذن؟ (بنبرة استغراب)",
        nuance_context=(
            "In abrupt questions, γάρ conveys surprise, incredulity, or "
            "indignation rather than requesting a causal explanation: τίς γάρ σε "
            "θεῶν ἐμοὶ ἄγγελον ἧκεν; 'Why, which of the gods sent you to me?' "
            "(Iliad 18.182); πατροκτονοῦσα γὰρ ξυνοικήσεις ἐμοί; 'What, will you "
            "live with me after killing your father?' (Aeschylus, Choephoroi "
            "909)."
        ),
        literal_vs_contextual=(
            "Structurally derived from S1 (the question implicitly presupposes an "
            "unstated prior claim the speaker reacts to), but functionally "
            "distinct: the emotional register (surprise, indignation) is the "
            "primary content, not a causal link between two stated propositions."
        ),
        synonyms_antonyms="Near-synonym: the fixed phrase τί γάρ; in its interrogative (not idiomatic-confirmation) use.",
        author_period_nuance="Frequent in tragic dialogue and Platonic dialogue's more emotionally charged exchanges.",
        fixed_expression_proverb=None,
        student_note=(
            "γάρ opening a question with no preceding statement it could logically "
            "explain signals surprise/incredulity -- translate 'why...?' or "
            "'what...?' rather than searching for a missing causal antecedent."
        ),
    )

    senses["wish"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Wish-strengthening -- εἰ/αἴ γάρ + optative, 'would that...!'",
        primary_arabic_definition="يا ليت",
        nuance_context=(
            "εἰ γάρ or (in Homer) αἲ γάρ, followed by the optative mood, forms a "
            "fixed idiom expressing an intense wish: κακῶς γὰρ ἐξόλοιο, 'may you "
            "perish miserably!' (Euripides, Cyclops 261); εἰ γὰρ ὑπ' Ἰλίῳ... "
            "κατηναρίσθης, 'if only you had died beneath Troy!' (Aeschylus, "
            "Choephoroi 345)."
        ),
        literal_vs_contextual=(
            "A fully idiomatic construction rather than a live causal claim -- "
            "εἰ/αἴ γάρ has become fused into a single wish-marking unit, "
            "functionally equivalent to a dedicated particle even though it's "
            "built from 'if' plus 'for.'"
        ),
        synonyms_antonyms="Near-synonym: εἴθε (a dedicated wish-particle with no γάρ).",
        author_period_nuance=(
            "Attested from Homer (αἴ γάρ) through Attic tragedy (εἰ γάρ / εἴθε "
            "γάρ) without significant change in function."
        ),
        fixed_expression_proverb="εἰ γάρ / αἲ γάρ + optative -- 'would that! O that!'",
        student_note=(
            "εἰ or αἴ immediately followed by γάρ and an optative verb is almost "
            "always this fixed wish-idiom -- translate the whole unit as 'would "
            "that...!' or 'if only...!', not as a conditional 'if, for...'"
        ),
    )

    senses["ti_gar"] = add_sense(
        conn, lemma_id=lemma_id,
        sense_label="Fixed idiom τί γάρ; -- 'of course, what else?' (rhetorical confirmation)",
        primary_arabic_definition="بالطبع! وما العجب في ذلك؟",
        nuance_context=(
            "τί γάρ; as a fixed elliptical phrase (with 'else' implied) functions "
            "as an emphatic rhetorical confirmation rather than a genuine "
            "question: ἆρ' οὐ πάντα... διήγησις οὖσα τυγχάνει;—τί γάρ, ἔφη, "
            "ἄλλο; 'Is not the whole thing narrative? — Of course, what else "
            "[would it be]?' (Plato, Republic 392d). Related fixed forms: πῶς "
            "γὰρ οὔ; 'of course!' (literally 'how not?'), reinforcing an "
            "affirmative rather than requesting explanation."
        ),
        literal_vs_contextual=(
            "A fully grammaticalized idiom, not a live compositional question -- "
            "the phrase's rhetorical force ('naturally, obviously') has become "
            "detached from any literal interrogative reading."
        ),
        synonyms_antonyms=None,
        author_period_nuance=(
            "Extremely frequent in Platonic dialogue as a stock affirmative "
            "response from an interlocutor, and in Attic tragedy/oratory as a "
            "rhetorical confirmation device."
        ),
        fixed_expression_proverb="τί γάρ; -- 'of course, what else?'; πῶς γὰρ οὔ; -- 'of course! (how not?)'",
        student_note=(
            "τί γάρ; as a one- or two-word response (not a real question seeking "
            "information) is stock Platonic-dialogue shorthand for enthusiastic "
            "agreement -- translate 'of course' or 'naturally', not literally "
            "'what, for?'"
        ),
    )

    print(f"Senses created: {list(senses.values())}")

    # -- Constructions: no case government anywhere in this entry -----------
    c_postpositive = add_construction(
        conn, sense_id=senses["causal"],
        construction_governance=(
            "γάρ is POSTPOSITIVE: it regularly stands as the second word of its "
            "clause (never the first), and can shift to third, fourth, or "
            "(rarely, in comedy) even later position when the preceding words "
            "form a tightly bound unit -- ὁ μὲν γὰρ... (Sophocles, Ajax 764); "
            "τὸ κατ' ἀξίαν γὰρ... (Aristotle, Nicomachean Ethics 1163b11)."
        ),
        required_case="N/A -- γάρ is indeclinable, no case is governed or assigned.",
        case_why_not_another=(
            "This is a pure WORD-ORDER constraint, not a case phenomenon -- the "
            "first genuinely non-case-based Construction category this database "
            "has documented. γάρ's postpositive status means it structurally "
            "cannot open a sentence, a positional rule as fixed and non-negotiable "
            "as any case requirement documented elsewhere in this database, just "
            "operating in a completely different grammatical dimension (linear "
            "position, not morphological case)."
        ),
        syntactic_pitfall=(
            "Students scanning for sentence boundaries should never expect a "
            "sentence to begin with γάρ -- if it appears to, the actual sentence "
            "boundary is one or more words earlier than assumed. Recognizing "
            "postpositive particles (γάρ, δέ, τε, οὖν) is itself a basic decoding "
            "skill for locating real clause boundaries in Greek prose."
        ),
        morphology="Indeclinable; no case, number, gender, tense, or mood forms exist.",
        syntax_role="Connective particle, structurally required to follow at least one word of its own clause.",
        morphological_change=None,
        pattern_category="SINGLETON: Postpositive Word-Order Constraint",
    )

    c_inverted = add_construction(
        conn, sense_id=senses["anticipatory"],
        construction_governance=(
            "πολλοὶ γὰρ τεθνᾶσιν Ἀχαιοί... τῷ σε χρὴ πόλεμον παῦσαι (Iliad "
            "7.328) -- the γάρ-clause stands first, with the main clause that it "
            "logically explains following, often resumed by a correlative "
            "adverb/pronoun (τῷ, 'therefore, on that account')."
        ),
        required_case="N/A",
        case_why_not_another=(
            "Again a discourse-structural point, not a case one: the resumptive "
            "τῷ in the main clause functions similarly to how a resumptive "
            "pronoun works after a fronted relative or conditional clause in "
            "English ('since many have died -- for THAT reason, you must...') -- "
            "marking that the preceding γάρ-clause is being picked back up as the "
            "grounds for what follows."
        ),
        syntactic_pitfall=(
            "Students should watch for a resumptive demonstrative/correlative "
            "(τῷ, τοῦτο, etc.) in the clause following a γάρ-clause -- its "
            "presence confirms the inverted-explanation reading (S2) over the "
            "default forward-explaining reading (S1)."
        ),
        morphology=None,
        syntax_role="The γάρ-clause functions as a fronted causal/grounds clause for what follows.",
        morphological_change=None,
        pattern_category="SINGLETON: Anticipatory Clause-Fronting",
    )

    c_elliptical = add_construction(
        conn, sense_id=senses["elliptical"],
        construction_governance=(
            "οὐ γάρ τί μοι Ζεὺς ἦν ὁ κηρύξας τάδε (Sophocles, Antigone 450) -- "
            "γάρ opens a clause giving a reason, with the proposition it's "
            "actually confirming or denying (here, an implicit 'No') left "
            "entirely unstated; the related compound ἀλλὰ γάρ works the same "
            "way, with an entire clause understood between ἀλλά and γάρ (ἀλλὰ "
            "γὰρ ἥκουσ' αἵδ' ἐπὶ πρᾶγος πικρόν, 'but [enough of that -- ] for "
            "these women have come on a bitter errand', Aeschylus, Seven "
            "Against Thebes 861)."
        ),
        required_case="N/A",
        case_why_not_another=(
            "The construction's whole content is what's OMITTED, not any case "
            "relationship -- ἀλλὰ γάρ specifically requires the reader to supply "
            "an entire suppressed clause between the two particles ('but [no, "
            "stop, say no more] -- for...'), a genuinely different kind of "
            "grammatical gap than anything case-based documented elsewhere."
        ),
        syntactic_pitfall=(
            "Translating γάρ here as simple 'for' without recognizing the "
            "implicit yes/no or suppressed clause produces a text that sounds "
            "like it's missing its logical antecedent -- because, in the "
            "Greek itself, it is; the reader is expected to supply it from "
            "context, exactly as with English 'well, because...' answering an "
            "unstated 'no.'"
        ),
        morphology=None,
        syntax_role="Introduces a reason for an implicit, contextually-recoverable proposition.",
        morphological_change=None,
        pattern_category="SINGLETON: Elliptical Antecedent (Implicit Yes/No)",
    )

    c_epexegetic = add_construction(
        conn, sense_id=senses["epexegetic"],
        construction_governance=(
            "τεκμήριον δέ· Δήλου γὰρ καθαιρομένης... (Thucydides 1.8) -- a "
            "formulaic lead-in noun phrase (τεκμήριον δέ, 'and here is the "
            "proof') immediately followed by a γάρ-clause supplying the "
            "concrete supporting evidence."
        ),
        required_case="N/A",
        case_why_not_another=(
            "A fixed two-part rhetorical formula, not a case-governed "
            "construction: the lead-in phrase (in the nominative, as a bare "
            "noun-plus-δέ announcement) and the following γάρ-clause together "
            "form a recognizable argumentative unit used across historiography "
            "and oratory."
        ),
        syntactic_pitfall=(
            "Students should recognize τεκμήριον/σημεῖον/μαρτύριον δέ as a "
            "signal that concrete evidence is about to follow via a γάρ-clause "
            "-- treating the δέ-phrase and the γάρ-clause as two independent, "
            "unrelated statements misses the formula's argumentative structure."
        ),
        morphology=None,
        syntax_role="γάρ-clause functions as the substantiating evidence for the preceding lead-in phrase.",
        morphological_change=None,
        pattern_category="SINGLETON: Epexegetic Evidence-Formula",
    )

    c_wish = add_construction(
        conn, sense_id=senses["wish"],
        construction_governance=(
            "εἰ γὰρ ὑπ' Ἰλίῳ... κατηναρίσθης (Aeschylus, Choephoroi 345) -- "
            "εἰ/αἴ + γάρ + optative mood verb, forming a fixed wish-construction."
        ),
        required_case="N/A -- the verb stands in the optative MOOD, not any case.",
        case_why_not_another=(
            "The construction's defining feature is verbal MOOD (optative), the "
            "same category of non-case grammatical marking already documented "
            "for εἰμί's impersonal-modal and periphrastic constructions "
            "elsewhere in this database -- γάρ here contributes emphatic force "
            "to the wish rather than governing anything grammatically itself."
        ),
        syntactic_pitfall=(
            "Students should recognize εἰ/αἴ γάρ + optative as a fixed unit "
            "meaning 'would that!' rather than parsing εἰ as an ordinary "
            "conditional 'if' -- the combination with γάρ and the optative "
            "together signal the wish-reading specifically."
        ),
        morphology="The following verb stands in the optative mood.",
        syntax_role="γάρ intensifies the wish expressed by εἰ/αἴ + optative.",
        morphological_change=None,
        pattern_category="SINGLETON: Wish-Intensifying Particle Combination",
    )

    print(f"Constructions created: {[c_postpositive, c_inverted, c_elliptical, c_epexegetic, c_wish]}")

    # -- Citations -------------------------------------------------------------
    add_citation(
        conn, construction_id=c_postpositive,
        example_citation=(
            "Sophocles, Ajax 764 -- ὁ μὲν γὰρ..., with γάρ standing third in its "
            "clause because ὁ μέν forms a tightly bound preceding unit; contrast "
            "the ordinary second-position pattern found throughout Homer and "
            "Attic prose."
        ),
        why_this_word=(
            "Sophocles' word order here demonstrates the postpositive rule's real "
            "flexibility: γάρ is not rigidly the SECOND word, but rather cannot "
            "be the FIRST -- a subtly different and more accurate statement of "
            "the constraint than 'always second.'"
        ),
        translation_choices="لأنّ / فَـ -- position in the Arabic sentence is unconstrained, unlike Greek's postpositive rule, since Arabic has no equivalent word-order restriction.",
        source_reliability="Sophocles, Ajax, ed. Lloyd-Jones/Wilson (OCT).",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ's discussion of γάρ's position).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_inverted,
        example_citation=(
            "Iliad 7.328 -- Ἀτρεΐδη, πολλοὶ γὰρ τεθνᾶσιν Ἀχαιοί... τῷ σε χρὴ "
            "πόλεμον παῦσαι, 'Son of Atreus, since many Achaeans have died... "
            "you must stop the war.'"
        ),
        why_this_word=(
            "The speaker (Nestor) front-loads the justification before the "
            "directive to make the coming command land with full rhetorical "
            "force -- by the time 'you must stop the war' arrives, its "
            "justification is already established, making the imperative harder "
            "to resist."
        ),
        translation_choices="بما أنّ كثيرين من الآخيين قد ماتوا... فيجب عليك أن توقف الحرب -- natural Arabic preserving the reason-first ordering.",
        source_reliability="Homer, Iliad, ed. West (Teubner) or Monro/Allen (OCT), Book 7, line 328.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, Pape, DGE all cite this exact passage).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_elliptical,
        example_citation=(
            "Sophocles, Antigone 450 -- Creon: καὶ δῆτ' ἐτόλμας τούσδ' "
            "ὑπερβαίνειν νόμους; ('And you dared to transgress these laws?') "
            "Antigone: οὐ γάρ τί μοι Ζεὺς ἦν ὁ κηρύξας τάδε ('[No,] for it was "
            "not Zeus who proclaimed these to me')."
        ),
        why_this_word=(
            "Antigone's γάρ-response lets her answer with a justification "
            "rather than a bare denial -- rhetorically stronger than a simple "
            "'no' would be, since it immediately supplies her reasoning "
            "(divine law outranks Creon's decree) without Creon needing to ask "
            "for it separately."
        ),
        translation_choices="لا، لأنّ زيوس لم يكن من أعلن هذه الأشياء -- Arabic must supply the explicit 'no' the Greek leaves implicit in γάρ alone.",
        source_reliability="Sophocles, Antigone, ed. Lloyd-Jones/Wilson (OCT), line 450.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, Pape).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_epexegetic,
        example_citation=(
            "Thucydides 1.8 -- τεκμήριον δέ· Δήλου γὰρ καθαιρομένης..., 'And "
            "here is the proof: for when Delos was purified...'"
        ),
        why_this_word=(
            "Thucydides' entire archaeological-methodological argument in Book "
            "1 depends on this formula -- announcing a claim, then substantiating "
            "it with concrete physical evidence (grave excavations at Delos), "
            "a rhetorical structure that itself models the evidentiary rigor "
            "he claims for his historical method."
        ),
        translation_choices="وهذا دليل ذلك: فعندما طُهّرت جزيرة ديلوس... -- natural Arabic preserving the evidence-introducing structure.",
        source_reliability="Thucydides, Historiae, ed. Jones & Powell (OCT), Book 1, chapter 8.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (LSJ, DGE).",
        verification_status="verified",
    )

    add_citation(
        conn, construction_id=c_wish,
        example_citation=(
            "Aeschylus, Choephoroi 345 -- εἰ γὰρ ὑπ' Ἰλίῳ... πάτερ, "
            "κατηναρίσθης, 'if only you had died, father, beneath Troy!'"
        ),
        why_this_word=(
            "The chorus's wish that Agamemnon had died in battle (rather than "
            "murdered at home) is the play's central grievance compressed into "
            "one line -- the fixed εἰ γάρ + optative idiom lets the intensity of "
            "that grief and outrage land in a single, grammatically recognizable "
            "unit."
        ),
        translation_choices="يا ليتك مت تحت طروادة يا أبي! -- يا ليت is the natural, idiomatically exact Arabic wish-particle for this construction.",
        source_reliability="Aeschylus, Choephoroi, ed. Sommerstein (Loeb) or West (Teubner), line 345.",
        verification_notes="CONFIRMED -- directly given in the source lexicon material (Pape).",
        verification_status="verified",
    )

    # -- Morph_Index -------------------------------------------------------------
    # gamma is indeclinable -- only the bare form and its rare metrical-length
    # variant are worth indexing, unlike every prior (inflected) word.
    add_morph_form(conn, inflected_form="γάρ", lemma_id=lemma_id, case_=None, number=None,
                    notes="The only form -- indeclinable particle, no paradigm.")

    conn.close()
    print("\nDone. Lemma ID:", lemma_id)


if __name__ == "__main__":
    main()
