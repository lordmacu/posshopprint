class PosDB {
  int? id;
  int storeId;
  int posId;

  PosDB({
    required this.storeId,
    required this.posId,
  });

  Map<String, dynamic> toMap() => {
        'storeId': storeId,
        'posId': posId,
      };

  factory PosDB.fromMap(Map<String, dynamic> map) => PosDB(
        storeId: map['storeId'],
        posId: map['posId'],
      );
}
