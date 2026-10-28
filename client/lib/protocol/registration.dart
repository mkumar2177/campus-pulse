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

abstract class Registration implements _i1.SerializableModel {
  Registration._({
    this.id,
    required this.eventId,
    required this.userId,
    required this.status,
  });

  factory Registration({
    int? id,
    required String eventId,
    required String userId,
    required String status,
  }) = _RegistrationImpl;

  factory Registration.fromJson(Map<String, dynamic> jsonSerialization) {
    return Registration(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as String,
      userId: jsonSerialization['userId'] as String,
      status: jsonSerialization['status'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String eventId;

  String userId;

  String status;

  /// Returns a shallow copy of this [Registration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Registration copyWith({
    int? id,
    String? eventId,
    String? userId,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'eventId': eventId,
      'userId': userId,
      'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RegistrationImpl extends Registration {
  _RegistrationImpl({
    int? id,
    required String eventId,
    required String userId,
    required String status,
  }) : super._(
          id: id,
          eventId: eventId,
          userId: userId,
          status: status,
        );

  /// Returns a shallow copy of this [Registration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Registration copyWith({
    Object? id = _Undefined,
    String? eventId,
    String? userId,
    String? status,
  }) {
    return Registration(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
    );
  }
}
