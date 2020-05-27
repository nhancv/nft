import 'dart:async';
import 'dart:io';

/// Setup PATH point to: flutter/bin/cache/dart-sdk/bin
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
Future<void> renameFile(Directory directory) async {
  List<FileSystemEntity> fileList = await dirContents(directory);
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

// Move abc@2x.png = to 2.0x/abc.png
Future<void> moveFile(Directory directory) async {
  List<FileSystemEntity> fileList = await dirContents(directory);
  fileList.forEach((f) {
    // Parse with template abc@2x.png
    RegExp pattern = RegExp(r'[A-z]{0,}@[2-3]x.png');
    String fileName = pattern.stringMatch(f.path);
    if (fileName != null) {
      String newName = fileName.splitMapJoin(pattern,
          onMatch: (m) {
            RegExp suffixPattern = RegExp(r'@[2-3]x');
            String suffixType = suffixPattern.stringMatch(fileName);
            String name =
                '${(suffixType == '@2x' ? '2.0x' : '3.0x')}/${fileName.replaceFirst(suffixType, "")}';
            return name;
          },
          onNonMatch: (n) => n);
      String newFilePath = f.path.replaceAll(pattern, newName);
      f.renameSync(newFilePath);
    }
  });
}

void main() async {
  List<Directory> fileLists = [
    Directory('../../assets/app/icons/')
  ];
  fileLists.forEach((directory) async {
    await renameFile(directory);
    await moveFile(directory);
  });
}
