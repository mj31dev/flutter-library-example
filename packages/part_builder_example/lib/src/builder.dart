import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'annotation.dart';

class CopyWithGenerator extends GeneratorForAnnotation<CopyWith> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) return '';

    final className = element.name;

    final fields = element.fields
        .where((f) => !f.isStatic && !f.isSynthetic && f.setter == null)
        .toList();

    final params = fields
        .map((f) {
          final type = f.type.getDisplayString(withNullability: false);
          final name = f.name;
          return '$type? $name';
        })
        .join(', ');

    final assigns = fields
        .map((f) {
          final name = f.name;
          return '$name: $name ?? this.$name';
        })
        .join(',\n      ');

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

Builder copyWithBuilder(BuilderOptions options) =>
    PartBuilder([CopyWithGenerator()], '.copy.with.dart');
