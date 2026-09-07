-- Morph_Index additions for δίκη (L004) — run AFTER dike_full_detail.sql,
-- after Morph_Index already exists. Forms pulled directly from Constructions
-- C018-C022 -- nothing invented.

INSERT INTO Morph_Index (Inflected_Form, Lemma_ID, Case_, Number, Notes) VALUES
('δίκη',  'L004', 'nominative', 'singular', 'Citation/dictionary form; also subject form for personified Δίκη (C019).'),
('δίκην', 'L004', 'accusative', 'singular', 'From C018 (X-δίκην adverbial idiom), C020 (δίκην δικάζειν), C021 (δίκην λαγχάνειν), C022 (δίκην λαμβάνειν).');
