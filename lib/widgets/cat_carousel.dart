import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/breed_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatCarousel extends StatelessWidget {
  const CatCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final imgs = context.watch<BreedProvider>().images;
    if (imgs.isEmpty) return const SizedBox.shrink();
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.3,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
      items:
          imgs.map((ci) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: ci.url,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder:
                    (_, __) => const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => const Icon(Icons.error),
              ),
            );
          }).toList(),
    );
  }
}
