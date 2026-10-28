/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;

abstract class MatchRequest
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = MatchRequestTable();

  static const db = MatchRequestRepository._();

  @override
  int? id;

  String fromUserId;

  String toUserId;

  String status;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'status': status,
    };
  }

  static MatchRequestInclude include() {
    return MatchRequestInclude._();
  }

  static MatchRequestIncludeList includeList({
    _i1.WhereExpressionBuilder<MatchRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchRequestTable>? orderByList,
    MatchRequestInclude? include,
  }) {
    return MatchRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MatchRequest.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MatchRequest.t),
      include: include,
    );
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

class MatchRequestTable extends _i1.Table<int?> {
  MatchRequestTable({super.tableRelation}) : super(tableName: 'match_request') {
    fromUserId = _i1.ColumnString(
      'fromUserId',
      this,
    );
    toUserId = _i1.ColumnString(
      'toUserId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
  }

  late final _i1.ColumnString fromUserId;

  late final _i1.ColumnString toUserId;

  late final _i1.ColumnString status;

  @override
  List<_i1.Column> get columns => [
        id,
        fromUserId,
        toUserId,
        status,
      ];
}

class MatchRequestInclude extends _i1.IncludeObject {
  MatchRequestInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MatchRequest.t;
}

class MatchRequestIncludeList extends _i1.IncludeList {
  MatchRequestIncludeList._({
    _i1.WhereExpressionBuilder<MatchRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MatchRequest.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MatchRequest.t;
}

class MatchRequestRepository {
  const MatchRequestRepository._();

  /// Returns a list of [MatchRequest]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<MatchRequest>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchRequestTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MatchRequest>(
      where: where?.call(MatchRequest.t),
      orderBy: orderBy?.call(MatchRequest.t),
      orderByList: orderByList?.call(MatchRequest.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MatchRequest] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<MatchRequest?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchRequestTable>? where,
    int? offset,
    _i1.OrderByBuilder<MatchRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchRequestTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MatchRequest>(
      where: where?.call(MatchRequest.t),
      orderBy: orderBy?.call(MatchRequest.t),
      orderByList: orderByList?.call(MatchRequest.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MatchRequest] by its [id] or null if no such row exists.
  Future<MatchRequest?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MatchRequest>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MatchRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [MatchRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MatchRequest>> insert(
    _i1.Session session,
    List<MatchRequest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MatchRequest>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MatchRequest] and returns the inserted row.
  ///
  /// The returned [MatchRequest] will have its `id` field set.
  Future<MatchRequest> insertRow(
    _i1.Session session,
    MatchRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MatchRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MatchRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MatchRequest>> update(
    _i1.Session session,
    List<MatchRequest> rows, {
    _i1.ColumnSelections<MatchRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MatchRequest>(
      rows,
      columns: columns?.call(MatchRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MatchRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MatchRequest> updateRow(
    _i1.Session session,
    MatchRequest row, {
    _i1.ColumnSelections<MatchRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MatchRequest>(
      row,
      columns: columns?.call(MatchRequest.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MatchRequest]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MatchRequest>> delete(
    _i1.Session session,
    List<MatchRequest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MatchRequest>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MatchRequest].
  Future<MatchRequest> deleteRow(
    _i1.Session session,
    MatchRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MatchRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MatchRequest>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MatchRequestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MatchRequest>(
      where: where(MatchRequest.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MatchRequestTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MatchRequest>(
      where: where?.call(MatchRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
