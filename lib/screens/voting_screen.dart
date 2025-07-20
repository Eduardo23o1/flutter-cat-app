import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/voting_provider.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VotingProvider(),
      child: Consumer<VotingProvider>(
        builder: (context, prov, _) {
          final breed = prov.current;
          final imageUrl = prov.currentImageUrl;

          if (prov.hasError) {
            return const Center(
              child: Text(
                'No se pudo cargar la información de las razas.',
                style: TextStyle(fontSize: 16, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (prov.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (breed == null || imageUrl == null) {
            return const Center(
              child: Text(
                'No hay razas disponibles en este momento.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Dismissible(
                  key: ValueKey(breed.id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (_) => prov.vote(true),
                  background: Container(color: Colors.green),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder:
                                (_, __) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                breed.name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FilledButton.tonalIcon(
                                    icon: const Icon(Icons.thumb_up),
                                    label: const Text('Me gusta'),
                                    onPressed: () => prov.vote(true),
                                  ),
                                  const SizedBox(width: 24),
                                  FilledButton.tonalIcon(
                                    icon: const Icon(Icons.thumb_down),
                                    label: const Text('No me gusta'),
                                    onPressed: () => prov.vote(false),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Desliza a la izquierda para ver otra raza',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
