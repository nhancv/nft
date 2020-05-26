
import 'dart:async';
import 'dart:io';

/// Setup PATH point to: flutter\bin\cache\dart-sdk\bin
/// * Run:
/// * dart rename_file.dart

// Get file in directory
Future<List<FileSystemEntity>> dirContents(Directory dir) {
  var files = <FileSystemEntity>[];
  var completer = Completer<List<FileSystemEntity>>();
  var lister = dir.list(recursive: false);
  lister.listen((file) => files.add(file),
      // should also register onError
      onDone: () => completer.complete(files));
  return completer.future;
}

// Convert abcXyz.png = to abc_xyz.png
// From: addNew.png
// => add_new.png
void renameFile(List<FileSystemEntity> fileList) {
  fileList.forEach((f) {
    // Parse with template abcXyz.png
    RegExp pattern = RegExp(r'[a-z]{0,}[A-Z].{0,}.png');
    String fileName = pattern.stringMatch(f.path);
    if (fileName != null) {
      String newName = fileName.splitMapJoin(RegExp(r'[A-Z]+'),
          onMatch: (m) => '_${m.group(0).toLowerCase()}', onNonMatch: (n) => n);
      String newFilePath = f.path.replaceAll(pattern, newName);
      f.renameSync(newFilePath);
    }
  });
}

void main() async {
  List<FileSystemEntity> fileList =
      await dirContents(Directory('../../assets/images/'));
  renameFile(fileList);
}
