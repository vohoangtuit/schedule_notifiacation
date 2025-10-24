// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NotificationInfoTable extends NotificationInfo
    with TableInfo<$NotificationInfoTable, NotificationInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateTimeNotyMeta = const VerificationMeta(
    'dateTimeNoty',
  );
  @override
  late final GeneratedColumn<String> dateTimeNoty = GeneratedColumn<String>(
    'date_time_noty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _beforeTimeActiveMeta = const VerificationMeta(
    'beforeTimeActive',
  );
  @override
  late final GeneratedColumn<String> beforeTimeActive = GeneratedColumn<String>(
    'before_time_active',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    dateTimeNoty,
    beforeTimeActive,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('date_time_noty')) {
      context.handle(
        _dateTimeNotyMeta,
        dateTimeNoty.isAcceptableOrUnknown(
          data['date_time_noty']!,
          _dateTimeNotyMeta,
        ),
      );
    }
    if (data.containsKey('before_time_active')) {
      context.handle(
        _beforeTimeActiveMeta,
        beforeTimeActive.isAcceptableOrUnknown(
          data['before_time_active']!,
          _beforeTimeActiveMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationInfoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      dateTimeNoty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_time_noty'],
      ),
      beforeTimeActive: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}before_time_active'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      ),
    );
  }

  @override
  $NotificationInfoTable createAlias(String alias) {
    return $NotificationInfoTable(attachedDatabase, alias);
  }
}

class NotificationInfoData extends DataClass
    implements Insertable<NotificationInfoData> {
  final int id;
  final String? title;
  final String? dateTimeNoty;
  final String? beforeTimeActive;
  final bool? active;
  const NotificationInfoData({
    required this.id,
    this.title,
    this.dateTimeNoty,
    this.beforeTimeActive,
    this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || dateTimeNoty != null) {
      map['date_time_noty'] = Variable<String>(dateTimeNoty);
    }
    if (!nullToAbsent || beforeTimeActive != null) {
      map['before_time_active'] = Variable<String>(beforeTimeActive);
    }
    if (!nullToAbsent || active != null) {
      map['active'] = Variable<bool>(active);
    }
    return map;
  }

  NotificationInfoCompanion toCompanion(bool nullToAbsent) {
    return NotificationInfoCompanion(
      id: Value(id),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      dateTimeNoty: dateTimeNoty == null && nullToAbsent
          ? const Value.absent()
          : Value(dateTimeNoty),
      beforeTimeActive: beforeTimeActive == null && nullToAbsent
          ? const Value.absent()
          : Value(beforeTimeActive),
      active: active == null && nullToAbsent
          ? const Value.absent()
          : Value(active),
    );
  }

  factory NotificationInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationInfoData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      dateTimeNoty: serializer.fromJson<String?>(json['dateTimeNoty']),
      beforeTimeActive: serializer.fromJson<String?>(json['beforeTimeActive']),
      active: serializer.fromJson<bool?>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'dateTimeNoty': serializer.toJson<String?>(dateTimeNoty),
      'beforeTimeActive': serializer.toJson<String?>(beforeTimeActive),
      'active': serializer.toJson<bool?>(active),
    };
  }

  NotificationInfoData copyWith({
    int? id,
    Value<String?> title = const Value.absent(),
    Value<String?> dateTimeNoty = const Value.absent(),
    Value<String?> beforeTimeActive = const Value.absent(),
    Value<bool?> active = const Value.absent(),
  }) => NotificationInfoData(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    dateTimeNoty: dateTimeNoty.present ? dateTimeNoty.value : this.dateTimeNoty,
    beforeTimeActive: beforeTimeActive.present
        ? beforeTimeActive.value
        : this.beforeTimeActive,
    active: active.present ? active.value : this.active,
  );
  NotificationInfoData copyWithCompanion(NotificationInfoCompanion data) {
    return NotificationInfoData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      dateTimeNoty: data.dateTimeNoty.present
          ? data.dateTimeNoty.value
          : this.dateTimeNoty,
      beforeTimeActive: data.beforeTimeActive.present
          ? data.beforeTimeActive.value
          : this.beforeTimeActive,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationInfoData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dateTimeNoty: $dateTimeNoty, ')
          ..write('beforeTimeActive: $beforeTimeActive, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, dateTimeNoty, beforeTimeActive, active);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationInfoData &&
          other.id == this.id &&
          other.title == this.title &&
          other.dateTimeNoty == this.dateTimeNoty &&
          other.beforeTimeActive == this.beforeTimeActive &&
          other.active == this.active);
}

class NotificationInfoCompanion extends UpdateCompanion<NotificationInfoData> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> dateTimeNoty;
  final Value<String?> beforeTimeActive;
  final Value<bool?> active;
  const NotificationInfoCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.dateTimeNoty = const Value.absent(),
    this.beforeTimeActive = const Value.absent(),
    this.active = const Value.absent(),
  });
  NotificationInfoCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.dateTimeNoty = const Value.absent(),
    this.beforeTimeActive = const Value.absent(),
    this.active = const Value.absent(),
  });
  static Insertable<NotificationInfoData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? dateTimeNoty,
    Expression<String>? beforeTimeActive,
    Expression<bool>? active,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (dateTimeNoty != null) 'date_time_noty': dateTimeNoty,
      if (beforeTimeActive != null) 'before_time_active': beforeTimeActive,
      if (active != null) 'active': active,
    });
  }

  NotificationInfoCompanion copyWith({
    Value<int>? id,
    Value<String?>? title,
    Value<String?>? dateTimeNoty,
    Value<String?>? beforeTimeActive,
    Value<bool?>? active,
  }) {
    return NotificationInfoCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTimeNoty: dateTimeNoty ?? this.dateTimeNoty,
      beforeTimeActive: beforeTimeActive ?? this.beforeTimeActive,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dateTimeNoty.present) {
      map['date_time_noty'] = Variable<String>(dateTimeNoty.value);
    }
    if (beforeTimeActive.present) {
      map['before_time_active'] = Variable<String>(beforeTimeActive.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationInfoCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dateTimeNoty: $dateTimeNoty, ')
          ..write('beforeTimeActive: $beforeTimeActive, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NotificationInfoTable notificationInfo = $NotificationInfoTable(
    this,
  );
  late final NotificationDao notificationDao = NotificationDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notificationInfo];
}

typedef $$NotificationInfoTableCreateCompanionBuilder =
    NotificationInfoCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<String?> dateTimeNoty,
      Value<String?> beforeTimeActive,
      Value<bool?> active,
    });
typedef $$NotificationInfoTableUpdateCompanionBuilder =
    NotificationInfoCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<String?> dateTimeNoty,
      Value<String?> beforeTimeActive,
      Value<bool?> active,
    });

class $$NotificationInfoTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationInfoTable> {
  $$NotificationInfoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateTimeNoty => $composableBuilder(
    column: $table.dateTimeNoty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beforeTimeActive => $composableBuilder(
    column: $table.beforeTimeActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationInfoTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationInfoTable> {
  $$NotificationInfoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateTimeNoty => $composableBuilder(
    column: $table.dateTimeNoty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beforeTimeActive => $composableBuilder(
    column: $table.beforeTimeActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationInfoTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationInfoTable> {
  $$NotificationInfoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get dateTimeNoty => $composableBuilder(
    column: $table.dateTimeNoty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get beforeTimeActive => $composableBuilder(
    column: $table.beforeTimeActive,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$NotificationInfoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationInfoTable,
          NotificationInfoData,
          $$NotificationInfoTableFilterComposer,
          $$NotificationInfoTableOrderingComposer,
          $$NotificationInfoTableAnnotationComposer,
          $$NotificationInfoTableCreateCompanionBuilder,
          $$NotificationInfoTableUpdateCompanionBuilder,
          (
            NotificationInfoData,
            BaseReferences<
              _$AppDatabase,
              $NotificationInfoTable,
              NotificationInfoData
            >,
          ),
          NotificationInfoData,
          PrefetchHooks Function()
        > {
  $$NotificationInfoTableTableManager(
    _$AppDatabase db,
    $NotificationInfoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationInfoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationInfoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationInfoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> dateTimeNoty = const Value.absent(),
                Value<String?> beforeTimeActive = const Value.absent(),
                Value<bool?> active = const Value.absent(),
              }) => NotificationInfoCompanion(
                id: id,
                title: title,
                dateTimeNoty: dateTimeNoty,
                beforeTimeActive: beforeTimeActive,
                active: active,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> dateTimeNoty = const Value.absent(),
                Value<String?> beforeTimeActive = const Value.absent(),
                Value<bool?> active = const Value.absent(),
              }) => NotificationInfoCompanion.insert(
                id: id,
                title: title,
                dateTimeNoty: dateTimeNoty,
                beforeTimeActive: beforeTimeActive,
                active: active,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationInfoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationInfoTable,
      NotificationInfoData,
      $$NotificationInfoTableFilterComposer,
      $$NotificationInfoTableOrderingComposer,
      $$NotificationInfoTableAnnotationComposer,
      $$NotificationInfoTableCreateCompanionBuilder,
      $$NotificationInfoTableUpdateCompanionBuilder,
      (
        NotificationInfoData,
        BaseReferences<
          _$AppDatabase,
          $NotificationInfoTable,
          NotificationInfoData
        >,
      ),
      NotificationInfoData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NotificationInfoTableTableManager get notificationInfo =>
      $$NotificationInfoTableTableManager(_db, _db.notificationInfo);
}
