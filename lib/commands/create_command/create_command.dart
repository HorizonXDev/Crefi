import 'dart:io' show File, exit;

import 'package:args/command_runner.dart';
import 'package:crefi/helpers/print_art.dart';
import 'package:dart_console/dart_console.dart';

import '../../helpers/simple_question.dart';

class CreateCommand extends Command {
  final String _cd;

  CreateCommand(this._cd) {
    argParser
      ..addOption('extension',
          abbr: 'e', help: 'Extension of the file (eg. (.txt))')
      ..addOption('content',
          abbr: 'c',
          help: 'Dynamic content that you want to add while creating the file');
  }

  @override
  String get description => 'Creates the file with content';

  @override
  String get name => 'create';

  @override
  void printUsage() {
    PrintArt();

    Console()
      ..setForegroundColor(ConsoleColor.brightGreen)
      ..write('   create: ')
      ..resetColorAttributes()
      ..writeLine('   $description')
      ..setForegroundColor(ConsoleColor.brightGreen)
      ..write('   Usage:')
      ..resetColorAttributes()
      ..writeLine('   crefi create <file-name> <args>(optional)');
  }

  @override
  Future<void> run() async {
    late String name;
    if (argResults!.rest.length == 1) {
      name = argResults!.rest.first;
    } else {
      printUsage();
      exit(64);
    }

    PrintArt();
    String extension;
    final String content;

    if (argResults!['extension'] == null) {
      extension = SimpleQuestion(question: 'Extension name(eg. (.txt))').ask();
    } else {
      extension = argResults!['extension'].toString().trim();
    }

    if (argResults!['content'] == null) {
      content = SimpleQuestion(question: 'Content').ask();
    } else {
      content = argResults!['content'].toString().trim();
    }

    if (extension.contains('.')) {
      extension = extension;
    } else {
      extension = '.' + extension;
    }
    final String path = _cd + '\\crefi_output\\' + name + extension;
    File file = File(path)..createSync(recursive: true);
    file.writeAsString(content);

    Console()
      ..setForegroundColor(ConsoleColor.green)
      ..writeLine()
      ..write('• ')
      ..setForegroundColor(ConsoleColor.brightGreen)
      ..write('Success! ')
      ..resetColorAttributes()
      ..write('Generated File $name$extension at $path')
      ..writeLine();
  }
}
