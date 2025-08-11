import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class ToStringGenerator extends Generator {

  // Generate code for file (no annotation required)
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final inputUri = buildStep.inputId.uri;
    final importPath = inputUri.toString();

    final buffer = StringBuffer();
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');
    // Add import
    buffer.writeln("import '$importPath';\n");

    // Generate code for each class in the file
    for (final classElement in library.classes.where(
      (c) => !c.isAbstract && !c.name.startsWith('_'),
    )) {
      // Get class name
      final className = classElement.name;
      // Get all fields
      final fields = classElement.fields
          .where((f) => !f.isStatic && !f.isSynthetic)
          .map((f) => '${f.name}: \$${f.name}')
          .join(', ');

      // Generate code
      buffer.writeln('extension ${className}ToString on $className {');
      buffer.writeln(
        '  String asString() => \'$className($fields)\';',
      );
      buffer.writeln('}\n');
    }

    return buffer.toString();
  }
}

// Create library builder
Builder toStringBuilder(BuilderOptions options) =>
    LibraryBuilder(ToStringGenerator(), generatedExtension: '.to.string.dart');
