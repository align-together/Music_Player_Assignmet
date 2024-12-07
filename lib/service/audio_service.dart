import 'dart:io';

import 'package:music_player/service/api_service.dart';
import 'package:path_provider/path_provider.dart';

class AudioService {
  static Future<String> getAudioFilePath() async {
    String url =
        "https://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3";

    Directory appDocDir = await getApplicationDocumentsDirectory();

    String filePath = '${appDocDir.path}/instant_crush.mp3';

    var response = await ApiService.get(url);
    if (response.statusCode != 200) {
      throw Exception('Error downloading file');
    }

    File file = File(filePath!);
    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }
}
