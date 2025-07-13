import 'package:shared_part_builder_example/shared_part_builder_example.dart';
import 'package:part_builder_example/part_builder_example.dart';

part 'test_model.g.dart';

part 'test_model.copy.with.dart';

@AutoHello()
@CopyWith()
class TestModel {
  final String id;
  final String label;
  final String desc;

  TestModel({required this.id, required this.label, required this.desc});
}
