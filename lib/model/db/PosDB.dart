class PosDB {
  int? id;
  int storeId;
  String storeName;
  int posId;
  String posName;

  PosDB({
    required this.storeId,
    required this.storeName,
    required this.posId,
    required this.posName,
  });

  Map<String, dynamic> toMap() => {
        'storeId': storeId,
        'storeName': storeName,
        'posId': posId,
        'posName': posName,
      };

  factory PosDB.fromMap(Map<String, dynamic> map) => PosDB(
        storeId: map['storeId'],
        storeName: map['storeName'],
        posId: map['posId'],
        posName: map['posName'],
      );
}
