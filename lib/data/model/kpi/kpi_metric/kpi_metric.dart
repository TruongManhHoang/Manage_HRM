class KPIMetric {
  final String name;
  final String description;
  final double weight;
  final double score;

  KPIMetric({
    required this.name,
    required this.description,
    required this.weight,
    required this.score,
  });

  factory KPIMetric.fromJson(Map<String, dynamic> json) {
    return KPIMetric(
      name: json['name'],
      description: json['description'],
      weight: (json['weight'] as num).toDouble(),
      score: (json['score'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'weight': weight,
      'score': score,
    };
  }
}
