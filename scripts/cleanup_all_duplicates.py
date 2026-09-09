"""
cleanup_all_duplicates.py — scans the ENTIRE Lemmas table for any word
that appears more than once, and removes the extras automatically,
keeping the lowest (oldest) ID for each. No command-line arguments,
no typing Greek text into PowerShell -- avoids the Unicode-argument
mismatch that made dedupe_word.py unreliable on Windows.

Usage: python scripts/cleanup_all_duplicates.py
"""
import sqlite3
from pathlib import Path

DB_PATH = str(Path(__file__).parent.parent / "classical.db")


def main():
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON;")

    dupes = conn.execute("""
        SELECT Term_Original, COUNT(*) as c
        FROM Lemmas
        GROUP BY Term_Original
        HAVING c > 1
    """).fetchall()

    if not dupes:
        print("No duplicate lemmas found. Nothing to do.")
        conn.close()
        return

    print(f"Found {len(dupes)} word(s) with duplicates:\n")
    plan = []
    for term, count in dupes:
        ids = [r[0] for r in conn.execute(
            "SELECT Lemma_ID FROM Lemmas WHERE Term_Original = ? ORDER BY Lemma_ID",
            (term,),
        ).fetchall()]
        keep, remove = ids[0], ids[1:]
        plan.append((term, keep, remove))
        # Print using repr() so the terminal encoding can't mangle the Greek in the output
        print(f"  {term!r}: {count} rows -> keep {keep}, remove {remove}")

    print()
    answer = input("Proceed with cleanup for ALL of the above? [y/N] ").strip().lower()
    if answer != "y":
        print("Cancelled -- nothing changed.")
        conn.close()
        return

    for term, keep, remove in plan:
        for lemma_id in remove:
            conn.execute("DELETE FROM Morph_Index WHERE Lemma_ID = ?", (lemma_id,))
            conn.execute("DELETE FROM Lemmas WHERE Lemma_ID = ?", (lemma_id,))
    conn.commit()

    remaining_dupes = conn.execute("""
        SELECT Term_Original, COUNT(*) as c FROM Lemmas GROUP BY Term_Original HAVING c > 1
    """).fetchall()
    print()
    print("Remaining duplicates after cleanup:", remaining_dupes if remaining_dupes else "NONE -- all clean.")

    total = conn.execute("SELECT COUNT(*) FROM Lemmas").fetchone()[0]
    print("Total lemmas now:", total)
    conn.close()


if __name__ == "__main__":
    main()
