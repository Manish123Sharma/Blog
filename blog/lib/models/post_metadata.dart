class PostMetadata {
  final String app;
  final String format;
  final List<String> images;
  final List<String> links;
  final List<String> tags;

  PostMetadata({
    required this.app,
    required this.format,
    required this.images,
    required this.links,
    required this.tags,
  });

  factory PostMetadata.fromJson(Map<String, dynamic> json) {
    return PostMetadata(
      app: json['app'] ?? '',
      format: json['format'] ?? '',
      images: List<String>.from(json['image'] ?? []),
      links: List<String>.from(json['links'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}
