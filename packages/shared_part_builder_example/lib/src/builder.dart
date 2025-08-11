import 'package:build/build.dart';
import 'annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class AutoHelloGenerator extends GeneratorForAnnotation<AutoHello> {
  // Generate code for class with @AutoHello annotation
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final className = element.displayName;
    return '''
extension ${className}Hello on $className {
  void sayHello() {
    print("Hello from $className!");
  }
}
''';
  }
}

// Create shared part builder
Builder autoHelloBuilder(BuilderOptions options) =>
    SharedPartBuilder([AutoHelloGenerator()], 'auto_hello');
