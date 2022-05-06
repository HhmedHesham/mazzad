import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories.freezed.dart';
part 'categories.g.dart';

@freezed
class Categories with _$Categories {
  const factory Categories({
    final int? id,
    final String? title,
    final String? icon_name,
  }) = _Categories;
  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);
}
