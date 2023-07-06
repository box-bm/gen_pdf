class Reference {
  final String table;
  final String column;
  final String remoteColumn;

  Reference({
    required this.table,
    required this.column,
    required this.remoteColumn,
  });

  String get referenceString {
    return 'FOREIGN KEY ($column) REFERENCES $table ($remoteColumn) ';
  }
}
