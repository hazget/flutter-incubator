import 'package:json_annotation/json_annotation.dart';

part 'serialization.g.dart';

@JsonSerializable()
class Person {
  const Person({required this.name, required this.birthday});

  final String name;
  final DateTime birthday;

  factory Person.fromJson(Map<String, dynamic> json) =>
      _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
