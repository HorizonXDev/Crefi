import 'package:crefi/commands/create_command/create_command.dart';
import 'package:crefi/helpers/print_art.dart';
import 'package:dart_console/dart_console.dart';
import 'package:args/command_runner.dart';
import 'dart:io' show Directory, exit;

void main(List<String> arguments) {
  final _cd = Directory.current.path;
  final runner =
      CrefiCommandRunner('crefi', "Create Files easily with the content :)");
  runner.argParser.addFlag('version', abbr: 'v', negatable: false,
      callback: (val) {
    if (val) {
      _printVersion();
    }
  });

  runner
    ..addCommand(CreateCommand(_cd))
    ..run(arguments).catchError((Object err) {
      if (err is UsageException) {
        runner.printUsage();
      } else {
        throw err;
      }
    });
}

void _printVersion() {
  PrintArt();
  Console()
    ..write('Version:   ')
    ..setForegroundColor(ConsoleColor.cyan)
    ..writeLine('1.0')
    ..resetColorAttributes();
  exit(0);
}

class CrefiCommandRunner extends CommandRunner {
  CrefiCommandRunner(String executableName, String description)
      : super(executableName, description);

  @override
  void printUsage() {
    PrintArt();

    final console = Console();
    // Print description
    console
      ..setForegroundColor(ConsoleColor.cyan)
      ..write('Usage: ')
      ..resetColorAttributes()
      ..writeLine('  crefi create <file-name> <args>(optional)')
      ..writeLine()
      ..setForegroundColor(ConsoleColor.yellow)
      ..writeLine('Commands Available')
      ..writeLine()
      ..setForegroundColor(ConsoleColor.cyan)
      ..write('create :   ')
      ..resetColorAttributes()
      ..writeLine(
          'Creates a new file with given extension and content in the current directory')
      ..writeLine();
  }
}
