<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Cross Fade Carousel

A beautiful and customizable Flutter carousel widget that smoothly fades between its children widgets. Perfect for creating engaging image galleries, feature showcases, or promotional content in your Flutter applications.

## Features

- 🎭 Smooth cross-fade transitions between items
- 🔄 Automatic switching between items
- 👆 Touch gesture support (swipe left/right)
- ⚙️ Highly customizable appearance
- 🎯 Built-in indicator dots
- 🎨 Custom indicator support
- 📱 Responsive design with configurable aspect ratio
- ⏱️ Configurable timing and delays
- 🔒 Pause auto-switching after user interaction

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  cross_fade_carousel: ^1.0.0
```

## Usage

Here's a simple example of how to use the Cross Fade Carousel:

```dart
import 'package:flutter/material.dart';
import 'package:cross_fade_carousel/cross_fade_carousel.dart';

class MyCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CrossFadeCarousel(
      children: [
        Image.network('https://example.com/image1.jpg'),
        Image.network('https://example.com/image2.jpg'),
        Image.network('https://example.com/image3.jpg'),
      ],
      aspectRatio: 16 / 9,
      autoSwitch: true,
      autoSwitchDuration: Duration(seconds: 5),
      fadeDuration: Duration(milliseconds: 1200),
      onItemTap: (index) {
        print('Tapped item at index: $index');
      },
    );
  }
}
```

## Customization Options

The `CrossFadeCarousel` widget accepts the following parameters:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `children` | `List<Widget>` | Required | The list of widgets to display in the carousel |
| `aspectRatio` | `double` | `2/1` | The aspect ratio of the carousel (e.g., 16/9, 2/1) |
| `autoSwitch` | `bool` | `true` | Whether to automatically switch between items |
| `autoSwitchDuration` | `Duration` | `10 seconds` | Duration to display each item before switching |
| `fadeColor` | `Color?` | `Colors.grey` | Color of the fade transition |
| `fadeDuration` | `Duration` | `1200ms` | Duration of the fade transition |
| `showIndicator` | `bool` | `true` | Whether to show the default indicator dots |
| `indicatorColor` | `Color?` | `Colors.black` | Color of the indicator dots |
| `borderRadius` | `BorderRadiusGeometry?` | `null` | Border radius for the carousel container |
| `customIndicatorBuilder` | `Widget Function(int, int)?` | `null` | Custom builder for indicator UI |
| `onItemTap` | `Function(int)?` | `null` | Callback when an item is tapped |
| `pauseAutoSwitchAfterUserActivityDelay` | `Duration` | `15 seconds` | Delay before resuming auto-switch after user interaction |
| `onIndexChanged` | `Function(int)?` | `null` | Callback when the index of the current item changes return the current index |

## Gesture Support

The carousel supports the following gestures:
- Swipe left to go to the next item
- Swipe right to go to the previous item
- Tap on an item to trigger the `onItemTap` callback

## Notes

- The default indicator dots are only shown when there are 2-7 items
- For custom indicator behavior, use the `customIndicatorBuilder`
- Auto-switching pauses temporarily after user interaction
- The carousel supports infinite looping through items

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.Developed by [Rohan Kumar Panigrahi](https://www.linkedin.com/in/rohan-kumar-panigrahi-187a12193/) at [RaftLabs](https://www.raftlabs.com/).
