-- Pattern_Category migration for the Constructions table
-- NOTE: as of the canonical schema.sql, Pattern_Category is already a column
-- on Constructions from CREATE TABLE. This file is kept as historical record
-- of the migration; when building fresh from schema.sql, apply only the
-- UPDATE statements below (skip any ALTER TABLE line).
-- Run AFTER all 9 words (logos through theos) are already loaded.
-- Adds a queryable taxonomy tag to every existing Construction row,
-- built from a verified audit of all 52 rows (see Cross_Lemma_Matrix.md).

ALTER TABLE Constructions ADD COLUMN Pattern_Category TEXT;

UPDATE Constructions SET Pattern_Category = 'Dative of Respect/Manner (Antithesis)' WHERE Construction_ID = 'C001';
UPDATE Constructions SET Pattern_Category = 'Direct-Object Accusative (Ordinary)' WHERE Construction_ID = 'C002';
UPDATE Constructions SET Pattern_Category = 'Genitive of Specification/Domain' WHERE Construction_ID = 'C003';
UPDATE Constructions SET Pattern_Category = 'Pros + Accusative (Relational Orientation)' WHERE Construction_ID = 'C004';
UPDATE Constructions SET Pattern_Category = 'Preposition Antonym Pair (Same Case)' WHERE Construction_ID = 'C005';
UPDATE Constructions SET Pattern_Category = 'Preposition Antonym Pair (Same Case)' WHERE Construction_ID = 'C006';
UPDATE Constructions SET Pattern_Category = 'Preposition Antonym Pair (Same Case)' WHERE Construction_ID = 'C007';
UPDATE Constructions SET Pattern_Category = 'Direct-Object Accusative (Ordinary)' WHERE Construction_ID = 'C008';
UPDATE Constructions SET Pattern_Category = 'Genitive of Specification/Domain' WHERE Construction_ID = 'C009';
UPDATE Constructions SET Pattern_Category = 'Dative of Respect/Manner (Antithesis)' WHERE Construction_ID = 'C010';
UPDATE Constructions SET Pattern_Category = 'Attributive-Adjective Naming Pattern' WHERE Construction_ID = 'C011';
UPDATE Constructions SET Pattern_Category = 'Direct-Object Accusative (Ordinary)' WHERE Construction_ID = 'C012';
UPDATE Constructions SET Pattern_Category = 'Direct-Object Accusative (Ordinary)' WHERE Construction_ID = 'C013';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: En + Dative (Container Metaphor)' WHERE Construction_ID = 'C014';
UPDATE Constructions SET Pattern_Category = 'Genitive of Specification/Domain' WHERE Construction_ID = 'C015';
UPDATE Constructions SET Pattern_Category = 'Countable-Plural Mass-to-Count Shift' WHERE Construction_ID = 'C016';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Coordinate Nominative Enumeration' WHERE Construction_ID = 'C017';
UPDATE Constructions SET Pattern_Category = 'Fossilized Adverbial Idiom' WHERE Construction_ID = 'C018';
UPDATE Constructions SET Pattern_Category = 'Personification-Marking (Syntactic Role)' WHERE Construction_ID = 'C019';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Cognate/Internal Accusative Object' WHERE Construction_ID = 'C020';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Dative/Genitive of Disadvantage' WHERE Construction_ID = 'C021';
UPDATE Constructions SET Pattern_Category = 'Genitive of Source' WHERE Construction_ID = 'C022';
UPDATE Constructions SET Pattern_Category = 'Genitive of Specification/Domain' WHERE Construction_ID = 'C024';
UPDATE Constructions SET Pattern_Category = 'Genitive of Specification/Domain' WHERE Construction_ID = 'C025';
UPDATE Constructions SET Pattern_Category = 'Genitive of Specification/Domain' WHERE Construction_ID = 'C026';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Eis + Accusative (Directed Benefit)' WHERE Construction_ID = 'C027';
UPDATE Constructions SET Pattern_Category = 'Countable-Plural Mass-to-Count Shift' WHERE Construction_ID = 'C028';
UPDATE Constructions SET Pattern_Category = 'Personification-Marking (Syntactic Role)' WHERE Construction_ID = 'C029';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Epi + Dative (Ontological Ground)' WHERE Construction_ID = 'C030';
UPDATE Constructions SET Pattern_Category = 'Predicate-Nominative Rhetorical Function' WHERE Construction_ID = 'C031';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Peri + Genitive (Topic/Concerning)' WHERE Construction_ID = 'C032';
UPDATE Constructions SET Pattern_Category = 'Pros + Accusative (Relational Orientation)' WHERE Construction_ID = 'C033';
UPDATE Constructions SET Pattern_Category = 'Attributive-Adjective Naming Pattern' WHERE Construction_ID = 'C034';
UPDATE Constructions SET Pattern_Category = 'Genitive of Specification/Domain' WHERE Construction_ID = 'C035';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Dative of Possession' WHERE Construction_ID = 'C036';
UPDATE Constructions SET Pattern_Category = 'Genitive of Source' WHERE Construction_ID = 'C037';
UPDATE Constructions SET Pattern_Category = 'Non-Case Governance' WHERE Construction_ID = 'C038';
UPDATE Constructions SET Pattern_Category = 'Fossilized Adverbial Idiom' WHERE Construction_ID = 'C039';
UPDATE Constructions SET Pattern_Category = 'Non-Case Governance' WHERE Construction_ID = 'C040';
UPDATE Constructions SET Pattern_Category = 'Non-Case Governance' WHERE Construction_ID = 'C041';
UPDATE Constructions SET Pattern_Category = 'Preposition Directness-Gradient (Near-Synonym)' WHERE Construction_ID = 'C042';
UPDATE Constructions SET Pattern_Category = 'Preposition Directness-Gradient (Near-Synonym)' WHERE Construction_ID = 'C043';
UPDATE Constructions SET Pattern_Category = 'Fossilized Adverbial Idiom' WHERE Construction_ID = 'C044';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Partitive (Apo + Genitive)' WHERE Construction_ID = 'C045';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Instrumental Body-Part/Faculty Idiom' WHERE Construction_ID = 'C046';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Diachronic Word-Order Shift' WHERE Construction_ID = 'C047';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Attendant-Circumstance Pair (With/Without)' WHERE Construction_ID = 'C048';
UPDATE Constructions SET Pattern_Category = 'Non-Case Governance' WHERE Construction_ID = 'C049';
UPDATE Constructions SET Pattern_Category = 'Preposition Directness-Gradient (Near-Synonym)' WHERE Construction_ID = 'C050';
UPDATE Constructions SET Pattern_Category = 'SINGLETON: Dative of Dedication' WHERE Construction_ID = 'C051';
UPDATE Constructions SET Pattern_Category = 'Direct-Object Accusative (Ordinary)' WHERE Construction_ID = 'C052';
UPDATE Constructions SET Pattern_Category = 'Predicate-Nominative Rhetorical Function' WHERE Construction_ID = 'C053';
