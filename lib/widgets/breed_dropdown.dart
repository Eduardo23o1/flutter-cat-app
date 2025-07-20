import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/breed.dart';
import '../providers/breed_provider.dart';

class BreedDropdown extends StatelessWidget {
  const BreedDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<BreedProvider>();
    return DropdownButton<Breed>(
      value: prov.selected,
      hint: const Text('Selecciona una raza'),
      items:
          prov.breeds.map((b) {
            return DropdownMenuItem(value: b, child: Text(b.name));
          }).toList(),
      onChanged: prov.selectBreed,
    );
  }
}
