import 'dart:convert';

class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(name: json['name'], age: json['age']);
  }
  // factory를 사용하면 생성자 메소드로 사용할 수 있다,
  // 생성자를 다양하게 만들 수 있도록 추가, json로부터 만든 Person.
  // 생성자는 인스턴스를 필수적으로 반환해야하기 때문에, name과 age를 반환하게 설정.

  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age};
  }
}

void main() {
  /// 네트워크 응답 문자열
  String jsonString = '{"name": "철수", "age": 10}';

  ///JSON 포맷 String -> Map<String, dynamic>
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  print(jsonMap);

  ///Map<String, dynamic> -> Person
  Person person = Person.fromJson(jsonMap);
  print(person);

  /// Person -> Map<String, dynamic>
  Map<String, dynamic> personMap = person.toJson();
  print(personMap);

  /// Map<String, dynamic> -> JSON 포맷 String
  String personString = jsonEncode(personMap);
  print(personString);
}
