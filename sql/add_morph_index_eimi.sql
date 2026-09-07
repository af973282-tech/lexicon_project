-- Morph_Index additions for εἰμί (L007) — run AFTER eimi_full_detail.sql,
-- after Morph_Index already exists. Representative core forms only, given
-- this verb's exceptional dialectal fragmentation (see Lemma Root_Lineage) --
-- a full paradigm across all dialects/periods is impractical to seed by hand
-- and better handled later via Perseus Morpheus (see the app architecture doc).

INSERT INTO Morph_Index (Inflected_Form, Lemma_ID, Case_, Number, Notes) VALUES
('εἰμί',  'L007', NULL, 'singular', '1st person singular present indicative, citation/dictionary form.'),
('ἐστί',  'L007', NULL, 'singular', '3rd person singular present indicative -- the copula and existential form, from C038-C040.'),
('εἰσί',  'L007', NULL, 'plural',   '3rd person plural present indicative -- from C041 (εἰσὶν οἵ idiom).'),
('ἦν',    'L007', NULL, 'singular', '3rd person singular imperfect indicative -- from C040 (periphrastic pluperfect).'),
('ὤν',    'L007', NULL, 'singular', 'Present active participle, masculine nominative singular -- substantivized in S051 (τὸ ὄν, ὁ ὤν).'),
('ὄντι',  'L007', NULL, 'singular', 'Present active participle, dative singular -- from C039 (τῷ ὄντι idiom).');
