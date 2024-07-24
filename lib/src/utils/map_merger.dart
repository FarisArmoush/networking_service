/// Extension on `Map` to merge two maps together.
extension MapMerger<Key, Value> on Map<Key, Value>? {
  /// Merges the current map with [input] map.
  ///
  /// If both maps contain the same key, the value from the [input] map
  /// will overwrite the value from the current map.
  ///
  /// Returns the merged map if it is not empty, otherwise returns `null`.
  ///
  /// Example:
  /// ```dart
  /// Map<String, String>? map1 = {'key1': 'value1', 'key2': 'value2'};
  /// Map<String, String>? map2 = {'key2': 'newValue2', 'key3': 'value3'};
  ///
  /// Map<String, String>? mergedMap = map1.mergeWith(map2);
  /// print(mergedMap); // Output: {key1: value1, key2: newValue2, key3: value3}
  /// ```
  ///
  /// - Parameter input: The map to be merged with the current map.
  /// - Returns: A new map containing all key-value pairs from both maps,
  ///  or `null` if the merged map is empty.
  Map<Key, Value>? mergeWith(Map<Key, Value>? input) {
    final mergedHeaders = {...?this, ...?input};
    return mergedHeaders.isNotEmpty ? mergedHeaders : null;
  }
}
