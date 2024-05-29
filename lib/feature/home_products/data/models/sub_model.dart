import 'dart:convert';

import 'package:ecommerce_motion_flutter/feature/home_products/domain/entity/sub_entity.dart';

class RatingModel extends Rating {
  const RatingModel({
    required super.rate,
    required super.count,
  });

  factory RatingModel.fromRawJson(String str) =>
      RatingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
