import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../../models/music_track.dart';

class MusicFilePickerDialog extends StatelessWidget {
  const MusicFilePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '音楽ファイルを選択',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: FutureBuilder<List<String>>(
                future: _loadMusicFiles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('音楽ファイルが見つかりません'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final filePath = snapshot.data![index];
                      final fileName = filePath.split('/').last;

                      return ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text(fileName),
                        onTap: () {
                          final track = MusicTrack(
                            id: index.toString(),
                            title: fileName.replaceAll('.mp3', ''),
                            artist: 'Unknown',
                            album: 'Local Music',
                            url: filePath,
                          );
                          Navigator.of(context).pop(track);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル'),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> _loadMusicFiles() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      
      // assets/music 内のMP3ファイルのパスを取得
      final musicFiles = manifestMap.keys
          .where((String key) => key.startsWith('assets/music/') && key.endsWith('.mp3'))
          .toList();
      
      return musicFiles;
    } catch (e) {
      print('Error loading music files: $e');
      return [];
    }
  }
}
