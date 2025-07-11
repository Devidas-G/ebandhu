import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final int? age;
  final String? gender;
  final String? country;

  const UserEntity({
    required this.id,
    required this.name,
    this.age,
    this.gender,
    this.country,
  });

  @override
  List<Object?> get props => [id, name, age, gender, country];
}
