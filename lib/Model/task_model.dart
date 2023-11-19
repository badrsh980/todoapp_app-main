class Todolist {
  String _id = '';
  String? _title;
  String? _content;
  bool? _isdone = false;
  DateTime? _date;

  Todolist({
    required String id,
    String? title,
    String? content,
    DateTime? date,
    bool? isdone,
  })  : _id = id,
        _title = title,
        _content = content,
        _date = date,
        _isdone = isdone;

  // json to obj
  factory Todolist.fromJson(Map<String, dynamic> map) {
    return Todolist(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'] != null ? DateTime.tryParse(map['date']) : null,
      isdone: map['isdone'], // Add this line
    );
  }

  // obj to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'date': date != null
            ? date?.toIso8601String()
            : DateTime.now().toIso8601String(),
        'isdone': isDone,
      };

  // getters and setters

  String? get id => _id;
  set id(String? value) {
    _id = value!;
  }

  String? get title => _title;
  set title(String? value) {
    _title = value;
  }

  String? get content => _content;
  set content(String? value) {
    _content = value;
  }

  bool get isDone => _isdone ?? false;
  set isDone(bool value) {
    _isdone = value;
  }

  DateTime? get date => _date;
  set date(DateTime? value) {
    _date = value;
  }
}
