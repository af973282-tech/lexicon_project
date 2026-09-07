-- Morph_Index additions for θεός (L009) — run AFTER theos_full_detail.sql,
-- after Morph_Index already exists. Full singular/plural paradigm seeded
-- given this is a very high-frequency noun (59th most frequent word in
-- the corpus per the source material) -- worth the fuller treatment
-- unlike a rarer word.

INSERT INTO Morph_Index (Inflected_Form, Lemma_ID, Case_, Number, Notes) VALUES
('θεός', 'L009', 'nominative', 'singular', 'Citation/dictionary form. Also predicate nominative in C053 (metaphorical apotheosis).'),
('θεοῦ',  'L009', 'genitive',   'singular', 'From C050 (θεὸς ἐκ θεοῦ, ruler-cult formula) and S065 fixed expression ἄνευ θεοῦ.'),
('θεῷ',   'L009', 'dative',     'singular', 'From C048 (σὺν θεῷ).'),
('θεόν',  'L009', 'accusative', 'singular', 'From S066 (μαντεύσατο ἐς θεὸν ἐλθών).'),
('θεοί',  'L009', 'nominative', 'plural',   'Common plural form; frequently monosyllabic by synizesis in verse (see Root_Lineage-adjacent notes in source).'),
('θεῶν',  'L009', 'genitive',   'plural',   'From S065 fixed expression οὐ θεῶν ἄτερ.'),
('θεοῖς', 'L009', 'dative',     'plural',   'From C051 (θεοῖς χθονίοις, funerary formula).'),
('θεούς', 'L009', 'accusative', 'plural',   'From C052 (LXX θεοὺς οὐ κακολογήσεις, Hebrew-calque judge sense).');
