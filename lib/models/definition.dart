class Definition {
  final String definition;
  final String type;
  final String example;
  final String imageUrl;
  // emoji string (example: sun)
  final String emoji;

  Definition._(
      this.definition, this.type, this.example, this.imageUrl, this.emoji);

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition._(
      json['definition'],
      json['type'],
      json['example'],
      json['image_url'],
      json['emoji'],
    );
  }
}
