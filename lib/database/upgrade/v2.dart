String get upgradeV2 =>
    """
ALTER TABLE bills
ADD seller TEXT,
ADD buyer TEXT,
DROP COLUMN termsAndConditions;
""";
