# Classical Language Database — Project

## Structure
- `sql/schema.sql` — canonical schema (single source of truth for CREATE TABLE)
- `sql/*.sql` — word data files (legacy hand-written; new words should use scripts/db_utils.py instead)
- `scripts/db_utils.py` — parameterized insert layer with automatic ID generation
- `tests/test_integrity.py` — regression test suite (run: `python3 -m unittest tests.test_integrity -v`)

## Building the database from scratch
```python
import sys; sys.path.insert(0, "scripts")
from db_utils import get_connection

conn = get_connection("classical.db")
for f in ["classical_language_database_full_detail.sql", "nomos_full_detail.sql", ...]:
    conn.executescript(open(f"sql/{f}").read())
```

## Adding a new word (word 10+)
Use `db_utils.add_lemma()`, `add_sense()`, `add_construction()`, `add_citation()`,
`add_morph_form()` — NOT hand-written SQL strings. IDs are generated automatically
from the database's current state; quote-escaping is handled by parameterization.

## Citation verification statuses
Every citation has a `Verification_Status`: `verified` | `partially_verified` |
`unverified` | `incorrect`. Existing citations default to `unverified` until
individually reviewed against a primary source.

## Running tests
```
python3 -m unittest tests.test_integrity -v
```
