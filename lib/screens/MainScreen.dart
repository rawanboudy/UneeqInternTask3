import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Import AudioPlayers
import 'package:music_app/Models/Sound.dart';
import 'package:music_app/widgets/Items.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Sound> sounds = [
    Sound(text: 'Pefect', sound: 'sounds/town-10169.mp3', image: 'assets/images/music1.jpg'),
    Sound(text: 'Shape of you', sound: 'sounds/Ed Sheeran - Shape Of You (Lyrics).mp3', image: 'assets/images/shape_of_you.jpg'),

    Sound(text: 'Dance monkey', sound: 'sounds/acoustic-guitar-loop-f-91bpm-132687.mp3', image: 'assets/images/music1.jpg'),
    Sound(text: 'Closer', sound: 'sounds/chinese-beat-190047.mp3', image: 'assets/images/music1.jpg'),
    Sound(text: 'All of me', sound: 'sounds/clean-trap-loop-131bpm-136738.mp3', image: 'assets/images/music1.jpg'),
    Sound(text: 'Piano', sound: 'sounds/pianos-by-jtwayne-7-174717.mp3', image: 'assets/images/music1.jpg'),
    Sound(text: 'Sunflower', sound: 'sounds/sunflower-street-drumloop-85bpm-163900.mp3', image: 'assets/images/music1.jpg'),
    Sound(text: 'Timbo', sound: 'sounds/timbo-drumline-loop-103bpm-171091.mp3', image: 'assets/images/music1.jpg'),
  ];

  Sound? currentlyPlayingSound;
  final AudioPlayer player = AudioPlayer();

  Future<void> playSound(Sound sound) async {
    if (currentlyPlayingSound != null && currentlyPlayingSound != sound) {
      await player.stop();
      setState(() {
        currentlyPlayingSound = null;
      });
    }

    if (currentlyPlayingSound == sound) {
      await player.pause();
      setState(() {
        currentlyPlayingSound = null;
      });
    } else {
      try {
        await player.play(AssetSource(sound.sound));
        setState(() {
          currentlyPlayingSound = sound;
        });
      } catch (e) {
        print('AudioPlayers Exception: $e');
      }
    }
  }

  void playNextSound() {
    if (currentlyPlayingSound != null) {
      int currentIndex = sounds.indexOf(currentlyPlayingSound!);
      playSound(sounds[(currentIndex + 1) % sounds.length]);
    } else {
      playSound(sounds[0]);
    }
  }

  void playPreviousSound() {
    if (currentlyPlayingSound != null) {
      int currentIndex = sounds.indexOf(currentlyPlayingSound!);
      playSound(sounds[(currentIndex - 1 + sounds.length) % sounds.length]);
    } else {
      playSound(sounds[0]);
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE8B5E0), // Soft pink
              Color(0xFFF4F1B3), // Light cream
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: Text(
                'My Playlist',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF3D0B40), // Darker text color for contrast
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: sounds.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Items(
                      sounds: sounds[index],
                      currentlyPlayingSound: currentlyPlayingSound,
                      onSoundSelected: playSound,
                    ),
                  );
                },
              ),
            ),
            // Bottom controls
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFFAE3C2), // Light cream for controls
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (currentlyPlayingSound != null)
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(currentlyPlayingSound!.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  SizedBox(height: 10),
                  Text(
                    currentlyPlayingSound?.text ?? 'Select a song',
                    style: TextStyle(color: Color(0xFF3D0B40), fontSize: 18), // Text color
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.skip_previous, color: Color(0xFF3D0B40), size: 30),
                        onPressed: playPreviousSound,
                      ),
                      IconButton(
                        icon: Icon(
                          currentlyPlayingSound != null ? Icons.pause : Icons.play_arrow,
                          color: Color(0xFF3D0B40),
                          size: 40,
                        ),
                        onPressed: () {
                          if (currentlyPlayingSound != null) {
                            playSound(currentlyPlayingSound!);
                          } else {
                            playSound(sounds[0]);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next, color: Color(0xFF3D0B40), size: 30),
                        onPressed: playNextSound,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
