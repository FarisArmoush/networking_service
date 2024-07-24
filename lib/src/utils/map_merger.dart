extension MapMerger<Key, Value> on Map<Key, Value>? {
  Map<Key, Value>? mergeWith(Map<Key, Value>? input) {
    final mergedHeaders = {...?this, ...?input};
    return mergedHeaders.isNotEmpty ? mergedHeaders : null;
  }
}
