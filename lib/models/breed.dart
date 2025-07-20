class Breed {
  final String id, name, origin, description, wikipediaUrl;
  final String lifeSpan;
  final int intelligence;

  Breed({
    required this.id,
    required this.name,
    required this.origin,
    required this.description,
    required this.wikipediaUrl,
    required this.lifeSpan,
    required this.intelligence,
  });

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
    id: json['id'],
    name: json['name'],
    origin: json['origin'],
    description: json['description'],
    wikipediaUrl: json['wikipedia_url'] ?? '',
    lifeSpan: json['life_span'],
    intelligence: json['intelligence'] ?? 0,
  );
}
