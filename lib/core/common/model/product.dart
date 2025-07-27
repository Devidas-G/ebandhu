import 'package:json_annotation/json_annotation.dart';

import '../entity/product.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends ProductEntity {
  const Product({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
