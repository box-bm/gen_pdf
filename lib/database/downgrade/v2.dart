String get downgradeV2 =>
    """
ALTER TABLE bills
ADD termsAndConditions,
DROP COLUMN seller TEXT,
DROP COLUMN buyer TEXT;
""";
