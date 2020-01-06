import 'paging_info.dart';
import 'summary.dart';

typedef DataBuilder<T> = T Function(Map);
typedef DataConverter<T> = Map Function(T);

/// Represents a container of a list with paging information and a summary.
class DataList<T> {
  /// The contained data.
  List<T> data;

  /// The paging information.
  PagingInfo paging;

  /// The summary.
  Summary summary;

  DataConverter<T> dataConverter;

  /// Creates a new instance.
  DataList(
    Map<String, dynamic> jsonObject,
    DataBuilder<T> dataBuilder,
    this.dataConverter,
  ) {
    List dataMaps = jsonObject['data'];
    data = List.from(dataMaps.cast<Map>().map(dataBuilder));
    paging = PagingInfo(jsonObject['paging']);
    summary = Summary(jsonObject['summary']);
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((item) => dataConverter(item)).toList(),
        'paging': paging.toJson(),
        'summary': summary.toJson(),
      };

  @override
  String toString() => '''<DataList data: $data,
    paging: $paging,
    summary: $summary''';
}
