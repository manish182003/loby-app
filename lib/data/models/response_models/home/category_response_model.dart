import 'package:loby/data/models/home/category_model.dart';
import 'package:loby/domain/entities/response_entities/home/category_response.dart';

import '../../../../domain/entities/home/category.dart';
// ignore_for_file: overridden_fields, annotate_overrides


class CategoryResponseModel extends CategoryResponse {

  final List<Category> categories;

  const CategoryResponseModel({
    required this.categories,
  }) : super(categories: categories);

  @override
  List<Object> get props => [categories];

  factory CategoryResponseModel.fromJSON(Map<String, dynamic> json) =>
      CategoryResponseModel(
        categories: (json['data']['rows'] as List<dynamic>)
            .map<CategoryModel>((countries) => CategoryModel.fromJson(countries))
            .toList(),
      );
}
