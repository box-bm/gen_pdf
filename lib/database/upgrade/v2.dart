String get upgradeV2 =>
    """
BEGIN TRANSACTION;

ALTER TABLE bills ADD seller TEXT;
ALTER TABLE bills ADD sellerPosition TEXT;
ALTER TABLE bills ADD buyer TEXT;
ALTER TABLE bills DROP COLUMN termsAndConditions;

COMMIT
""";
