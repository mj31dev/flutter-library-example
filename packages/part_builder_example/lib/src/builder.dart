import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'annotation.dart';

class CopyWithGenerator extends GeneratorForAnnotation<CopyWith> {

  // Generate code for class with @CopyWith annotation
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) return '';

    // Get class name
    final className = element.name;

    // Get all fields
    final fields = element.fields
        .where((f) => !f.isStatic && !f.isSynthetic && f.setter == null)
        .toList();

    // Create params
    final params = fields
        .map((f) {
          final type = f.type.getDisplayString(withNullability: false);
          final name = f.name;
          return '$type? $name';
        })
        .join(', ');

    // Create function body
    final assigns = fields
        .map((f) {
          final name = f.name;
          return '$name: $name ?? this.$name';
        })
        .join(',\n      ');

    // Return generated code
    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND

extension ${className}CopyWith on $className {
  $className copyWith({$params}) {
    return $className(
      $assigns
    );
  }
}
''';
  }
}

// Create part builder
Builder copyWithBuilder(BuilderOptions options) =>
    PartBuilder([CopyWithGenerator()], '.copy.with.dart');
