import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AlphabetsScreen extends StatefulWidget {
  const AlphabetsScreen({Key? key}) : super(key: key);

  @override
  State<AlphabetsScreen> createState() => _AlphabetsScreenState();
}

class _AlphabetsScreenState extends State<AlphabetsScreen> {
  static const List<String> alphabets = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  static const List<Color> cardColors = [
    Color(0xFFFFCDD2), Color(0xFFFFE0B2), Color(0xFFFFFF8D), Color(0xFFC8E6C9),
    Color(0xFFBBDEFB), Color(0xFFE1BEE7), Color(0xFFF8BBD0), Color(0xFFB2DFDB),
    Color(0xFFB3E5FC), Color(0xFFFFF9C4), Color(0xFFFFCCBC), Color(0xFFD1C4E9),
    Color(0xFFF0F4C3), Color(0xFFB2EBF2), Color(0xFFD7CCC8), Color(0xFFCFD8DC),
    Color(0xFFE6EE9C), Color(0xFFE1BEE7), Color(0xFFFFE082), Color(0xFFB2DFDB),
    Color(0xFFFFF59D), Color(0xFFB2EBF2), Color(0xFFF8BBD0), Color(0xFFF0F4C3),
    Color(0xFFFFF9C4),
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlayingFull = false;
  int _pressedIndex = -1;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlayingFull = false;
        _pressedIndex = -1;
      });
    });
  }

  Future<void> _playLetterSound(int index) async {
    setState(() {
      _pressedIndex = index;
      _isPlayingFull = false;
    });
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('audio/${alphabets[index]}.mp3'));
    } catch (e) {
      print('Error playing letter sound: $e');
    }
    await Future.delayed(const Duration(milliseconds: 180));
    setState(() {
      _pressedIndex = -1;
    });
  }

  Future<void> _toggleFullAlphabet() async {
    if (_isPlayingFull) {
      await _audioPlayer.stop();
      setState(() {
        _isPlayingFull = false;
      });
    } else {
      setState(() {
        _isPlayingFull = true;
        _pressedIndex = -1;
      });
      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(AssetSource('audio/abc_full.mp3'));
      } catch (e) {
        print('Error playing full alphabet: $e');
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double gridSpacing = 12;
    const int crossAxisCount = 4;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardSize = (screenWidth - (gridSpacing * (crossAxisCount + 1))) / crossAxisCount;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Alphabets'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isPlayingFull ? Icons.volume_up : Icons.volume_off,
              size: 30,
              color: Colors.white,
            ),
            tooltip: _isPlayingFull ? "Pause ABCD" : "Play full ABCD",
            onPressed: _toggleFullAlphabet,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: alphabets.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: gridSpacing,
            mainAxisSpacing: gridSpacing,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final isPressed = _pressedIndex == index;
            return GestureDetector(
              onTap: () => _playLetterSound(index),
              child: AnimatedScale(
                scale: isPressed ? 0.93 : 1.0,
                duration: const Duration(milliseconds: 120),
                child: Container(
                  width: cardSize,
                  height: cardSize,
                  decoration: BoxDecoration(
                    color: cardColors[index % cardColors.length],
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      if (!isPressed)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 6,
                          offset: const Offset(2, 4),
                        ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      alphabets[index],
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}