class Taskmodel {
  String id;
  String title;
  String description;
  bool isCompleted;
  DateTime? dueDate;
  String piriority;
  String category;

  Taskmodel({
    required this.id,
    required this.title,
    required this.description,
    required this.piriority,
    required this.category,
    this.isCompleted = false,
    DateTime? dueDate,
  }) : dueDate = dueDate ?? DateTime.now();
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'piriority':piriority,
      'category':category,
      'isCompleted': isCompleted,
    };
  }

  Taskmodel.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      title = map['title'],
      description = map['description'],
      dueDate = map['dueDate'] != null
          ? DateTime.tryParse(map['dueDate'])
          : null,
      piriority = map['piriority'],
      category = map['category'],
      isCompleted = map['isCompleted'] is bool
          ? map['isCompleted']
          : map['isCompleted'].toString().toLowerCase() == 'true';
}
