import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import 'post_metadata.dart';
import 'post_stats.dart';
import 'vote.dart';

class BlogPost {
  final String author;
  final String title;
  final String body;
  final String category;
  final String permlink;
  final String url;
  final DateTime created;
  final DateTime updated;
  final DateTime payoutAt;
  final String authorPayoutValue;
  final String curatorPayoutValue;
  final String pendingPayoutValue;
  final String promoted;
  final String maxAcceptedPayout;
  final int percentHbd;
  final double payout;
  final int children;
  final int depth;
  final int netRshares;
  final int reblogs;
  final List<Vote> activeVotes;
  final PostMetadata metadata;
  final PostStats stats;

  BlogPost({
    required this.author,
    required this.title,
    required this.body,
    required this.category,
    required this.permlink,
    required this.url,
    required this.created,
    required this.updated,
    required this.payoutAt,
    required this.authorPayoutValue,
    required this.curatorPayoutValue,
    required this.pendingPayoutValue,
    required this.promoted,
    required this.maxAcceptedPayout,
    required this.percentHbd,
    required this.payout,
    required this.children,
    required this.depth,
    required this.netRshares,
    required this.reblogs,
    required this.activeVotes,
    required this.metadata,
    required this.stats,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      category: json['category'] ?? '',
      permlink: json['permlink'] ?? '',
      url: json['url'] ?? '',
      created: DateTime.parse(json['created'] ?? DateTime.now().toIso8601String()),
      updated: DateTime.parse(json['updated'] ?? DateTime.now().toIso8601String()),
      payoutAt: DateTime.parse(json['payout_at'] ?? DateTime.now().toIso8601String()),
      authorPayoutValue: json['author_payout_value'] ?? '0.000 HBD',
      curatorPayoutValue: json['curator_payout_value'] ?? '0.000 HBD',
      pendingPayoutValue: json['pending_payout_value'] ?? '0.000 HBD',
      promoted: json['promoted'] ?? '0.000 HBD',
      maxAcceptedPayout: json['max_accepted_payout'] ?? '0.000 HBD',
      percentHbd: json['percent_hbd'] ?? 0,
      payout: (json['payout'] ?? 0.0).toDouble(),
      children: json['children'] ?? 0,
      depth: json['depth'] ?? 0,
      netRshares: json['net_rshares'] ?? 0,
      reblogs: json['reblogs'] ?? 0,
      activeVotes: (json['active_votes'] as List? ?? []).map((vote) => Vote.fromJson(vote)).toList(),
      metadata: PostMetadata.fromJson(json['json_metadata'] is String
          ? jsonDecode(json['json_metadata'])
          : json['json_metadata'] ?? {}),
      stats: PostStats.fromJson(json['stats'] ?? {}),
    );
  }

  String get timeAgo => timeago.format(created);
  String get firstImageUrl => metadata.images.isNotEmpty ? metadata.images.first : '';
  List<Vote> getTopVoters({int limit = 10}) {
    return List<Vote>.from(activeVotes)
      ..sort((a, b) => b.rshares.compareTo(a.rshares))
      ..take(limit).toList();
  }

  double getTotalVotingPower() {
    return activeVotes.fold(0.0, (sum, vote) => sum + vote.votingPower);
  }
}
