import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../business_logic/firestore_database_service.dart';

class VideoPlayingScreen extends StatefulWidget {
  VideoPlayingScreen({super.key, required this.videoUrl, this.title});
  String videoUrl;
  String? title;
  @override
  State<VideoPlayingScreen> createState() => _VideoPlayingScreenState();
}

bool isVideoPlaying = false;

class _VideoPlayingScreenState extends State<VideoPlayingScreen>
    with WidgetsBindingObserver {
  late YoutubePlayerController _youtubePlayerController;
  bool _isPlayerReady = false;
  bool? isUserListening;
  FirestoreDatabaseService _service = FirestoreDatabaseService();

  late YoutubeMetaData _videoMetaData;

  @override
  void dispose() {
    _service.updateIsUserListening(false, widget.videoUrl);
    WidgetsBinding.instance.removeObserver(this);
    print("Videodan çıkıldı");
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _videoMetaData = const YoutubeMetaData();
    final videoID = YoutubePlayer.convertUrlToId(widget.videoUrl);

    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
            hideThumbnail: true,
            //  hideControls: false,
            controlsVisibleAtStart: true,
            autoPlay: true,
            showLiveFullscreenButton: true))
      ..addListener(listener);

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void listener() async {
    int index = 0;
    await _service.updateIsUserListening(
      _youtubePlayerController.value.isPlaying,
      widget.videoUrl,
    );
    print(" Video oynatılıyor mu? ${_youtubePlayerController.value.isPlaying}");
    // print(" Player state: ${_youtubePlayerController.value.playerState}");
    if (_youtubePlayerController.value.playerState == PlayerState.ended) {
      await _service.updateIsUserListening(false, widget.videoUrl);
    }
    _videoMetaData = _youtubePlayerController.metadata;
    _service.getUserDatasToMatch(widget.videoUrl,
        _youtubePlayerController.value.isPlaying, widget.title);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App'ten direkt olarak çıkış yaptığımızda aşağıdaki kod çalışır.
    print("Life cycle state: $state");
    if (state == AppLifecycleState.paused) {
      _service.updateIsUserListening(false, widget.videoUrl);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            onReady: () {
              print("Video açıldı.");
              _isPlayerReady = true;

              if (mounted) {
                setState(() {});
              }
            },
            controller: _youtubePlayerController,
            showVideoProgressIndicator: true,
            bottomActions: [
              FullScreenButton(),
              CurrentPosition(controller: _youtubePlayerController),
              Expanded(
                  child: ProgressBar(
                controller: _youtubePlayerController,
              )),
            ],
          ),
          builder: (context, player) {
            return Scaffold(
                backgroundColor: const Color.fromARGB(255, 243, 248, 255),
                body: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: player));
          },
        ),
      ),
    );
  }
}
