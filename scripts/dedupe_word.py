"""
dedupe_word.py — finds duplicate Lemma rows for a given Greek word, keeps
the one with the LOWEST ID (the original), and safely removes any others
(including their Senses/Constructions/Citations via cascade, and their
Morph_Index rows manually, since that FK has no cascade).

Usage: python scripts/dedupe_word.py ὕβρις
Shows what it's about to do and asks for confirmation before deleting
anything.
"""
import sqlite3
import sys
from pathlib import Path

DB_PATH = str(Path(__file__).parent.parent / "classical.db")


def main():
    if len(sys.argv) != 2:
        print("Usage: python scripts/dedupe_word.py <greek word>")
        return
    term = sys.argv[1]
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON;")

    rows = conn.execute(
        "SELECT Lemma_ID FROM Lemmas WHERE Term_Original = ? ORDER BY Lemma_ID",
        (term,),
    ).fetchall()
    ids = [r[0] for r in rows]

    if len(ids) <= 1:
        print(f"'{term}': {len(ids)} row(s) found -- nothing to do.")
        conn.close()
        return

    keep = ids[0]
    remove = ids[1:]
    print(f"'{term}': found {len(ids)} rows -> {ids}")
    print(f"Will KEEP:   {keep} (the oldest / first-created)")
    print(f"Will REMOVE: {remove}")

    answer = input("Proceed? [y/N] ").strip().lower()
    if answer != "y":
        print("Cancelled -- nothing changed.")
        conn.close()
        return

    for lemma_id in remove:
        conn.execute("DELETE FROM Morph_Index WHERE Lemma_ID = ?", (lemma_id,))
        conn.execute("DELETE FROM Lemmas WHERE Lemma_ID = ?", (lemma_id,))  # cascades down
    conn.commit()

    remaining = conn.execute(
        "SELECT Lemma_ID, Term_Original FROM Lemmas WHERE Term_Original = ?",
        (term,),
    ).fetchall()
    print("After cleanup:", remaining)
    conn.close()


if __name__ == "__main__":
    main()
