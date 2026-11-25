
import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    this.thumbnail,
    this.endedAt,
  });

  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;
  final String category;
  final String? thumbnail;
  final DateTime? endedAt;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
