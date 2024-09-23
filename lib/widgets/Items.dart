import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/Sound.dart';

class Items extends StatelessWidget {
  final Sound? sounds;
  final Sound? currentlyPlayingSound; // Add this parameter
  final Function(Sound) onSoundSelected; // Callback function

  Items({
    Key? key,
    required this.sounds,
    required this.currentlyPlayingSound, // Add this to the constructor
    required this.onSoundSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = currentlyPlayingSound == sounds; // Check if this sound is the currently playing one

    return GestureDetector(
      onTap: () {
        onSoundSelected(sounds!);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // Adjusted padding
        child: Container(
          width: double.infinity,
          height: 100, // Increased height for a more substantial look
          decoration: BoxDecoration(
            color: isPlaying ? Color(0xFFE8B5E0) : Colors.white.withOpacity(0.8), // Highlight the playing item with soft pink
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5), // Shadow effect
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Rounded image corners
                  child: Image.asset(
                    sounds?.image ?? 'assets/images/music1.jpg',
                    width: 80, // Increased width for a larger image
                    height: 80, // Increased height for a larger image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center align text
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sounds?.text ?? 'No Title',
                      style: TextStyle(
                        color: Color(0xFF3D0B40), // Dark text for readability
                        fontSize: 20, // Increased font size for better readability
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Artist Name', // Placeholder for artist name
                      style: TextStyle(
                        color: Color(0xFF3D0B40), // Dark color for consistency
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // Removed the IconButton
            ],
          ),
        ),
      ),
    );
  }
}
