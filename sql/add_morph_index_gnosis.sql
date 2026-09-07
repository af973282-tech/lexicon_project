-- Morph_Index additions for γνῶσις (L006) — run AFTER gnosis_full_detail.sql,
-- after Morph_Index already exists. Forms pulled directly from Constructions
-- C030-C035 -- nothing invented.

INSERT INTO Morph_Index (Inflected_Form, Lemma_ID, Case_, Number, Notes) VALUES
('γνῶσις',  'L006', 'nominative', 'singular', 'Citation/dictionary form; predicate nominative in C031 (γνῶσις/πρᾶξις contrast).'),
('γνῶσιν',  'L006', 'accusative', 'singular', 'From C035 (τὴν τοῦ σώματος γνῶσιν, objective genitive example).'),
('γνώσεως', 'L006', 'genitive',   'singular', 'From C034 (τῆς ψευδωνύμου γνώσεως, 1 Timothy 6:20).');
