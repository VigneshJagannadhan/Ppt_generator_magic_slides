import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class PptService {
  Future<File> downloadFile(String url) async {
    final appDir = await getApplicationDocumentsDirectory();
    final downloadDir = Directory('${appDir.path}/downloads');

    if (!await downloadDir.exists()) {
      await downloadDir.create(recursive: true);
    }

    final filename = url.split('/').last;
    final filePath = '${downloadDir.path}/$filename';

    await Dio().download(url, filePath);
    return File(filePath);
  }

  Future<List<FileSystemEntity>> loadFiles() async {
    final appDir = await getApplicationDocumentsDirectory();
    final downloadDir = Directory('${appDir.path}/downloads');

    if (await downloadDir.exists()) {
      final list = downloadDir.listSync();
      return list;
    }
    return [];
  }
}
