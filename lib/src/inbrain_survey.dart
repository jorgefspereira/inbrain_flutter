import 'dart:convert';

class InBrainSurvey {
  final String id;

  final String? placementId;

  final num rank;

  final num time;

  final num value;

  InBrainSurvey({
    required this.id,
    this.placementId,
    required this.rank,
    required this.time,
    required this.value,
  });

  factory InBrainSurvey.fromMap(Map<String, dynamic> map) {
    return InBrainSurvey(
      id: map['id'],
      placementId: map['placementId'],
      rank: map['rank'] ?? 0,
      time: map['time'] ?? 0,
      value: map['value'] ?? 0,
    );
  }

  factory InBrainSurvey.fromJson(String source) => InBrainSurvey.fromMap(json.decode(source));
}
