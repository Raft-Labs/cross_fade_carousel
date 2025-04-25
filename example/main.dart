import 'package:flutter/material.dart';
import 'package:cross_fade_carousel/cross_fade_carousel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cross Fade Carousel Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cross Fade Carousel Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Basic Carousel',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CrossFadeCarousel(
                children: [
                  _buildCarouselItem('1', Colors.blue),
                  _buildCarouselItem('2', Colors.green),
                  _buildCarouselItem('3', Colors.orange),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Custom Aspect Ratio (16:9)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CrossFadeCarousel(
                aspectRatio: 16 / 9,
                children: [
                  _buildCarouselItem('1', Colors.purple),
                  _buildCarouselItem('2', Colors.red),
                  _buildCarouselItem('3', Colors.teal),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Custom Styling',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CrossFadeCarousel(
                borderRadius: BorderRadius.circular(16),
                fadeColor: Colors.black.withOpacity(0.5),
                fadeDuration: const Duration(milliseconds: 800),
                autoSwitchDuration: const Duration(seconds: 5),
                children: [
                  _buildCarouselItem('1', Colors.indigo),
                  _buildCarouselItem('2', Colors.pink),
                  _buildCarouselItem('3', Colors.amber),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Custom Indicator',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CrossFadeCarousel(
                showIndicator: false,
                customIndicatorBuilder: (index, total) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      total,
                      (i) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == index
                              ? Colors.blue
                              : Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  );
                },
                children: [
                  _buildCarouselItem('1', Colors.deepOrange),
                  _buildCarouselItem('2', Colors.lightBlue),
                  _buildCarouselItem('3', Colors.lime),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselItem(String number, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Item $number',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
