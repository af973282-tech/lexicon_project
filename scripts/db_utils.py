"""
db_utils.py — canonical, parameterized access layer for the Classical
Language Database. Replaces hand-built SQL strings with real parameterized
queries, and replaces manually-tracked IDs (which already caused a skipped
ID and an untagged row once) with IDs generated from the database's own
current state.

Usage:
    conn = get_connection("classical.db")
    lemma_id = add_lemma(conn, term_original="ὕβρις", language="Ancient Greek", ...)
    sense_id = add_sense(conn, lemma_id=lemma_id, sense_label="...", ...)
    ...
"""
import sqlite3
import re
from pathlib import Path

SCHEMA_PATH = Path(__file__).parent.parent / "sql" / "schema.sql"


def get_connection(db_path: str) -> sqlite3.Connection:
    """Open a connection with foreign keys enforced, schema applied."""
    conn = sqlite3.connect(db_path)
    conn.execute("PRAGMA foreign_keys = ON;")
    conn.executescript(SCHEMA_PATH.read_text(encoding="utf-8"))
    return conn


def _next_id(conn: sqlite3.Connection, table: str, id_col: str, prefix: str) -> str:
    """
    Generate the next sequential ID for a prefix+number style key
    (L003, S041, C042, Cit031, ...) by inspecting the MAX existing
    numeric suffix actually in the table -- not a hardcoded counter
    that can drift out of sync with reality (the exact failure mode
    that produced the skipped C023 and the untagged C030 previously).
    """
    cur = conn.execute(f"SELECT {id_col} FROM {table} WHERE {id_col} LIKE ?", (f"{prefix}%",))
    max_n = 0
    for (val,) in cur.fetchall():
        m = re.match(rf"^{re.escape(prefix)}(\d+)$", val)
        if m:
            max_n = max(max_n, int(m.group(1)))
    width = 3 if prefix in ("L", "S", "C") else 3  # zero-padded to 3 digits minimum
    return f"{prefix}{max_n + 1:0{width}d}"


def add_lemma(conn, *, term_original, language, root_lineage=None, semantic_field=None,
              cross_language_connection=None, modern_resonance=None, classical_concept=None):
    lemma_id = _next_id(conn, "Lemmas", "Lemma_ID", "L")
    conn.execute(
        """INSERT INTO Lemmas
           (Lemma_ID, Term_Original, Language, Root_Lineage, Semantic_Field,
            Cross_Language_Connection, Modern_Resonance, Classical_Concept)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?)""",
        (lemma_id, term_original, language, root_lineage, semantic_field,
         cross_language_connection, modern_resonance, classical_concept),
    )
    conn.commit()
    return lemma_id


def add_sense(conn, *, lemma_id, sense_label, primary_arabic_definition=None,
              nuance_context=None, literal_vs_contextual=None, synonyms_antonyms=None,
              author_period_nuance=None, fixed_expression_proverb=None, student_note=None):
    sense_id = _next_id(conn, "Senses", "Sense_ID", "S")
    conn.execute(
        """INSERT INTO Senses
           (Sense_ID, Lemma_ID, Sense_Label, Primary_Arabic_Definition, Nuance_Context,
            Literal_vs_Contextual, Synonyms_Antonyms, Author_Period_Nuance,
            Fixed_Expression_Proverb, Student_Note)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
        (sense_id, lemma_id, sense_label, primary_arabic_definition, nuance_context,
         literal_vs_contextual, synonyms_antonyms, author_period_nuance,
         fixed_expression_proverb, student_note),
    )
    conn.commit()
    return sense_id


def add_construction(conn, *, sense_id, construction_governance, required_case=None,
                      case_why_not_another=None, syntactic_pitfall=None, morphology=None,
                      syntax_role=None, morphological_change=None, pattern_category=None):
    construction_id = _next_id(conn, "Constructions", "Construction_ID", "C")
    conn.execute(
        """INSERT INTO Constructions
           (Construction_ID, Sense_ID, Construction_Governance, Required_Case,
            Case_Why_Not_Another, Syntactic_Pitfall, Morphology, Syntax_Role,
            Morphological_Change, Pattern_Category)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""",
        (construction_id, sense_id, construction_governance, required_case,
         case_why_not_another, syntactic_pitfall, morphology, syntax_role,
         morphological_change, pattern_category),
    )
    conn.commit()
    return construction_id


def add_citation(conn, *, construction_id, example_citation, why_this_word=None,
                  translation_choices=None, source_reliability=None, verification_notes=None,
                  verification_status="unverified"):
    if verification_status not in ("verified", "partially_verified", "unverified", "incorrect"):
        raise ValueError(f"Invalid verification_status: {verification_status}")
    citation_id = _next_id(conn, "Citations", "Citation_ID", "Cit")
    conn.execute(
        """INSERT INTO Citations
           (Citation_ID, Construction_ID, Example_Citation, Why_This_Word,
            Translation_Choices, Source_Reliability, Verification_Notes, Verification_Status)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?)""",
        (citation_id, construction_id, example_citation, why_this_word,
         translation_choices, source_reliability, verification_notes, verification_status),
    )
    conn.commit()
    return citation_id


def add_morph_form(conn, *, inflected_form, lemma_id, case_=None, number=None, notes=None):
    """Insert-or-ignore semantics via the UNIQUE index -- re-running a seed
    script is now a no-op instead of silently duplicating rows (the exact
    bug that produced 14 duplicate Morph_Index rows earlier in this project)."""
    try:
        conn.execute(
            """INSERT INTO Morph_Index (Inflected_Form, Lemma_ID, Case_, Number, Notes)
               VALUES (?, ?, ?, ?, ?)""",
            (inflected_form, lemma_id, case_, number, notes),
        )
        conn.commit()
        return True
    except sqlite3.IntegrityError:
        return False  # already exists -- expected, not an error
