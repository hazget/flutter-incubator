import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder summaryBuilder(BuilderOptions options) =>
    SharedPartBuilder([SummaryGenerator()], 'summary');

class SummaryGenerator extends Generator {
  @override
  Future<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final linesOfCode = {
      'dummy.dart': 800,
      'test.dart': 180,
      'main.dart': 20,
    };

    final totalLinesOfCode = linesOfCode.values.reduce((a, b) => a + b);

    final buffer = StringBuffer();
    buffer.writeln('Total lines of code: $totalLinesOfCode');
    buffer.writeln('Lines of code by file in descending order:');

    final sortedFiles = linesOfCode.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    for (final entry in sortedFiles) {
      final fileName = entry.key;
      final lines = entry.value;
      buffer.writeln('$fileName: $lines');
    }

    final outputContent = buffer.toString();

    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, 'summary.g'),
      outputContent,
    );

    return null;
  }
}
