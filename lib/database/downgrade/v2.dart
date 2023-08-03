String get downgradeV2 =>
    """
ALTER TABLE Bills
DROP COLUMN seller TEXT;
ALTER TABLE Bills
DROP COLUMN buyer TEXT;
ALTER TABLE Bills
ADD termsAndConditions;
""";
