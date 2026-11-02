import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/url_helper.dart';

/// Video card showing [AppAssets.mediaplayer] thumbnail or inline YouTube player.
class VideoThumbnail extends StatefulWidget {
  const VideoThumbnail({super.key, this.onTap, this.videoId = 'bP4U-L4EHcg'});

  final VoidCallback? onTap;
  final String videoId;

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  YoutubePlayerController? _controller;
  bool _isPlaying = false;

  void _onPlay() {
    widget.onTap?.call();
    try {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: widget.videoId,
        params: const YoutubePlayerParams(showControls: true, showFullscreenButton: true),
      );
      setState(() => _isPlaying = true);
    } catch (_) {
      UrlHelper.launchYouTube(widget.videoId);
    }
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.homeVideoBorderRadius),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cardBorder,
          border: Border.all(color: AppColors.cardBorder, width: AppDimens.homeVideoBorderWidth),
          borderRadius: BorderRadius.circular(AppDimens.homeVideoBorderRadius),
        ),
        child: _isPlaying && _controller != null
            ? AspectRatio(aspectRatio: 16 / 9, child: YoutubePlayer(controller: _controller!))
            : GestureDetector(
                onTap: _onPlay,
                child: AspectRatio(
                  aspectRatio: 1835 / 1017,
                  child: Image.asset(AppAssets.mediaplayer, fit: BoxFit.cover),
                ),
              ),
      ),
    );
  }
}
