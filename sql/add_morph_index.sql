-- Step 2: run this AFTER logos and nomos are both loaded.
-- Adds the Morph_Index table and seeds it with forms already
-- documented in the Constructions/Fixed_Expression fields you've
-- already written — nothing new is being invented here.

CREATE TABLE IF NOT EXISTS Morph_Index (
    Form_ID        INTEGER PRIMARY KEY AUTOINCREMENT,
    Inflected_Form TEXT NOT NULL,
    Lemma_ID       TEXT NOT NULL REFERENCES Lemmas(Lemma_ID),
    Case_          TEXT,
    Number         TEXT,
    Notes          TEXT
);
CREATE INDEX IF NOT EXISTS idx_morph_form ON Morph_Index(Inflected_Form);

INSERT INTO Morph_Index (Inflected_Form, Lemma_ID, Case_, Number, Notes) VALUES
('λόγος', 'L001', 'nominative', 'singular', 'Citation/dictionary form; appears in S001-S006 headers.'),
('λόγῳ',  'L001', 'dative',     'singular', 'From C001 (λόγῳ μέν... ἔργῳ δέ antithesis).'),
('λόγον', 'L001', 'accusative', 'singular', 'From C002 (ζῷον λόγον ἔχον), C003 (λόγον διδόναι), C005 (κατὰ λόγον).'),
('νόμος', 'L002', 'nominative', 'singular', 'Citation form; also in νόμος πάντων βασιλεύς, νόμος δεσπότης, νόμος ὄρθιος (C011).'),
('νόμον', 'L002', 'accusative', 'singular', 'From C006 (κατὰ νόμον), C007 (παρὰ νόμον), C008 (νόμον τιθέναι/τίθεσθαι).'),
('νόμῳ',  'L002', 'dative',     'singular', 'From C010 (νόμῳ ... φύσει contrast).'),
('νόμου', 'L002', 'genitive',   'singular', 'From S007 fixed expression ὅσον νόμου χάριν.');
