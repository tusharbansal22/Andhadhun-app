import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioRecorder extends StatelessWidget {
  final record = Record();
  String downloadsDirectory = '';

  Future<File> getRecordingFile(String pathName) async {
    // Directory tempDir = await getTemporaryDirectory();
    // String filePath = '${tempDir.path}/filename';
    File recordingFile = File(pathName);
    print(recordingFile);
    return recordingFile;
  }

  // Future<String?> uploadRecordingFile(File fileArg) async {
  //   // File recordingFile = await getRecordingFile();
  //   File recordingFile = fileArg;
  //   String url = 'http://10.3.13.139:3000/api/upload';
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   var multipartFile = http.MultipartFile.fromBytes(
  //     'file',
  //     await recordingFile.readAsBytes(),
  //     filename: 'userVoicePacket',
  //   );
  //   request.files.add(multipartFile);
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     return response.reasonPhrase;
  //   } else {
  //     throw Exception('Failed to upload file: ${response.reasonPhrase}');
  //   }
  // }

  Future<void> sendAudioToServer(File audioFile) async {
    // Open the audio file as a stream
    final stream = http.ByteStream(audioFile.openRead());

    // Get the file length
    final length = await audioFile.length();

    // Create the multipart request
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.3.13.139:3000/api/upload-audio'),
    );

    // Add the audio file to the request as a multipart/form-data field
    final multipartFile = http.MultipartFile(
      'audio',
      stream,
      length,
      filename: audioFile.path.split('/').last,
      contentType: MediaType('audio', 'm4a'),
    );
    request.files.add(multipartFile);

    // Send the request and wait for the response
    try {
      final response = await request.send();
      print('Response status code: ${response.statusCode}');
    } catch (e) {
      print(e);
    }

    // Print the response status code
  }

  // Future<void> getPhonePath() async {
  //   final directory = await getExternalStorageDirectory();
  //   downloadsDirectory = '${directory?.path}/Download';
  //   print(downloadsDirectory);
  // }

  // void saveFile() async {
  //   final result = await FilePicker.platform.showSavePanel(
  //     suggestedFileName: 'myFile.m4a',
  //     allowedFileTypes: ['m4a'],
  //   );
  //
  //   if (result != null) {
  //     // Get the file path
  //     String filePath = result.paths[0];
  //
  //     // Do something with the file
  //     print(filePath);
  //   }
  // }

  Future<bool> _requestPermission() async {
    // Check if the user has granted storage permission
    if (await Permission.storage.isGranted) {
      return true;
    }

    // Request storage permission
    final result = await Permission.storage.request();

    // Return true if the user grants the permission
    return result == PermissionStatus.granted;
  }

  // @override
  // void initState() {
  //   getPhonePath();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder'),
      ),
      body: Container(
        child: ElevatedButton(
          child: Text('Click me!'),
          onPressed: () async {
            if (await record.hasPermission()) {
              // Request storage permission
              bool isPermissionGranted = await _requestPermission();

              if (isPermissionGranted) {
                await record.start(
                  // path: '/storage/emulated/0/Download/lecture3.pdf',
                  encoder: AudioEncoder.aacLc, // by default
                  bitRate: 128000, // by default
                  // sampleRate: 44100, // by default
                );
                Fluttertoast.showToast(msg: 'Recording started');
              }
            }
          },
          onLongPress: () async {
            if (await record.isRecording()) {
              final path = await record.stop();
              final userAudioPacket = await getRecordingFile(path!);
              // uploadRecordingFile(userAudioPacket);
              sendAudioToServer(userAudioPacket);
              Fluttertoast.showToast(msg: 'Recording stopped: $path');
            }
          },
        ),
      ),
    );
  }
}

// GestureDetector(
// onTap: () async {
//   if (await record.hasPermission()) {
//     await record.start(
//       path: '$downloadsDirectory/temp.m4a',
//       encoder: AudioEncoder.aacLc, // by default
//       bitRate: 128000, // by default
//       // sampleRate: 44100, // by default
//     );
//     Fluttertoast.showToast(msg: 'Recording started');
//   }
// },
// onDoubleTap: () async {
//   if (await record.isRecording()) {
//     final path = await record.stop();
//     Fluttertoast.showToast(msg: 'Recording stopped: $path');
//   }
// },
