library cross_fade_carousel;

import 'dart:async';

import 'package:cross_fade_carousel/src_deps.dart';
import 'package:flutter/material.dart';

/// A configurable carousel that smoothly fades between its children widgets automagically
class CrossFadeCarousel extends StatefulWidget {
  const CrossFadeCarousel(
      {super.key,
      required this.children,
      this.aspectRatio = 2 / 1,
      this.autoSwitch = true,
      this.autoSwitchDuration = const Duration(seconds: 10),
      this.fadeColor = Colors.grey,
      this.fadeDuration = const Duration(milliseconds: 1200),
      this.pauseAutoSwitchAfterUserActivityDelay = const Duration(seconds: 15),
      this.showIndicator = true,
      this.indicatorColor = Colors.black,
      this.customIndicatorBuilder,
      this.onItemTap,
      this.borderRadius});

  @override
  State<CrossFadeCarousel> createState() => _CrossFadeCarouselState();

  /// The list of children to be displayed in the carousel.
  final List<Widget> children;

  /// The aspect ratio of the carousel. common values are 2/1 or 16/9.
  final double aspectRatio;

  /// Whether to auto switch between the items without any user input. Defaults to true.
  /// items switch in an infinite loop of the available items
  final bool autoSwitch;

  /// The duration to wait on each item before switching
  final Duration autoSwitchDuration;

  /// The color of the fade blend to be displayed
  final Color? fadeColor;

  /// The total duration of the fade transition
  final Duration fadeDuration;

  /// whether to show the default circular indicator - please note its only shown when there are at least 1 and at max 7 items
  /// for any custom behavior use customIndicator builder
  final bool showIndicator;

  /// Color of the default indicator
  final Color? indicatorColor;

  /// whether to round the edges of the carousel
  final BorderRadiusGeometry? borderRadius;

  /// custom builder for a custom indicator UI
  final Widget Function(int index, int total)? customIndicatorBuilder;

  /// callback for when items on the carousel are tapped.
  final Function(int index)? onItemTap;

  /// delay for which the auto scroll pauses after the last user gesture on the carousel
  final Duration pauseAutoSwitchAfterUserActivityDelay;
}

class _CrossFadeCarouselState extends State<CrossFadeCarousel> {
  int currentIndex = 0;

  bool showFade = false;

  Timer? autoSwitchTimer;

  Duration? _halfFade;

  Duration? _thirdFade;

  DateTime? lastUserInteracted;

  Duration get halfFade {
    _halfFade ??=
        Duration(milliseconds: widget.fadeDuration.inMilliseconds ~/ 2);
    return _halfFade!;
  }

  Duration get thirdFade {
    _thirdFade ??=
        Duration(milliseconds: widget.fadeDuration.inMilliseconds ~/ 3);
    return _thirdFade!;
  }

  @override
  void initState() {
    super.initState();
    if (widget.autoSwitch && widget.children.length > 1) {
      autoSwitchTimer = Timer.periodic(widget.autoSwitchDuration, (timer) {
        if (lastUserInteracted == null ||
            DateTime.now().difference(lastUserInteracted!).inSeconds >
                widget.pauseAutoSwitchAfterUserActivityDelay.inSeconds) {
          fadeAction();
        }
      });
    }
  }

  void markUserActivity() {
    lastUserInteracted = DateTime.now();
  }

  void fadeAction({bool toNext = true}) async {
    showFade = true;
    setState(() {});
    await Future.delayed(thirdFade);
    if (toNext) {
      currentIndex++;
    } else {
      currentIndex--;
    }
    if (toNext) {
      if (currentIndex >= widget.children.length) {
        currentIndex = 0;
      }
    } else {
      if (currentIndex < 0) {
        currentIndex = widget.children.length - 1;
      }
    }

    Future.delayed(halfFade, () {
      if (mounted) {
        setState(() {
          showFade = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    autoSwitchTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: GestureDetector(
              onTap: () {
                if (showFade) {
                  return;
                }
                if (widget.onItemTap != null) {
                  widget.onItemTap!(currentIndex);
                }
              },
              onHorizontalDragEnd: (details) {
                if (showFade || widget.children.length < 2) {
                  return;
                }

                /// on left swipe
                if (details.primaryVelocity! > 0) {
                  markUserActivity();
                  fadeAction(toNext: false);
                }

                /// on right swipe
                else if (details.primaryVelocity! < 0) {
                  markUserActivity();
                  fadeAction(toNext: true);
                }
              },
              child: Stack(
                children: [
                  widget.children[currentIndex].expandBothAxis,
                  AnimatedOpacity(
                    opacity: showFade ? 1 : 0,
                    duration: halfFade,
                    child: Container(
                      color: widget.fadeColor,
                    ).expandBothAxis,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.customIndicatorBuilder != null)
          widget.customIndicatorBuilder!(currentIndex, widget.children.length)
        else if (widget.children.length > 1 && widget.children.length < 8)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                widget.children.length,
                (index) => CircleContainer(
                      fillColor: widget.indicatorColor,
                      outlined: currentIndex != index,
                      radius: 3,
                    ).paddingAll4()),
          ).paddingVertical4()
      ],
    );
  }
}
