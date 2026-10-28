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

abstract class CampusEvent implements _i1.SerializableModel {
  CampusEvent._({
    this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.organizerId,
    required this.venue,
    required this.dateTime,
    required this.capacity,
    required this.cancelled,
  });

  factory CampusEvent({
    int? id,
    required String title,
    required String category,
    required String description,
    required String organizerId,
    required String venue,
    required DateTime dateTime,
    required int capacity,
    required bool cancelled,
  }) = _CampusEventImpl;

  factory CampusEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusEvent(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String,
      organizerId: jsonSerialization['organizerId'] as String,
      venue: jsonSerialization['venue'] as String,
      dateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateTime']),
      capacity: jsonSerialization['capacity'] as int,
      cancelled: jsonSerialization['cancelled'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String category;

  String description;

  String organizerId;

  String venue;

  DateTime dateTime;

  int capacity;

  bool cancelled;

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CampusEvent copyWith({
    int? id,
    String? title,
    String? category,
    String? description,
    String? organizerId,
    String? venue,
    DateTime? dateTime,
    int? capacity,
    bool? cancelled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'category': category,
      'description': description,
      'organizerId': organizerId,
      'venue': venue,
      'dateTime': dateTime.toJson(),
      'capacity': capacity,
      'cancelled': cancelled,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusEventImpl extends CampusEvent {
  _CampusEventImpl({
    int? id,
    required String title,
    required String category,
    required String description,
    required String organizerId,
    required String venue,
    required DateTime dateTime,
    required int capacity,
    required bool cancelled,
  }) : super._(
          id: id,
          title: title,
          category: category,
          description: description,
          organizerId: organizerId,
          venue: venue,
          dateTime: dateTime,
          capacity: capacity,
          cancelled: cancelled,
        );

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CampusEvent copyWith({
    Object? id = _Undefined,
    String? title,
    String? category,
    String? description,
    String? organizerId,
    String? venue,
    DateTime? dateTime,
    int? capacity,
    bool? cancelled,
  }) {
    return CampusEvent(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      organizerId: organizerId ?? this.organizerId,
      venue: venue ?? this.venue,
      dateTime: dateTime ?? this.dateTime,
      capacity: capacity ?? this.capacity,
      cancelled: cancelled ?? this.cancelled,
    );
  }
}
