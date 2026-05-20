class ApiReference {
  final String name;
  final String url;

  const ApiReference({required this.name, required this.url});

  factory ApiReference.fromMap(Map<String, dynamic> json) {
    return ApiReference(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toMap() => {'name': name, 'url': url};
}
