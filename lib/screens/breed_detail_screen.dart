import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../providers/breed_provider.dart';
import '../widgets/breed_dropdown.dart';
import '../widgets/cat_carousel.dart';

class BreedDetailScreen extends StatelessWidget {
  const BreedDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<BreedProvider>();
    final b = prov.selected;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const Text(
                'Selecciona una raza',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const BreedDropdown(),
              const SizedBox(height: 16),
              const CatCarousel(),
              const SizedBox(height: 24),
              if (b != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      b.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        Chip(label: Text('Origen: ${b.origin}')),
                        Chip(label: Text('Vida: ${b.lifeSpan} años')),
                        Chip(label: Text('Inteligencia: ${b.intelligence}/5')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      b.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => Scaffold(
                                  appBar: AppBar(
                                    title: Text('Wikipedia - ${b.name}'),
                                  ),
                                  body: WebViewWidget(
                                    controller:
                                        WebViewController()..loadRequest(
                                          Uri.parse(b.wikipediaUrl),
                                        ),
                                  ),
                                ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.language),
                      label: const Text('Leer más en Wikipedia'),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
