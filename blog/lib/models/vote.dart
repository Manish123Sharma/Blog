class Vote {
  final String voter;
  final int rshares;

  Vote({
    required this.voter,
    required this.rshares,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      voter: json['voter'] ?? '',
      rshares: json['rshares'] ?? 0,
    );
  }

  double get votingPower => rshares / 1000000000; // Convert to billions for readability
}
