class Task {
  String id;
  String title;
  String description;
  int date;
  bool isCheck;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.date,
    this.isCheck = false,
  });

  Task.fromJson(Map<String, dynamic> Json)
      : this(
            id: Json["id"] as String,
            title: Json["title"] as String,
            description: Json["description"] as String,
            date: Json["date"] as int,
            isCheck: Json["isCheck"] as bool);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isCheck": isCheck,
    };
  }
}
