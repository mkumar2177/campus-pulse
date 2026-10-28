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
import 'campus_event.dart' as _i2;
import 'match_request.dart' as _i3;
import 'profile.dart' as _i4;
import 'registration.dart' as _i5;
import 'package:campus_pulse_client/src/protocol/campus_event.dart' as _i6;
export 'campus_event.dart';
export 'match_request.dart';
export 'profile.dart';
export 'registration.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.CampusEvent) {
      return _i2.CampusEvent.fromJson(data) as T;
    }
    if (t == _i3.MatchRequest) {
      return _i3.MatchRequest.fromJson(data) as T;
    }
    if (t == _i4.Profile) {
      return _i4.Profile.fromJson(data) as T;
    }
    if (t == _i5.Registration) {
      return _i5.Registration.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.CampusEvent?>()) {
      return (data != null ? _i2.CampusEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.MatchRequest?>()) {
      return (data != null ? _i3.MatchRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Profile?>()) {
      return (data != null ? _i4.Profile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Registration?>()) {
      return (data != null ? _i5.Registration.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i6.CampusEvent>) {
      return (data as List).map((e) => deserialize<_i6.CampusEvent>(e)).toList()
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.CampusEvent) {
      return 'CampusEvent';
    }
    if (data is _i3.MatchRequest) {
      return 'MatchRequest';
    }
    if (data is _i4.Profile) {
      return 'Profile';
    }
    if (data is _i5.Registration) {
      return 'Registration';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CampusEvent') {
      return deserialize<_i2.CampusEvent>(data['data']);
    }
    if (dataClassName == 'MatchRequest') {
      return deserialize<_i3.MatchRequest>(data['data']);
    }
    if (dataClassName == 'Profile') {
      return deserialize<_i4.Profile>(data['data']);
    }
    if (dataClassName == 'Registration') {
      return deserialize<_i5.Registration>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
