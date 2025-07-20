class CatImage {
  final String url;
  CatImage({required this.url});
  factory CatImage.fromJson(Map<String, dynamic> json) =>
      CatImage(url: json['url']);
}
