import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioPlayerScreen(),
    );
  }
}

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState()  {
    super.initState();
    // await AudioPlayer.clearAssetCache()
    audioPlayer = AudioPlayer();
    
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    audioPlayer.onPlayerStateChanged.listen((event) { 
      if (event == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });
   
  }

  Future<void> playAudio() async {

    final player = AudioPlayer();
    // await player.play(UrlSource('https://example.com/my-audio.wav'));
    // await player.play(UrlSource('http://localhost:5000/audio/english/z'));
    // await player.play(AssetSource( 'z.mp3'));
    await player.play(AssetSource( 'audio/z.mp3'));

    // await audioPlayer.play('assets/z.mp3', isLocal: true);
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> resumeAudio() async {
    await audioPlayer.resume();
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Audio Player',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            IconButton(
              iconSize: 64,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                if (isPlaying) {
                  pauseAudio();
                } else {
                  playAudio();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
