import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:better_player_plus/better_player_plus.dart';

class ProductDetailsPageVideo extends StatefulWidget {
  final String videoUrl;

  const ProductDetailsPageVideo({
    super.key,
    required this.videoUrl,
  });

  @override
  State<ProductDetailsPageVideo> createState() =>
      _ProductDetailsPageVideoState();
}

class _ProductDetailsPageVideoState
    extends State<ProductDetailsPageVideo>
    with WidgetsBindingObserver {

  /// ✅ Better Player Controller
  BetterPlayerController? _betterPlayerController;

  /// ✅ YouTube Controller
  YoutubePlayerController? _youtubeController;

  bool isInitialized = false;
  bool isYouTube = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {

    try {

      /// ✅ Check YouTube URL
      String? videoId =
      YoutubePlayer.convertUrlToId(
        widget.videoUrl,
      );

      /// =========================
      /// ✅ YOUTUBE VIDEO
      /// =========================

      if (videoId != null) {

        isYouTube = true;

        _youtubeController =
            YoutubePlayerController(

              initialVideoId: videoId,

              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
                loop: false,
                forceHD: false,
                enableCaption: false,
              ),
            );

        if (mounted) {
          setState(() {
            isInitialized = true;
          });
        }
      }

      /// =========================
      /// ✅ MP4 / NETWORK VIDEO
      /// =========================

      else {

        isYouTube = false;

        BetterPlayerDataSource
        betterPlayerDataSource =

        BetterPlayerDataSource(

          BetterPlayerDataSourceType.network,

          widget.videoUrl,

          /// ✅ CACHE
          cacheConfiguration:
          const BetterPlayerCacheConfiguration(

            useCache: true,

            preCacheSize:
            10 * 1024 * 1024,

            maxCacheSize:
            100 * 1024 * 1024,

            maxCacheFileSize:
            50 * 1024 * 1024,
          ),

          /// ✅ BUFFERING
          bufferingConfiguration:
          const BetterPlayerBufferingConfiguration(

            minBufferMs: 2000,

            maxBufferMs: 10000,

            bufferForPlaybackMs: 1000,

            bufferForPlaybackAfterRebufferMs:
            2000,
          ),
        );

        /// ✅ PLAYER CONFIG
        _betterPlayerController =
            BetterPlayerController(

              const BetterPlayerConfiguration(

                autoPlay: false,

                looping: true,

                fit: BoxFit.contain,

                aspectRatio: 16 / 9,

                allowedScreenSleep: false,

                autoDispose: true,

                expandToFill: false,

                handleLifecycle: true,

                fullScreenByDefault: false,

                autoDetectFullscreenDeviceOrientation:
                true,

                controlsConfiguration:
                BetterPlayerControlsConfiguration(

                  enablePlayPause: true,

                  enableMute: true,

                  enableFullscreen: true,

                  enableProgressBar: true,

                  enableProgressText: true,

                  enableSkips: true,

                  enableOverflowMenu: true,

                  showControlsOnInitialize: false,
                ),

                placeholder: Center(
                  child:
                  CircularProgressIndicator(),
                ),
              ),
            );

        /// ✅ SET VIDEO SOURCE
        await _betterPlayerController!
            .setupDataSource(
          betterPlayerDataSource,
        );

        if (mounted) {
          setState(() {
            isInitialized = true;
          });
        }
      }

    } catch (e) {

      debugPrint(
        "VIDEO ERROR: $e",
      );

      if (mounted) {
        setState(() {
          hasError = true;
        });
      }
    }
  }

  /// ✅ APP BACKGROUND HANDLING
  @override
  void didChangeAppLifecycleState(
      AppLifecycleState state) {

    if (state ==
        AppLifecycleState.paused) {

      _betterPlayerController?.pause();

      _youtubeController?.pause();
    }
  }

  @override
  void dispose() {

    WidgetsBinding.instance
        .removeObserver(this);

    _betterPlayerController?.dispose();

    _youtubeController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// =========================
    /// ❌ ERROR UI
    /// =========================

    if (hasError) {

      return Container(
        height: 250,
        color: Colors.black,

        child: const Center(
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 40,
              ),

              SizedBox(height: 10),

              Text(
                "Video failed to load",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    /// =========================
    /// 🔄 LOADING
    /// =========================

    if (!isInitialized) {

      return Container(
        height: 250,
        color: Colors.black,

        child: const Center(
          child:
          CircularProgressIndicator(),
        ),
      );
    }

    /// =========================
    /// ✅ YOUTUBE PLAYER
    /// =========================

    if (isYouTube &&
        _youtubeController != null) {

      return ClipRRect(

        borderRadius:
        BorderRadius.circular(12),

        child: YoutubePlayer(

          controller:
          _youtubeController!,

          showVideoProgressIndicator:
          true,

          progressIndicatorColor:
          Colors.pink,

          progressColors:
          const ProgressBarColors(

            playedColor: Colors.pink,

            handleColor:
            Colors.pinkAccent,
          ),
        ),
      );
    }

    /// =========================
    /// ✅ BETTER PLAYER
    /// =========================

    if (_betterPlayerController !=
        null) {

      return ClipRRect(

        borderRadius:
        BorderRadius.circular(12),

        child: AspectRatio(

          aspectRatio: 16 / 9,

          child: BetterPlayer(

            controller:
            _betterPlayerController!,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}