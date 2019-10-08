/// Represents a container of the total count of a list.
class Summary {
  /// The total count.
  int total = 0;

  /// Creates a new instance.
  Summary(Map<String, dynamic> jsonObject) {
    total = jsonObject['total'];
  }

  Map<String, dynamic> toJson() => {'total': total};

  @override
  String toString() => '''<Summary total: $total>''';
}
