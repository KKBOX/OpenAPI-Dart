import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches contents of a category of children contents.
///
/// See https://docs-en.kkbox.codes/reference#children-categories_category_id .
class ChildrenCategoryApi extends KKBOXBaseApi<ChildrenCategoryGroup> {
  /// ID of the category.
  String categoryId;

  /// Creates a new instance.
  ChildrenCategoryApi(
    this.categoryId, {
    @required String accessToken,
    @required ClientConfiguration configuration,
    Territory territory = Territory.taiwan,
  }) : super(
          accessToken: accessToken,
          configuration: configuration,
          territory: territory,
        );

  @override
  Map<String, String> get customGetParameters => {
        'territory': territoryToString(territory),
      };

  @override
  String get url =>
      baseUrl(configuration) + 'children-categories/' + categoryId;

  @override
  ChildrenCategoryGroup parseResult(String body) {
    final map = json.decode(body);
    return ChildrenCategoryGroup(map);
  }
}
