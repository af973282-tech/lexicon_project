"""
check_word.py — quick lookup to confirm a word exists exactly once in the
database, without fighting PowerShell's Unicode/quoting handling.

Usage: python scripts/check_word.py ὕβρις
"""
import sqlite3
import sys
from pathlib import Path

DB_PATH = str(Path(__file__).parent.parent / "classical.db")


def main():
    if len(sys.argv) != 2:
        print("Usage: python scripts/check_word.py <greek word>")
        return
    term = sys.argv[1]
    conn = sqlite3.connect(DB_PATH)
    rows = conn.execute(
        "SELECT Lemma_ID, Term_Original FROM Lemmas WHERE Term_Original = ?",
        (term,),
    ).fetchall()
    conn.close()
    print(f"Found {len(rows)} row(s) for '{term}':")
    for r in rows:
        print(" -", r)


if __name__ == "__main__":
    main()
