String get upgradeV2 =>
    """
ALTER TABLE Bills
ADD seller TEXT;
ALTER TABLE Bills
ADD buyer TEXT;
ALTER TABLE Bills
DROP COLUMN termsAndConditions;
""";
