-- One-line fix: promote C020 from SINGLETON to a confirmed pattern now that
-- word10 (hybris) independently produced a second cognate-accusative
-- construction (C056), matching it. Run once if rebuilding from the SQL
-- files rather than through this session's live classical.db.
UPDATE Constructions SET Pattern_Category = 'Cognate/Internal Accusative Object' WHERE Construction_ID = 'C020';
