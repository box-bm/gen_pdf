List<String> get downgradeV2 => [
      "ALTER TABLE bills ADD termsAndConditions",
      "ALTER TABLE bills DROP COLUMN seller",
      "ALTER TABLE bills DROP COLUMN sellerPosition",
      "ALTER TABLE bills DROP COLUMN buyer"
    ];
