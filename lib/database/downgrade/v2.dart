String get downgradeV2 =>
    """
BEGIN TRANSACTION;

ALTER TABLE bills ADD termsAndConditions;
ALTER TABLE bills DROP COLUMN seller;
ALTER TABLE bills DROP COLUMN buyer;

COMMIT
""";
