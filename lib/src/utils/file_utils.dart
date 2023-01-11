import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class FileUtils {
  static Future<String> _getShoppingNotesDirPath() async {
    final Directory appDocsDir = await getApplicationDocumentsDirectory();
    final String shoppingNotesDirPath = join(appDocsDir.path, 'shoppingnotes');

    Directory shoppingNotesDir = Directory(shoppingNotesDirPath);

    if (!shoppingNotesDir.existsSync()) {
      shoppingNotesDir.createSync();
    }

    return shoppingNotesDirPath;
  }

  static Future<List<File>> listNotes() async {
    final shoppingNotesDirPath = await _getShoppingNotesDirPath();

    List<File> notesFiles = [];

    List<FileSystemEntity> listFse = Directory(shoppingNotesDirPath).listSync();

    for (var fse in listFse) {
      if (fse is File) {
        notesFiles.add(fse);
      }
    }

    return notesFiles;
  }

  static Future<void> writeNote(String noteName, String fileContent) async {
    final shoppingNotesDirPath = await _getShoppingNotesDirPath();

    final shoppingNotePath = join(shoppingNotesDirPath, noteName);
    final notesFile = File(shoppingNotePath);

    await notesFile.writeAsString(fileContent);
  }

  static Future<String> readNote(String noteName) async {
    final shoppingNotesDirPath = await _getShoppingNotesDirPath();

    final shoppingNotePath = join(shoppingNotesDirPath, noteName);
    final notesFile = File(shoppingNotePath);

    final contents = await notesFile.readAsString();

    return contents;
  }

  static Future<void> deleteNote(String noteName) async {
    final shoppingNotesDirPath = await _getShoppingNotesDirPath();

    final shoppingNotePath = join(shoppingNotesDirPath, noteName);
    final notesFile = File(shoppingNotePath);

    await notesFile.delete();
  }
}
