import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier{
  //playlist of songs
  final List<Song> _playlist = [
    //song 1
    Song(
        songName: "Children of zion",
        artistName: "Musical youth",
        albumArtImagePath: "assets/image/a-birmingham-based-reggae-group-musical-youth-who-have-soared-to-the-G5XXRK.jpg",
        audioPath: "audio/Musical-Youth-Children-Of-Zion.mp3",
    ),
//song 2
    Song(
      songName: "Heart breaker",
      artistName: "Musical youth",
      albumArtImagePath: "assets/image/musical-youth-promotional-photo-of-uk-reggae-group-about-1982-from-EP09TE.jpg",
      audioPath: "audio/Musical-Youth-Heartbreaker.mp3",
    ),
  //song 3
    Song(
      songName: "pass the Dutchie",
      artistName: "Musical youth",
      albumArtImagePath: "assets/image/musical-youth-the-youth-of-today-large-poster-nm-nm-12-lp-vintage-vinyl-record-cover-2DP2HT4.jpg",
      audioPath: "audio/Musical_Youth_-_Pass_The_Dutchie.mp3",
    ),
  ];
  //current song playing index
int? _currentSongIndex;

/*
A U D I O P L A Y E R
 */

  //audio player
   final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider() {
    listenToDurations();
  }

  //initially not playing
  bool _isPlaying = false;

  //play the song
 void play() async {
   final String path = _playlist[_currentSongIndex!].audioPath;
   await _audioPlayer.stop(); //stop current song
   await _audioPlayer.play(AssetSource(path));//play the new song
   _isPlaying = true;
   notifyListeners();
 }

  //pause
  void pause() async{
   await _audioPlayer.pause();
   _isPlaying = false;
   notifyListeners();
  }

  //resume
  void resume() async{
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
   if (_isPlaying) {
     pause();
   } else {
     resume();
   }
   notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
   await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
   if (_currentSongIndex != null) {
     if (_currentSongIndex! < _playlist.length -1) {
       //go to the next song if its not the last song
       currentSongIndex = _currentSongIndex! + 1;
     } else {
       //if its the last song ,loop back to the first song
       currentSongIndex = 0;
     }
   }
  }

  //play previous song
  void playPreviousSong() {
    //if more than 2 seconds have passed, restart the current song
    if(_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    //if its within first 2 second of the song,go to previous song
    else {
      if(_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! -1;
      } else {
        //if its the first song,loop back to the last song
        currentSongIndex =_currentSongIndex! - 1;
      }
    }
  }

  //listen to durations
  void listenToDurations() {
    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //dispose audio player

/*
G E T T E R S
 */
List<Song> get playlist => _playlist;
int? get currentSongIndex => _currentSongIndex;
bool get isPlaying => _isPlaying;
Duration get currentDuration => _currentDuration;
Duration get totalDuration => _totalDuration;
/*
S E T T E R S
 */
set currentSongIndex(int? newIndex) {
  //update current song index
  _currentSongIndex = newIndex;

  if(newIndex != null) {
    play();//play the song at the new index
  }

  //update UI
  notifyListeners();
}

}