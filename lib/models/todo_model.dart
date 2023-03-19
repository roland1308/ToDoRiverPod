
class ToDo{
  int toDoId;
  String comment;

  ToDo({
    required this.toDoId,
    required this.comment,
  });

  factory ToDo.fromJson(Map json) {
    return ToDo(
      toDoId: json['toDoId'],
      comment: json['comment'],
    );
  }
  Map<String, dynamic> toJson() => {
    "id": toDoId,
    "comment": comment,
  };
}
