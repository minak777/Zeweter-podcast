import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:zeweter_app/comments.dart'; // Update this import path

class Player extends StatefulWidget {
  final String title; // Podcast ID
  final String description; // Episode ID
  final String audioUrl;
  final String image;

  const Player({
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isCompleted = false;
  bool _isLoading = false; // Variable for loading state
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  // Initialize the AudioPlayer and set up listeners for various audio events
  void _initializePlayer() {
    _audioPlayer = AudioPlayer();

    // Listen for changes in player state (playing, paused, etc.)
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
          _isCompleted = state == PlayerState.completed;
          print('Player state changed: $_isPlaying, $_isCompleted');
        });
      }
    });

    // Listen for changes in audio duration
    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          _duration = duration;
        });
      }
    });

    // Listen for changes in audio position
    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });

    // Listen for when the audio completes
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _position = _duration;
          _isPlaying = false;
          _isCompleted = true;
        });
      }
      print('Audio completed');
    });

    // Start playing the audio
    _playAudio();
  }

  // Play the audio from the given URL
  void _playAudio() async {
    setState(() {
      _isLoading = true; // Show loading indicator when play button is tapped
    });

    try {
      await _audioPlayer.play(UrlSource(widget.audioUrl));
      if (mounted) {
        setState(() {
          _isLoading = false; // Hide loading indicator once audio starts
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false; // Hide loading indicator on error
        });
      }
      print('Error playing audio: $e');
    }
  }

  // Pause the audio
  void _pauseAudio() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }

  // Resume the audio playback
  void _resumeAudio() async {
    try {
      await _audioPlayer.resume();
    } catch (e) {
      print('Error resuming audio: $e');
    }
  }

  // Replay the audio from the start
  void _replayAudio() {
    _audioPlayer.stop();
    _audioPlayer.dispose(); // Dispose the current player
    _initializePlayer(); // Reinitialize player and start audio
    if (mounted) {
      setState(() {
        _isCompleted = false;
        _isPlaying = false;
        _position = Duration.zero;
        _isLoading = true; // Show loading indicator on replay
      });
    }
    print('Audio replayed from start');
  }

  // Seek forward 5 seconds in the audio
  void _seekForward() async {
    final newPosition = _position + Duration(seconds: 5);
    if (_duration.inSeconds > 0 && newPosition <= _duration) {
      try {
        await _audioPlayer.seek(newPosition);
      } catch (e) {
        print('Error seeking forward: $e');
      }
    } else {
      try {
        await _audioPlayer
            .seek(_duration); // Ensure we don't exceed the duration
      } catch (e) {
        print('Error seeking to end: $e');
      }
    }
  }

  // Seek backward 5 seconds in the audio
  void _seekBackward() async {
    final newPosition = _position - Duration(seconds: 5);
    if (_duration.inSeconds > 0 && newPosition >= Duration.zero) {
      try {
        await _audioPlayer.seek(newPosition);
      } catch (e) {
        print('Error seeking backward: $e');
      }
    } else {
      try {
        await _audioPlayer
            .seek(Duration.zero); // Ensure we don't go before the start
      } catch (e) {
        print('Error seeking to start: $e');
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  // Format the duration in MM:SS format
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _audioPlayer.stop();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          children: [
            Column(
              children: [
                // Image container taking up most of the available vertical space
                Expanded(
                  flex:
                      3, // Adjust this value to change the proportion of the screen height used by the image
                  child: widget.image.isNotEmpty
                      ? Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text('No Image Available'),
                        ),
                ),
                // Audio player controls and information
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(widget.description),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_formatDuration(_position)),
                              Text(_formatDuration(_duration)),
                            ],
                          ),
                          Slider(
                            value: _position.inSeconds.toDouble(),
                            max: _duration.inSeconds.toDouble(),
                            onChanged: (value) async {
                              final newPosition =
                                  Duration(seconds: value.toInt());
                              if (newPosition <= _duration) {
                                try {
                                  await _audioPlayer.seek(newPosition);
                                } catch (e) {
                                  print('Error seeking to position: $e');
                                }
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.replay_5), // Rewind 5 seconds
                                iconSize: 48,
                                onPressed: _seekBackward,
                              ),
                              IconButton(
                                icon: Icon(
                                  _isCompleted
                                      ? Icons
                                          .replay // Replay icon when audio is complete
                                      : (_isPlaying
                                          ? Icons.pause
                                          : Icons
                                              .play_arrow), // Play/Pause icons
                                ),
                                iconSize: 64,
                                onPressed: () {
                                  if (_isCompleted) {
                                    _replayAudio(); // Replay audio if it has finished
                                  } else if (_isPlaying) {
                                    _pauseAudio(); // Pause audio if it is currently playing
                                  } else {
                                    _playAudio(); // Play audio if it is paused
                                  }
                                },
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.forward_5), // Forward 5 seconds
                                iconSize: 48,
                                onPressed: _seekForward,
                              ),
                              IconButton(
                                iconSize: 35,
                                icon: Icon(Icons.comment),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => CommentSection(
                                      description: widget.description,
                                      title: widget.title,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_isLoading)
              Positioned(
                bottom: 135, // Position the loading indicator above the slider
                left: 0,
                right: 0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
