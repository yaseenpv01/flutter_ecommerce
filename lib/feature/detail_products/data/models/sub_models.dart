 import 'package:ecommerce_motion_flutter/feature/detail_products/domain/entity/sub_entity.dart';

class RatingModel extends RatingEntity {
  const RatingModel({
    super.rate,
    super.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );
}
