-- Morph_Index additions for ἀρετή (L005) — run AFTER arete_full_detail.sql,
-- after Morph_Index already exists. Forms pulled directly from Constructions
-- C024-C029 -- nothing invented.

INSERT INTO Morph_Index (Inflected_Form, Lemma_ID, Case_, Number, Notes) VALUES
('ἀρετή',  'L005', 'nominative', 'singular', 'Citation/dictionary form; also subject form for personified Ἀρετή (C029).'),
('ἀρετῆς', 'L005', 'genitive',   'singular', 'From C024 (genitive-of-specification pattern), C026 (ἀρετὴ τῆς ψυχῆς), C027 (honorific decree formula).'),
('ἀρεταί', 'L005', 'nominative', 'plural',   'From C028 (countable-plural "mighty deeds" sense, parallel to ψυχαί).'),
('ἀρετάς', 'L005', 'accusative', 'plural',   'From C028, accusative-plural variant of the same countable "deeds" sense.');
