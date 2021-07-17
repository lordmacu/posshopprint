import 'CategoryRequest.dart';

class CategoriesRequest {
  List<CategoryRequest>? categories;

  CategoriesRequest({
    this.categories,
  });

  factory CategoriesRequest.fromJson(Map<String, dynamic> json) {
    return CategoriesRequest(
      categories: List<CategoryRequest>.from(
          json['data'].map((model) => CategoryRequest.fromJson(model))),
    );
  }
}
