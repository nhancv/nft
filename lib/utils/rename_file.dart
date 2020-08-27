import 'dart:async';
import 'dart:io';

/// Setup PATH point to: flutter/bin/cache/dart-sdk/bin
/// * Run:
/// * dart rename_file.dart

// Get file in directory
Future<List<FileSystemEntity>> dirContents(Directory dir) {
  final List<FileSystemEntity> files = <FileSystemEntity>[];
  final Completer<List<FileSystemEntity>> completer =
      Completer<List<FileSystemEntity>>();
  final Stream<FileSystemEntity> lister = dir.list();
  lister.listen((FileSystemEntity file) => files.add(file),

      /// should also register onError
      onDone: () => completer.complete(files));
  return completer.future;
}

// Convert abcXyz.png = to abc_xyz.png
// From: addNew.png
// => add_new.png
Future<void> renameFile(Directory directory) async {
  final List<FileSystemEntity> fileList = await dirContents(directory);

  /// ignore: avoid_function_literals_in_foreach_calls
  fileList.forEach((FileSystemEntity f) {
    /// Parse with template abcXyz.png
    /// ignore: unnecessary_raw_strings
    final RegExp pattern = RegExp(r'[a-z]{0,}[A-Z].{0,}.png');
    final String fileName = pattern.stringMatch(f.path);
    if (fileName != null) {
      /// ignore: unnecessary_raw_strings
      final String newName = fileName.splitMapJoin(RegExp(r'[A-Z]+'),
          onMatch: (Match m) => '_${m.group(0).toLowerCase()}',
          onNonMatch: (String n) => n);
      final String newFilePath = f.path.replaceAll(pattern, newName);
      f.renameSync(newFilePath);
    }
  });
}

// Move abc@2x.png = to 2.0x/abc.png
Future<void> moveFile(Directory directory) async {
  final List<FileSystemEntity> fileList = await dirContents(directory);

  /// ignore: avoid_function_literals_in_foreach_calls
  fileList.forEach((FileSystemEntity f) {
    /// Parse with template abc@2x.png
    /// ignore: unnecessary_raw_strings
    final RegExp pattern = RegExp(r'[A-z,0-9]{0,}@[2-3]x.png');
    final String fileName = pattern.stringMatch(f.path);
    if (fileName != null) {
      final String newName = fileName.splitMapJoin(pattern,
          onMatch: (Match m) {
            /// ignore: unnecessary_raw_strings
            final RegExp suffixPattern = RegExp(r'@[2-3]x');
            final String suffixType = suffixPattern.stringMatch(fileName);
            final String name =

                /// ignore: unnecessary_parenthesis
                '${(suffixType == '@2x' ? '2.0x' : '3.0x')}/${fileName.replaceFirst(suffixType, "")}';
            return name;
          },
          onNonMatch: (String n) => n);
      final String newFilePath = f.path.replaceAll(pattern, newName);
      f.renameSync(newFilePath);
    }
  });
}

Future<void> main() async {
  final List<Directory> fileLists = <Directory>[
    Directory('../../assets/app/icons/')
  ];
  for (int i = 0; i < fileLists.length; i++) {
    final Directory directory = fileLists[i];
    await renameFile(directory);
    await moveFile(directory);
  }
}
