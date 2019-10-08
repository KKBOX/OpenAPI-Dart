/// Represents paging information.
class PagingInfo {
  /// The limit of the items in the response of an API call.
  int limit = 0;

  /// The off set of the reponse of an API call.
  int offset = 0;

  /// The URL for doing this API call.
  String url;

  /// The URL for doing the API call fetching the items in the next page.
  String next;

  /// Creates a new instance.
  PagingInfo(Map<String, dynamic> jsonObject) {
    limit = jsonObject['limit'] ?? 0;
    offset = jsonObject['offset'] ?? 0;
    url = jsonObject['url'];
    next = jsonObject['next'];
  }

  Map<String, dynamic> toJson() => {
        'limit': limit,
        'offset': offset,
        'url': url,
        'next': next,
      };

  @override
  String toString() {
    return '''<PageInfo limit: $limit offset: $offset url: $url next: $next>''';
  }
}
