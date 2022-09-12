import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:terapizone/core/services/assets_service.dart';
import 'package:terapizone/features/messages/model/chat_details_response_model.dart';

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class AudioMessageContainer extends StatefulWidget {
  const AudioMessageContainer({
    Key? key,
    required this.message,
  }) : super(key: key);
  final ChatDetailsModel message;

  @override
  State<AudioMessageContainer> createState() => _AudioMessageContainerState();
}

class _AudioMessageContainerState extends State<AudioMessageContainer> {
  final _player = AudioPlayer();
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _player.playbackEventStream.listen(
      (event) {},
      onError: (Object e, StackTrace stackTrace) {
        print('A stream error occurred: $e');
      },
    );
    _player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        _player.stop();
        _player.seek(Duration.zero);
        setState(() {
          isPlaying = false;
        });
      }
    });

    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(widget.message.fileUrl!),
        ),
      );
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero));

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 35),
      child: Row(
        children: [
          // _buildChatAvatar(),
          const SizedBox(width: 8),
          InkWell(
            onTap: () async {
              if (isPlaying) {
                setState(() {
                  isPlaying = false;
                });
                await _player.pause();
              } else {
                _player.play();
                setState(() {
                  isPlaying = true;
                });
              }
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: isPlaying
                  ? const Icon(
                      Icons.pause_rounded,
                      color: Colors.black,
                      size: 17,
                    )
                  : const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.black,
                      size: 17,
                    ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    thumbColor: Colors.white,
                    activeTrackColor: Colors.white,
                    overlayColor: const Color.fromRGBO(109, 66, 239, 0.08),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                    trackHeight: 2,
                  ),
                  child: StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Slider(
                                inactiveColor: const Color.fromRGBO(229, 233, 241, 1),
                                min: 0,
                                max: positionData?.duration.inMilliseconds.toDouble() ??
                                    Duration.zero.inMilliseconds.toDouble(),
                                value: positionData?.position.inMilliseconds.toDouble() ??
                                    Duration.zero.inMilliseconds.toDouble(),
                                onChanged: (value) async {
                                  final position = Duration(seconds: value.toInt());
                                  await _player.seek(position);
                                  await _player.play();
                                },
                              ),
                            ),
                            Text(
                              formatTime((positionData?.duration ?? Duration.zero) -
                                  (positionData?.position ?? Duration.zero)),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack _buildChatAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
        ),
      ],
    );
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes);
  final seconds = twoDigits(duration.inSeconds % 60);
  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(":");
}
