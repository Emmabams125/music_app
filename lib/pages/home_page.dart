import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/models/playlist_provider.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the playlist provider
  late PlaylistProvider playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  //go to a song
  void goToSong(int songIndex) {
    //update current song index using the playlistProvider instance
    playlistProvider.currentSongIndex = songIndex;

    //Navigate to the song page (assuming you have a SongPage widget)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongPage(), // Ensure SongPage is properly defined
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("P L A Y L I S T"),
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          // get the playlist
          final List<Song> playlist = value.playlist;

          // return ListView.builder
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // get individual song
              final Song song = playlist[index];

              // return ListTile UI
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: SizedBox(
                  width: 50.0, // Set the width and height of the album art
                  height: 50.0,
                  child: Image.asset(song.albumArtImagePath, fit: BoxFit.cover),
                ),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}



