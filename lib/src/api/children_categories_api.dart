import 'dart:convert';

import 'package:kkbox_openapi/kkbox_auth.dart';
import 'package:kkbox_openapi/kkbox_openapi_types.dart';
import 'package:meta/meta.dart';

import 'base.dart';

/// Fetches categories for children contents.
///
/// See https://docs-en.kkbox.codes/reference#children-categories .
class ChildrenCategoriesApi extends KKBOXBaseApi<ChildrenCategoryList> {
  /// Creates a new instance.
  ChildrenCategoriesApi({
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
  String get url => baseUrl(configuration) + 'children-categories';

  @override
  ChildrenCategoryList parseResult(String body) {
    final map = json.decode(body);
    return ChildrenCategoryList(map);
  }
}
