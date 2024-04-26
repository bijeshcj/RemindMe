class ToDo {
  final int id;
  final String title;
  final String createdAt;
  final String? updatedAt;
  final String isPersonal;

  ToDo(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.updatedAt,
      required this.isPersonal});

  factory ToDo.fromSqfliteDatabase(Map<String,dynamic> map) => ToDo(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      createdAt: DateTime.fromMicrosecondsSinceEpoch(map['createdAt']).toIso8601String(),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(map['updatedAt']).toIso8601String(),
      isPersonal: map['isPersonal'] ?? 'Personal');
}
