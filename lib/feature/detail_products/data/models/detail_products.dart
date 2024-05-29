import 'package:ecommerce_motion_flutter/feature/detail_products/data/models/sub_models.dart';
import 'package:ecommerce_motion_flutter/feature/detail_products/domain/entity/detail_products_entity.dart';

class DetailProductsModel extends DetailProductsEntity {
  DetailProductsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
    required super.quantity,
  });

  factory DetailProductsModel.fromJson(Map<String, dynamic> json) =>
      DetailProductsModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: RatingModel.fromJson(json["rating"]),
        quantity: 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };
}
