class PostStats {
  final double flagWeight;
  final bool gray;
  final bool hide;
  final int totalVotes;

  PostStats({
    required this.flagWeight,
    required this.gray,
    required this.hide,
    required this.totalVotes,
  });

  factory PostStats.fromJson(Map<String, dynamic> json) {
    return PostStats(
      flagWeight: (json['flag_weight'] ?? 0.0).toDouble(),
      gray: json['gray'] ?? false,
      hide: json['hide'] ?? false,
      totalVotes: json['total_votes'] ?? 0,
    );
  }
}
