/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Profile implements _i1.SerializableModel {
  Profile._({
    this.id,
    required this.userId,
    required this.subjects,
    required this.goal,
    required this.availability,
    required this.visibleToMatches,
  });

  factory Profile({
    int? id,
    required String userId,
    required List<String> subjects,
    required String goal,
    required List<String> availability,
    required bool visibleToMatches,
  }) = _ProfileImpl;

  factory Profile.fromJson(Map<String, dynamic> jsonSerialization) {
    return Profile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      subjects: (jsonSerialization['subjects'] as List)
          .map((e) => e as String)
          .toList(),
      goal: jsonSerialization['goal'] as String,
      availability: (jsonSerialization['availability'] as List)
          .map((e) => e as String)
          .toList(),
      visibleToMatches: jsonSerialization['visibleToMatches'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  List<String> subjects;

  String goal;

  List<String> availability;

  bool visibleToMatches;

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Profile copyWith({
    int? id,
    String? userId,
    List<String>? subjects,
    String? goal,
    List<String>? availability,
    bool? visibleToMatches,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'subjects': subjects.toJson(),
      'goal': goal,
      'availability': availability.toJson(),
      'visibleToMatches': visibleToMatches,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileImpl extends Profile {
  _ProfileImpl({
    int? id,
    required String userId,
    required List<String> subjects,
    required String goal,
    required List<String> availability,
    required bool visibleToMatches,
  }) : super._(
          id: id,
          userId: userId,
          subjects: subjects,
          goal: goal,
          availability: availability,
          visibleToMatches: visibleToMatches,
        );

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Profile copyWith({
    Object? id = _Undefined,
    String? userId,
    List<String>? subjects,
    String? goal,
    List<String>? availability,
    bool? visibleToMatches,
  }) {
    return Profile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      subjects: subjects ?? this.subjects.map((e0) => e0).toList(),
      goal: goal ?? this.goal,
      availability: availability ?? this.availability.map((e0) => e0).toList(),
      visibleToMatches: visibleToMatches ?? this.visibleToMatches,
    );
  }
}
