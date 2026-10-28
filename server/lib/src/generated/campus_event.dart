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

abstract class CampusEvent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CampusEventTable();

  static const db = CampusEventRepository._();

  @override
  int? id;

  String title;

  String category;

  String description;

  String organizerId;

  String venue;

  DateTime dateTime;

  int capacity;

  bool cancelled;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static CampusEventInclude include() {
    return CampusEventInclude._();
  }

  static CampusEventIncludeList includeList({
    _i1.WhereExpressionBuilder<CampusEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CampusEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CampusEventTable>? orderByList,
    CampusEventInclude? include,
  }) {
    return CampusEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CampusEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CampusEvent.t),
      include: include,
    );
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

class CampusEventTable extends _i1.Table<int?> {
  CampusEventTable({super.tableRelation}) : super(tableName: 'campus_event') {
    title = _i1.ColumnString(
      'title',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    organizerId = _i1.ColumnString(
      'organizerId',
      this,
    );
    venue = _i1.ColumnString(
      'venue',
      this,
    );
    dateTime = _i1.ColumnDateTime(
      'dateTime',
      this,
    );
    capacity = _i1.ColumnInt(
      'capacity',
      this,
    );
    cancelled = _i1.ColumnBool(
      'cancelled',
      this,
    );
  }

  late final _i1.ColumnString title;

  late final _i1.ColumnString category;

  late final _i1.ColumnString description;

  late final _i1.ColumnString organizerId;

  late final _i1.ColumnString venue;

  late final _i1.ColumnDateTime dateTime;

  late final _i1.ColumnInt capacity;

  late final _i1.ColumnBool cancelled;

  @override
  List<_i1.Column> get columns => [
        id,
        title,
        category,
        description,
        organizerId,
        venue,
        dateTime,
        capacity,
        cancelled,
      ];
}

class CampusEventInclude extends _i1.IncludeObject {
  CampusEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CampusEvent.t;
}

class CampusEventIncludeList extends _i1.IncludeList {
  CampusEventIncludeList._({
    _i1.WhereExpressionBuilder<CampusEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CampusEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CampusEvent.t;
}

class CampusEventRepository {
  const CampusEventRepository._();

  /// Returns a list of [CampusEvent]s matching the given query parameters.
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
  Future<List<CampusEvent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CampusEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CampusEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CampusEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CampusEvent>(
      where: where?.call(CampusEvent.t),
      orderBy: orderBy?.call(CampusEvent.t),
      orderByList: orderByList?.call(CampusEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CampusEvent] matching the given query parameters.
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
  Future<CampusEvent?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CampusEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<CampusEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CampusEventTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CampusEvent>(
      where: where?.call(CampusEvent.t),
      orderBy: orderBy?.call(CampusEvent.t),
      orderByList: orderByList?.call(CampusEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CampusEvent] by its [id] or null if no such row exists.
  Future<CampusEvent?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CampusEvent>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CampusEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [CampusEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CampusEvent>> insert(
    _i1.Session session,
    List<CampusEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CampusEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CampusEvent] and returns the inserted row.
  ///
  /// The returned [CampusEvent] will have its `id` field set.
  Future<CampusEvent> insertRow(
    _i1.Session session,
    CampusEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CampusEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CampusEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CampusEvent>> update(
    _i1.Session session,
    List<CampusEvent> rows, {
    _i1.ColumnSelections<CampusEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CampusEvent>(
      rows,
      columns: columns?.call(CampusEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CampusEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CampusEvent> updateRow(
    _i1.Session session,
    CampusEvent row, {
    _i1.ColumnSelections<CampusEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CampusEvent>(
      row,
      columns: columns?.call(CampusEvent.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CampusEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CampusEvent>> delete(
    _i1.Session session,
    List<CampusEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CampusEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CampusEvent].
  Future<CampusEvent> deleteRow(
    _i1.Session session,
    CampusEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CampusEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CampusEvent>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CampusEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CampusEvent>(
      where: where(CampusEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CampusEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CampusEvent>(
      where: where?.call(CampusEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
