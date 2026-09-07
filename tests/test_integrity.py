"""
test_integrity.py — regression test suite for the Classical Language Database.

Run with: python3 -m unittest tests.test_integrity -v
(from the lexicon_project/ directory)

Covers exactly the checks that were previously done by hand, ad hoc, once
per word: row counts, foreign-key integrity, duplicate detection, orphan
detection, construction->lemma integrity, sense->lemma integrity, and
pattern-category validity. This turns "rebuild a throwaway test .db and
eyeball the printed numbers" into something that runs the same way every
time and fails loudly if anything regresses.
"""
import sqlite3
import unittest
from pathlib import Path

DB_PATH = Path(__file__).parent.parent / "classical.db"

VALID_VERIFICATION_STATUSES = {"verified", "partially_verified", "unverified", "incorrect"}


class TestDatabaseIntegrity(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.conn = sqlite3.connect(DB_PATH)
        cls.conn.execute("PRAGMA foreign_keys = ON;")

    @classmethod
    def tearDownClass(cls):
        cls.conn.close()

    # -- Foreign key integrity --------------------------------------------
    def test_no_foreign_key_violations(self):
        violations = self.conn.execute("PRAGMA foreign_key_check;").fetchall()
        self.assertEqual(violations, [], f"Foreign key violations found: {violations}")

    # -- Orphan detection (belt-and-suspenders beyond FK check) -----------
    def test_no_orphan_senses(self):
        rows = self.conn.execute(
            "SELECT Sense_ID FROM Senses WHERE Lemma_ID NOT IN (SELECT Lemma_ID FROM Lemmas)"
        ).fetchall()
        self.assertEqual(rows, [], f"Orphan Senses (no matching Lemma): {rows}")

    def test_no_orphan_constructions(self):
        rows = self.conn.execute(
            "SELECT Construction_ID FROM Constructions WHERE Sense_ID NOT IN (SELECT Sense_ID FROM Senses)"
        ).fetchall()
        self.assertEqual(rows, [], f"Orphan Constructions (no matching Sense): {rows}")

    def test_no_orphan_citations(self):
        rows = self.conn.execute(
            "SELECT Citation_ID FROM Citations WHERE Construction_ID NOT IN (SELECT Construction_ID FROM Constructions)"
        ).fetchall()
        self.assertEqual(rows, [], f"Orphan Citations (no matching Construction): {rows}")

    def test_no_orphan_morph_index(self):
        rows = self.conn.execute(
            "SELECT Form_ID FROM Morph_Index WHERE Lemma_ID NOT IN (SELECT Lemma_ID FROM Lemmas)"
        ).fetchall()
        self.assertEqual(rows, [], f"Orphan Morph_Index rows (no matching Lemma): {rows}")

    # -- Duplicate detection ------------------------------------------------
    def test_no_duplicate_primary_keys(self):
        for table, id_col in [("Lemmas", "Lemma_ID"), ("Senses", "Sense_ID"),
                               ("Constructions", "Construction_ID"), ("Citations", "Citation_ID")]:
            rows = self.conn.execute(
                f"SELECT {id_col}, COUNT(*) c FROM {table} GROUP BY {id_col} HAVING c > 1"
            ).fetchall()
            self.assertEqual(rows, [], f"Duplicate {id_col} in {table}: {rows}")

    def test_no_duplicate_morph_forms(self):
        rows = self.conn.execute(
            "SELECT Inflected_Form, Lemma_ID, COUNT(*) c FROM Morph_Index "
            "GROUP BY Inflected_Form, Lemma_ID HAVING c > 1"
        ).fetchall()
        self.assertEqual(rows, [], f"Duplicate Morph_Index (form, lemma) pairs: {rows}")

    # -- Every Sense/Construction/Citation traces to a real Lemma ---------
    def test_every_sense_traces_to_a_lemma(self):
        rows = self.conn.execute("""
            SELECT S.Sense_ID FROM Senses S
            LEFT JOIN Lemmas L ON S.Lemma_ID = L.Lemma_ID
            WHERE L.Lemma_ID IS NULL
        """).fetchall()
        self.assertEqual(rows, [])

    def test_every_construction_traces_to_a_lemma(self):
        rows = self.conn.execute("""
            SELECT C.Construction_ID FROM Constructions C
            JOIN Senses S ON C.Sense_ID = S.Sense_ID
            LEFT JOIN Lemmas L ON S.Lemma_ID = L.Lemma_ID
            WHERE L.Lemma_ID IS NULL
        """).fetchall()
        self.assertEqual(rows, [])

    # -- Pattern_Category validity -----------------------------------------
    def test_all_constructions_have_pattern_category(self):
        rows = self.conn.execute(
            "SELECT Construction_ID FROM Constructions WHERE Pattern_Category IS NULL"
        ).fetchall()
        self.assertEqual(rows, [], f"Constructions missing Pattern_Category (caused a real bug once -- C030): {rows}")

    # -- Citation verification status validity -----------------------------
    def test_verification_status_values_are_valid(self):
        rows = self.conn.execute("SELECT DISTINCT Verification_Status FROM Citations").fetchall()
        statuses = {r[0] for r in rows}
        self.assertTrue(
            statuses.issubset(VALID_VERIFICATION_STATUSES),
            f"Invalid Verification_Status values found: {statuses - VALID_VERIFICATION_STATUSES}",
        )

    # -- Required-field completeness ----------------------------------------
    def test_no_null_required_fields(self):
        checks = [
            ("Lemmas", "Term_Original"), ("Lemmas", "Language"),
            ("Senses", "Sense_Label"),
            ("Constructions", "Construction_Governance"),
            ("Citations", "Example_Citation"),
        ]
        for table, col in checks:
            rows = self.conn.execute(f"SELECT rowid FROM {table} WHERE {col} IS NULL").fetchall()
            self.assertEqual(rows, [], f"NULL {col} in {table}: {rows}")

    # -- Row-count sanity (updates as the lexicon grows -- floor, not exact) --
    def test_minimum_row_counts(self):
        counts = {t: self.conn.execute(f"SELECT COUNT(*) FROM {t}").fetchone()[0]
                   for t in ("Lemmas", "Senses", "Constructions", "Citations", "Morph_Index")}
        self.assertGreaterEqual(counts["Lemmas"], 9)
        self.assertGreaterEqual(counts["Senses"], 72)
        self.assertGreaterEqual(counts["Constructions"], 52)
        self.assertGreaterEqual(counts["Citations"], 53)
        self.assertGreaterEqual(counts["Morph_Index"], 39)


if __name__ == "__main__":
    unittest.main()
