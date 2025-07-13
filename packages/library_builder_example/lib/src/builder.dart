import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class ToStringGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final inputUri = buildStep.inputId.uri;
    final importPath = inputUri.toString();

    final buffer = StringBuffer();
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');
    buffer.writeln("import '$importPath';\n");

    for (final classElement in library.classes.where(
      (c) => !c.isAbstract && !c.name.startsWith('_'),
    )) {
      final className = classElement.name;
      final fields = classElement.fields
          .where((f) => !f.isStatic && !f.isSynthetic)
          .map((f) => '${f.name}: \$${f.name}')
          .join(', ');

      buffer.writeln('extension ${className}ToString on $className {');
      buffer.writeln(
        '  String asString() => \'$className($fields)\';',
      );
      buffer.writeln('}\n');
    }

    return buffer.toString();
  }
}

Builder toStringBuilder(BuilderOptions options) =>
    LibraryBuilder(ToStringGenerator(), generatedExtension: '.to.string.dart');
