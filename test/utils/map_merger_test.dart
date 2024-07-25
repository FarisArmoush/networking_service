import 'package:flutter_test/flutter_test.dart';
import 'package:networking_service/src/utils/map_merger.dart';

void main() {
  group('MapMergeExtension', () {
    test('mergeWith returns null when both maps are null', () {
      Map<String, String>? map1;
      Map<String, String>? map2;

      expect(map1.mergeWith(map2), isNull);
    });

    test('mergeWith returns the other map when one map is null', () {
      final map1 = <String, String>{'key1': 'value1'};
      Map<String, String>? map2;

      expect(map1.mergeWith(map2), equals({'key1': 'value1'}));
      expect(map2.mergeWith(map1), equals({'key1': 'value1'}));
    });

    test('mergeWith returns a merged map when both maps are non-null', () {
      final map1 = <String, String>{'key1': 'value1'};
      final map2 = <String, String>{'key2': 'value2'};

      expect(
        map1.mergeWith(map2),
        equals({'key1': 'value1', 'key2': 'value2'}),
      );
    });

    test('''
mergeWith merges maps and keeps values from the second map when keys conflict''',
        () {
      final map1 = <String, String>{'key1': 'value1', 'key2': 'value2'};
      final map2 = <String, String>{'key2': 'newValue', 'key3': 'value3'};

      expect(
        map1.mergeWith(map2),
        equals({'key1': 'value1', 'key2': 'newValue', 'key3': 'value3'}),
      );
    });

    test('mergeWith returns null when merging two empty maps', () {
      final map1 = <String, String>{};
      final map2 = <String, String>{};

      expect(map1.mergeWith(map2), isNull);
    });

    test('mergeWith returns the non-empty map when one map is empty', () {
      final map1 = <String, String>{};
      final map2 = <String, String>{'key1': 'value1'};

      expect(map1.mergeWith(map2), equals({'key1': 'value1'}));
      expect(map2.mergeWith(map1), equals({'key1': 'value1'}));
    });
  });
}
