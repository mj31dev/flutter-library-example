import 'package:build/build.dart';
import 'annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class AutoHelloGenerator extends GeneratorForAnnotation<AutoHello> {
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

Builder autoHelloBuilder(BuilderOptions options) =>
    SharedPartBuilder([AutoHelloGenerator()], 'auto_hello');