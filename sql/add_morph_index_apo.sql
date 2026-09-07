-- Morph_Index additions for ἀπό (L008) — run AFTER apo_full_detail.sql,
-- after Morph_Index already exists. As a preposition, ἀπό has no
-- case/number to resolve TO (it isn't inflected the way a noun or verb
-- is) -- these entries exist purely so a student searching one of its
-- surface/dialect variants still finds this lemma. Case_ and Number
-- are left NULL throughout, since neither concept applies here.

INSERT INTO Morph_Index (Inflected_Form, Lemma_ID, Case_, Number, Notes) VALUES
('ἀπό', 'L008', NULL, NULL, 'Citation/dictionary form. Elides to ἀπ'' or ἀφ'' before vowels (rough breathing triggers ἀφ'').'),
('ἀπύ', 'L008', NULL, NULL, 'Aeolic/Thessalian/Arcado-Cypriot dialect variant of ἀπό (see Root_Lineage).'),
('ἀπαί', 'L008', NULL, NULL, 'Poetic/later variant of ἀπό, occasionally written for ἀπό in later texts.'),
('ἄπο', 'L008', NULL, NULL, 'ἀπό by anastrophe (accent shift) when it follows its governed noun, e.g. ὀμμάτων ἄπο -- never in prose.');
