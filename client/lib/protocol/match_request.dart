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

abstract class MatchRequest implements _i1.SerializableModel {
  MatchRequest._({
    this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.status,
  });

  factory MatchRequest({
    int? id,
    required String fromUserId,
    required String toUserId,
    required String status,
  }) = _MatchRequestImpl;

  factory MatchRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return MatchRequest(
      id: jsonSerialization['id'] as int?,
      fromUserId: jsonSerialization['fromUserId'] as String,
      toUserId: jsonSerialization['toUserId'] as String,
      status: jsonSerialization['status'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String fromUserId;

  String toUserId;

  String status;

  /// Returns a shallow copy of this [MatchRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MatchRequest copyWith({
    int? id,
    String? fromUserId,
    String? toUserId,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MatchRequestImpl extends MatchRequest {
  _MatchRequestImpl({
    int? id,
    required String fromUserId,
    required String toUserId,
    required String status,
  }) : super._(
          id: id,
          fromUserId: fromUserId,
          toUserId: toUserId,
          status: status,
        );

  /// Returns a shallow copy of this [MatchRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MatchRequest copyWith({
    Object? id = _Undefined,
    String? fromUserId,
    String? toUserId,
    String? status,
  }) {
    return MatchRequest(
      id: id is int? ? id : this.id,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      status: status ?? this.status,
    );
  }
}
