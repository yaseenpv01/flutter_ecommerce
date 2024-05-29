import 'dart:convert';

import 'package:ecommerce_motion_flutter/feature/home_products/data/models/sub_model.dart';
import 'package:ecommerce_motion_flutter/feature/home_products/domain/entity/products_entity.dart';

class ProductsModel extends ProductsEntity {
  const ProductsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  factory ProductsModel.fromRawJson(String str) =>
      ProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json["id"],
      title: json["title"],
      price: json["price"].toDouble(),
      description: json["description"],
      category: json["category"],
      image: json["image"],
      rating: RatingModel.fromJson(json["rating"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating,
      };

  static List<ProductsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductsModel.fromJson(json)).toList();
  }
}
