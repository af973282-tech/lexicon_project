-- Morph_Index additions for ψυχή (L003) — run AFTER psyche_full_detail.sql
-- and after Morph_Index already exists (from the earlier logos/nomos step).
-- Forms pulled directly from Constructions C012-C017 — nothing invented.

INSERT INTO Morph_Index (Inflected_Form, Lemma_ID, Case_, Number, Notes) VALUES
('ψυχή',  'L003', 'nominative', 'singular', 'Citation/dictionary form; appears across S012-S021 headers.'),
('ψυχήν', 'L003', 'accusative', 'singular', 'From C012 (τὴν ψυχὴν τιθέναι ὑπέρ..., John 15:13).'),
('ψυχάς', 'L003', 'accusative', 'plural',   'From C013 (Iliad 1.3, πολλὰς ψυχὰς Ἄϊδι προΐαψεν).'),
('ψυχῇ',  'L003', 'dative',     'singular', 'From C014 (ἐν τῇ ψυχῇ, Republic 439d).'),
('ψυχαί', 'L003', 'nominative', 'plural',   'From C016 (ψυχαὶ τρισχίλιαι, Acts 2:41).');
