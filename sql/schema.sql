-- Classical Language Database — Canonical Schema
-- This is the ONE authoritative schema definition. Word data files should
-- no longer repeat CREATE TABLE statements — run this once against a fresh
-- database, then load word data (via scripts/load_words.py) into it.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Lemmas (
    Lemma_ID                  TEXT PRIMARY KEY,
    Term_Original              TEXT NOT NULL,
    Language                   TEXT NOT NULL,
    Root_Lineage                TEXT,
    Semantic_Field              TEXT,
    Cross_Language_Connection   TEXT,
    Modern_Resonance            TEXT,
    Classical_Concept           TEXT
);

CREATE TABLE IF NOT EXISTS Senses (
    Sense_ID                   TEXT PRIMARY KEY,
    Lemma_ID                   TEXT NOT NULL REFERENCES Lemmas(Lemma_ID) ON DELETE CASCADE,
    Sense_Label                 TEXT NOT NULL,
    Primary_Arabic_Definition   TEXT,
    Nuance_Context               TEXT,
    Literal_vs_Contextual        TEXT,
    Synonyms_Antonyms            TEXT,
    Author_Period_Nuance         TEXT,
    Fixed_Expression_Proverb     TEXT,
    Student_Note                 TEXT
);

CREATE TABLE IF NOT EXISTS Constructions (
    Construction_ID             TEXT PRIMARY KEY,
    Sense_ID                    TEXT NOT NULL REFERENCES Senses(Sense_ID) ON DELETE CASCADE,
    Construction_Governance      TEXT NOT NULL,
    Required_Case                TEXT,
    Case_Why_Not_Another         TEXT,
    Syntactic_Pitfall            TEXT,
    Morphology                   TEXT,
    Syntax_Role                  TEXT,
    Morphological_Change         TEXT,
    Pattern_Category             TEXT
);

CREATE TABLE IF NOT EXISTS Citations (
    Citation_ID                 TEXT PRIMARY KEY,
    Construction_ID              TEXT NOT NULL REFERENCES Constructions(Construction_ID) ON DELETE CASCADE,
    Example_Citation              TEXT NOT NULL,
    Why_This_Word                 TEXT,
    Translation_Choices           TEXT,
    Source_Reliability            TEXT,
    Verification_Notes            TEXT,
    Verification_Status           TEXT NOT NULL DEFAULT 'unverified'
        CHECK (Verification_Status IN ('verified', 'partially_verified', 'unverified', 'incorrect'))
);

CREATE TABLE IF NOT EXISTS Morph_Index (
    Form_ID        INTEGER PRIMARY KEY AUTOINCREMENT,
    Inflected_Form TEXT NOT NULL,
    Lemma_ID       TEXT NOT NULL REFERENCES Lemmas(Lemma_ID),
    Case_          TEXT,
    Number         TEXT,
    Notes          TEXT
);

CREATE INDEX IF NOT EXISTS idx_senses_lemma ON Senses(Lemma_ID);
CREATE INDEX IF NOT EXISTS idx_constructions_sense ON Constructions(Sense_ID);
CREATE INDEX IF NOT EXISTS idx_citations_construction ON Citations(Construction_ID);
CREATE INDEX IF NOT EXISTS idx_morph_form ON Morph_Index(Inflected_Form);
CREATE UNIQUE INDEX IF NOT EXISTS idx_morph_unique ON Morph_Index(Inflected_Form, Lemma_ID);
