// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  age: (json['age'] as num).toInt(),
  gender: json['gender'] as String,
  country: json['country'] as String,
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'age': instance.age,
  'gender': instance.gender,
  'country': instance.country,
};
