import 'models.dart';

class MatchingWeights {
  const MatchingWeights({
    this.subjects = 0.5,
    this.goals = 0.3,
    this.availability = 0.2,
  }) : assert(subjects + goals + availability == 1);
  final double subjects;
  final double goals;
  final double availability;
}

MatchBreakdown calculateMatch(
  CampusUser source,
  CampusUser candidate, {
  MatchingWeights weights = const MatchingWeights(),
}) {
  final shared = source.subjects
      .where((subject) => candidate.subjects.contains(subject))
      .toList();
  final double subjectScore = source.subjects.isEmpty
      ? 0
      : shared.length / source.subjects.length;
  final double goalScore = source.goal.isEmpty || candidate.goal.isEmpty
      ? 0
      : source.goal.toLowerCase() == candidate.goal.toLowerCase()
          ? 1
          : 0;
  final overlapping = source.availability
      .where(candidate.availability.contains)
      .toList();
  final double availabilityScore = source.availability.isEmpty
      ? 0
      : overlapping.length / source.availability.length;
  final total = ((subjectScore * weights.subjects) +
          (goalScore * weights.goals) +
          (availabilityScore * weights.availability)) *
      100;
  final reasons = <String>[
    if (shared.isNotEmpty) 'You both study ${shared.join(', ')}',
    if (goalScore == 1) 'Similar goal: ${candidate.goal}',
    if (overlapping.isNotEmpty)
      'Both free ${overlapping.take(2).join(' and ')}',
  ];
  return MatchBreakdown(
    subjectScore: subjectScore,
    goalScore: goalScore,
    availabilityScore: availabilityScore,
    totalScore: double.parse(total.toStringAsFixed(1)),
    reasons: reasons.isEmpty ? ['Not enough shared profile data yet'] : reasons,
  );
}
