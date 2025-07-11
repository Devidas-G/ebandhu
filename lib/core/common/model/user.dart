import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../entity/user.dart';
// Generate serialization code with build_runner
part 'user.g.dart';

@JsonSerializable()
class User extends UserEntity with EquatableMixin {
  const User({
    required super.id,
    required super.name,
    super.age,
    super.gender,
    super.country,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, name, age, gender, country];
}
