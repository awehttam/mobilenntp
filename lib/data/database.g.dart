// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ServersTable extends Servers with TableInfo<$ServersTable, Server> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hostMeta = const VerificationMeta('host');
  @override
  late final GeneratedColumn<String> host = GeneratedColumn<String>(
    'host',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _portMeta = const VerificationMeta('port');
  @override
  late final GeneratedColumn<int> port = GeneratedColumn<int>(
    'port',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(119),
  );
  static const VerificationMeta _useTlsMeta = const VerificationMeta('useTls');
  @override
  late final GeneratedColumn<bool> useTls = GeneratedColumn<bool>(
    'use_tls',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_tls" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _allowBadCertificateMeta =
      const VerificationMeta('allowBadCertificate');
  @override
  late final GeneratedColumn<bool> allowBadCertificate = GeneratedColumn<bool>(
    'allow_bad_certificate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("allow_bad_certificate" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requiresAuthMeta = const VerificationMeta(
    'requiresAuth',
  );
  @override
  late final GeneratedColumn<bool> requiresAuth = GeneratedColumn<bool>(
    'requires_auth',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_auth" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _fromNameMeta = const VerificationMeta(
    'fromName',
  );
  @override
  late final GeneratedColumn<String> fromName = GeneratedColumn<String>(
    'from_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    host,
    port,
    useTls,
    allowBadCertificate,
    username,
    requiresAuth,
    fromName,
    email,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'servers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Server> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('host')) {
      context.handle(
        _hostMeta,
        host.isAcceptableOrUnknown(data['host']!, _hostMeta),
      );
    } else if (isInserting) {
      context.missing(_hostMeta);
    }
    if (data.containsKey('port')) {
      context.handle(
        _portMeta,
        port.isAcceptableOrUnknown(data['port']!, _portMeta),
      );
    }
    if (data.containsKey('use_tls')) {
      context.handle(
        _useTlsMeta,
        useTls.isAcceptableOrUnknown(data['use_tls']!, _useTlsMeta),
      );
    }
    if (data.containsKey('allow_bad_certificate')) {
      context.handle(
        _allowBadCertificateMeta,
        allowBadCertificate.isAcceptableOrUnknown(
          data['allow_bad_certificate']!,
          _allowBadCertificateMeta,
        ),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('requires_auth')) {
      context.handle(
        _requiresAuthMeta,
        requiresAuth.isAcceptableOrUnknown(
          data['requires_auth']!,
          _requiresAuthMeta,
        ),
      );
    }
    if (data.containsKey('from_name')) {
      context.handle(
        _fromNameMeta,
        fromName.isAcceptableOrUnknown(data['from_name']!, _fromNameMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Server map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Server(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      host: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}host'],
      )!,
      port: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}port'],
      )!,
      useTls: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_tls'],
      )!,
      allowBadCertificate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}allow_bad_certificate'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      requiresAuth: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_auth'],
      )!,
      fromName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ServersTable createAlias(String alias) {
    return $ServersTable(attachedDatabase, alias);
  }
}

class Server extends DataClass implements Insertable<Server> {
  final int id;
  final String name;
  final String host;
  final int port;
  final bool useTls;
  final bool allowBadCertificate;
  final String? username;
  final bool requiresAuth;

  /// Posting identity: optional display name and the email address used in the
  /// `From` header (required before posting).
  final String? fromName;
  final String? email;
  final int sortOrder;
  const Server({
    required this.id,
    required this.name,
    required this.host,
    required this.port,
    required this.useTls,
    required this.allowBadCertificate,
    this.username,
    required this.requiresAuth,
    this.fromName,
    this.email,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['host'] = Variable<String>(host);
    map['port'] = Variable<int>(port);
    map['use_tls'] = Variable<bool>(useTls);
    map['allow_bad_certificate'] = Variable<bool>(allowBadCertificate);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    map['requires_auth'] = Variable<bool>(requiresAuth);
    if (!nullToAbsent || fromName != null) {
      map['from_name'] = Variable<String>(fromName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ServersCompanion toCompanion(bool nullToAbsent) {
    return ServersCompanion(
      id: Value(id),
      name: Value(name),
      host: Value(host),
      port: Value(port),
      useTls: Value(useTls),
      allowBadCertificate: Value(allowBadCertificate),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      requiresAuth: Value(requiresAuth),
      fromName: fromName == null && nullToAbsent
          ? const Value.absent()
          : Value(fromName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      sortOrder: Value(sortOrder),
    );
  }

  factory Server.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Server(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      host: serializer.fromJson<String>(json['host']),
      port: serializer.fromJson<int>(json['port']),
      useTls: serializer.fromJson<bool>(json['useTls']),
      allowBadCertificate: serializer.fromJson<bool>(
        json['allowBadCertificate'],
      ),
      username: serializer.fromJson<String?>(json['username']),
      requiresAuth: serializer.fromJson<bool>(json['requiresAuth']),
      fromName: serializer.fromJson<String?>(json['fromName']),
      email: serializer.fromJson<String?>(json['email']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'host': serializer.toJson<String>(host),
      'port': serializer.toJson<int>(port),
      'useTls': serializer.toJson<bool>(useTls),
      'allowBadCertificate': serializer.toJson<bool>(allowBadCertificate),
      'username': serializer.toJson<String?>(username),
      'requiresAuth': serializer.toJson<bool>(requiresAuth),
      'fromName': serializer.toJson<String?>(fromName),
      'email': serializer.toJson<String?>(email),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Server copyWith({
    int? id,
    String? name,
    String? host,
    int? port,
    bool? useTls,
    bool? allowBadCertificate,
    Value<String?> username = const Value.absent(),
    bool? requiresAuth,
    Value<String?> fromName = const Value.absent(),
    Value<String?> email = const Value.absent(),
    int? sortOrder,
  }) => Server(
    id: id ?? this.id,
    name: name ?? this.name,
    host: host ?? this.host,
    port: port ?? this.port,
    useTls: useTls ?? this.useTls,
    allowBadCertificate: allowBadCertificate ?? this.allowBadCertificate,
    username: username.present ? username.value : this.username,
    requiresAuth: requiresAuth ?? this.requiresAuth,
    fromName: fromName.present ? fromName.value : this.fromName,
    email: email.present ? email.value : this.email,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Server copyWithCompanion(ServersCompanion data) {
    return Server(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      host: data.host.present ? data.host.value : this.host,
      port: data.port.present ? data.port.value : this.port,
      useTls: data.useTls.present ? data.useTls.value : this.useTls,
      allowBadCertificate: data.allowBadCertificate.present
          ? data.allowBadCertificate.value
          : this.allowBadCertificate,
      username: data.username.present ? data.username.value : this.username,
      requiresAuth: data.requiresAuth.present
          ? data.requiresAuth.value
          : this.requiresAuth,
      fromName: data.fromName.present ? data.fromName.value : this.fromName,
      email: data.email.present ? data.email.value : this.email,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Server(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('host: $host, ')
          ..write('port: $port, ')
          ..write('useTls: $useTls, ')
          ..write('allowBadCertificate: $allowBadCertificate, ')
          ..write('username: $username, ')
          ..write('requiresAuth: $requiresAuth, ')
          ..write('fromName: $fromName, ')
          ..write('email: $email, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    host,
    port,
    useTls,
    allowBadCertificate,
    username,
    requiresAuth,
    fromName,
    email,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Server &&
          other.id == this.id &&
          other.name == this.name &&
          other.host == this.host &&
          other.port == this.port &&
          other.useTls == this.useTls &&
          other.allowBadCertificate == this.allowBadCertificate &&
          other.username == this.username &&
          other.requiresAuth == this.requiresAuth &&
          other.fromName == this.fromName &&
          other.email == this.email &&
          other.sortOrder == this.sortOrder);
}

class ServersCompanion extends UpdateCompanion<Server> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> host;
  final Value<int> port;
  final Value<bool> useTls;
  final Value<bool> allowBadCertificate;
  final Value<String?> username;
  final Value<bool> requiresAuth;
  final Value<String?> fromName;
  final Value<String?> email;
  final Value<int> sortOrder;
  const ServersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.host = const Value.absent(),
    this.port = const Value.absent(),
    this.useTls = const Value.absent(),
    this.allowBadCertificate = const Value.absent(),
    this.username = const Value.absent(),
    this.requiresAuth = const Value.absent(),
    this.fromName = const Value.absent(),
    this.email = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ServersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String host,
    this.port = const Value.absent(),
    this.useTls = const Value.absent(),
    this.allowBadCertificate = const Value.absent(),
    this.username = const Value.absent(),
    this.requiresAuth = const Value.absent(),
    this.fromName = const Value.absent(),
    this.email = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : name = Value(name),
       host = Value(host);
  static Insertable<Server> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? host,
    Expression<int>? port,
    Expression<bool>? useTls,
    Expression<bool>? allowBadCertificate,
    Expression<String>? username,
    Expression<bool>? requiresAuth,
    Expression<String>? fromName,
    Expression<String>? email,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (host != null) 'host': host,
      if (port != null) 'port': port,
      if (useTls != null) 'use_tls': useTls,
      if (allowBadCertificate != null)
        'allow_bad_certificate': allowBadCertificate,
      if (username != null) 'username': username,
      if (requiresAuth != null) 'requires_auth': requiresAuth,
      if (fromName != null) 'from_name': fromName,
      if (email != null) 'email': email,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ServersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? host,
    Value<int>? port,
    Value<bool>? useTls,
    Value<bool>? allowBadCertificate,
    Value<String?>? username,
    Value<bool>? requiresAuth,
    Value<String?>? fromName,
    Value<String?>? email,
    Value<int>? sortOrder,
  }) {
    return ServersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      host: host ?? this.host,
      port: port ?? this.port,
      useTls: useTls ?? this.useTls,
      allowBadCertificate: allowBadCertificate ?? this.allowBadCertificate,
      username: username ?? this.username,
      requiresAuth: requiresAuth ?? this.requiresAuth,
      fromName: fromName ?? this.fromName,
      email: email ?? this.email,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (host.present) {
      map['host'] = Variable<String>(host.value);
    }
    if (port.present) {
      map['port'] = Variable<int>(port.value);
    }
    if (useTls.present) {
      map['use_tls'] = Variable<bool>(useTls.value);
    }
    if (allowBadCertificate.present) {
      map['allow_bad_certificate'] = Variable<bool>(allowBadCertificate.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (requiresAuth.present) {
      map['requires_auth'] = Variable<bool>(requiresAuth.value);
    }
    if (fromName.present) {
      map['from_name'] = Variable<String>(fromName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('host: $host, ')
          ..write('port: $port, ')
          ..write('useTls: $useTls, ')
          ..write('allowBadCertificate: $allowBadCertificate, ')
          ..write('username: $username, ')
          ..write('requiresAuth: $requiresAuth, ')
          ..write('fromName: $fromName, ')
          ..write('email: $email, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, Subscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES servers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lastReadNumberMeta = const VerificationMeta(
    'lastReadNumber',
  );
  @override
  late final GeneratedColumn<int> lastReadNumber = GeneratedColumn<int>(
    'last_read_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _serverHighMeta = const VerificationMeta(
    'serverHigh',
  );
  @override
  late final GeneratedColumn<int> serverHigh = GeneratedColumn<int>(
    'server_high',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    groupName,
    description,
    lastReadNumber,
    serverHigh,
    unreadCount,
    lastSyncedAt,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subscription> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('last_read_number')) {
      context.handle(
        _lastReadNumberMeta,
        lastReadNumber.isAcceptableOrUnknown(
          data['last_read_number']!,
          _lastReadNumberMeta,
        ),
      );
    }
    if (data.containsKey('server_high')) {
      context.handle(
        _serverHighMeta,
        serverHigh.isAcceptableOrUnknown(data['server_high']!, _serverHighMeta),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {serverId, groupName},
  ];
  @override
  Subscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subscription(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      lastReadNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_read_number'],
      )!,
      serverHigh: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_high'],
      )!,
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(attachedDatabase, alias);
  }
}

class Subscription extends DataClass implements Insertable<Subscription> {
  final int id;
  final int serverId;
  final String groupName;
  final String description;
  final int lastReadNumber;
  final int serverHigh;
  final int unreadCount;
  final DateTime? lastSyncedAt;
  final int sortOrder;
  const Subscription({
    required this.id,
    required this.serverId,
    required this.groupName,
    required this.description,
    required this.lastReadNumber,
    required this.serverHigh,
    required this.unreadCount,
    this.lastSyncedAt,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<int>(serverId);
    map['group_name'] = Variable<String>(groupName);
    map['description'] = Variable<String>(description);
    map['last_read_number'] = Variable<int>(lastReadNumber);
    map['server_high'] = Variable<int>(serverHigh);
    map['unread_count'] = Variable<int>(unreadCount);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      id: Value(id),
      serverId: Value(serverId),
      groupName: Value(groupName),
      description: Value(description),
      lastReadNumber: Value(lastReadNumber),
      serverHigh: Value(serverHigh),
      unreadCount: Value(unreadCount),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      sortOrder: Value(sortOrder),
    );
  }

  factory Subscription.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subscription(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<int>(json['serverId']),
      groupName: serializer.fromJson<String>(json['groupName']),
      description: serializer.fromJson<String>(json['description']),
      lastReadNumber: serializer.fromJson<int>(json['lastReadNumber']),
      serverHigh: serializer.fromJson<int>(json['serverHigh']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<int>(serverId),
      'groupName': serializer.toJson<String>(groupName),
      'description': serializer.toJson<String>(description),
      'lastReadNumber': serializer.toJson<int>(lastReadNumber),
      'serverHigh': serializer.toJson<int>(serverHigh),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Subscription copyWith({
    int? id,
    int? serverId,
    String? groupName,
    String? description,
    int? lastReadNumber,
    int? serverHigh,
    int? unreadCount,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    int? sortOrder,
  }) => Subscription(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    groupName: groupName ?? this.groupName,
    description: description ?? this.description,
    lastReadNumber: lastReadNumber ?? this.lastReadNumber,
    serverHigh: serverHigh ?? this.serverHigh,
    unreadCount: unreadCount ?? this.unreadCount,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Subscription copyWithCompanion(SubscriptionsCompanion data) {
    return Subscription(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      description: data.description.present
          ? data.description.value
          : this.description,
      lastReadNumber: data.lastReadNumber.present
          ? data.lastReadNumber.value
          : this.lastReadNumber,
      serverHigh: data.serverHigh.present
          ? data.serverHigh.value
          : this.serverHigh,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subscription(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('groupName: $groupName, ')
          ..write('description: $description, ')
          ..write('lastReadNumber: $lastReadNumber, ')
          ..write('serverHigh: $serverHigh, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    groupName,
    description,
    lastReadNumber,
    serverHigh,
    unreadCount,
    lastSyncedAt,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subscription &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.groupName == this.groupName &&
          other.description == this.description &&
          other.lastReadNumber == this.lastReadNumber &&
          other.serverHigh == this.serverHigh &&
          other.unreadCount == this.unreadCount &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.sortOrder == this.sortOrder);
}

class SubscriptionsCompanion extends UpdateCompanion<Subscription> {
  final Value<int> id;
  final Value<int> serverId;
  final Value<String> groupName;
  final Value<String> description;
  final Value<int> lastReadNumber;
  final Value<int> serverHigh;
  final Value<int> unreadCount;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> sortOrder;
  const SubscriptionsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.groupName = const Value.absent(),
    this.description = const Value.absent(),
    this.lastReadNumber = const Value.absent(),
    this.serverHigh = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    this.id = const Value.absent(),
    required int serverId,
    required String groupName,
    this.description = const Value.absent(),
    this.lastReadNumber = const Value.absent(),
    this.serverHigh = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : serverId = Value(serverId),
       groupName = Value(groupName);
  static Insertable<Subscription> custom({
    Expression<int>? id,
    Expression<int>? serverId,
    Expression<String>? groupName,
    Expression<String>? description,
    Expression<int>? lastReadNumber,
    Expression<int>? serverHigh,
    Expression<int>? unreadCount,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (groupName != null) 'group_name': groupName,
      if (description != null) 'description': description,
      if (lastReadNumber != null) 'last_read_number': lastReadNumber,
      if (serverHigh != null) 'server_high': serverHigh,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  SubscriptionsCompanion copyWith({
    Value<int>? id,
    Value<int>? serverId,
    Value<String>? groupName,
    Value<String>? description,
    Value<int>? lastReadNumber,
    Value<int>? serverHigh,
    Value<int>? unreadCount,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? sortOrder,
  }) {
    return SubscriptionsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      groupName: groupName ?? this.groupName,
      description: description ?? this.description,
      lastReadNumber: lastReadNumber ?? this.lastReadNumber,
      serverHigh: serverHigh ?? this.serverHigh,
      unreadCount: unreadCount ?? this.unreadCount,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lastReadNumber.present) {
      map['last_read_number'] = Variable<int>(lastReadNumber.value);
    }
    if (serverHigh.present) {
      map['server_high'] = Variable<int>(serverHigh.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('groupName: $groupName, ')
          ..write('description: $description, ')
          ..write('lastReadNumber: $lastReadNumber, ')
          ..write('serverHigh: $serverHigh, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $GroupCatalogTable extends GroupCatalog
    with TableInfo<$GroupCatalogTable, GroupCatalogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupCatalogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES servers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _highMeta = const VerificationMeta('high');
  @override
  late final GeneratedColumn<int> high = GeneratedColumn<int>(
    'high',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lowMeta = const VerificationMeta('low');
  @override
  late final GeneratedColumn<int> low = GeneratedColumn<int>(
    'low',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _postingStatusMeta = const VerificationMeta(
    'postingStatus',
  );
  @override
  late final GeneratedColumn<String> postingStatus = GeneratedColumn<String>(
    'posting_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('y'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    groupName,
    description,
    high,
    low,
    postingStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_catalog';
  @override
  VerificationContext validateIntegrity(
    Insertable<GroupCatalogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('high')) {
      context.handle(
        _highMeta,
        high.isAcceptableOrUnknown(data['high']!, _highMeta),
      );
    }
    if (data.containsKey('low')) {
      context.handle(
        _lowMeta,
        low.isAcceptableOrUnknown(data['low']!, _lowMeta),
      );
    }
    if (data.containsKey('posting_status')) {
      context.handle(
        _postingStatusMeta,
        postingStatus.isAcceptableOrUnknown(
          data['posting_status']!,
          _postingStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId, groupName};
  @override
  GroupCatalogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupCatalogData(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      high: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}high'],
      )!,
      low: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}low'],
      )!,
      postingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}posting_status'],
      )!,
    );
  }

  @override
  $GroupCatalogTable createAlias(String alias) {
    return $GroupCatalogTable(attachedDatabase, alias);
  }
}

class GroupCatalogData extends DataClass
    implements Insertable<GroupCatalogData> {
  final int serverId;
  final String groupName;
  final String description;
  final int high;
  final int low;
  final String postingStatus;
  const GroupCatalogData({
    required this.serverId,
    required this.groupName,
    required this.description,
    required this.high,
    required this.low,
    required this.postingStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<int>(serverId);
    map['group_name'] = Variable<String>(groupName);
    map['description'] = Variable<String>(description);
    map['high'] = Variable<int>(high);
    map['low'] = Variable<int>(low);
    map['posting_status'] = Variable<String>(postingStatus);
    return map;
  }

  GroupCatalogCompanion toCompanion(bool nullToAbsent) {
    return GroupCatalogCompanion(
      serverId: Value(serverId),
      groupName: Value(groupName),
      description: Value(description),
      high: Value(high),
      low: Value(low),
      postingStatus: Value(postingStatus),
    );
  }

  factory GroupCatalogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupCatalogData(
      serverId: serializer.fromJson<int>(json['serverId']),
      groupName: serializer.fromJson<String>(json['groupName']),
      description: serializer.fromJson<String>(json['description']),
      high: serializer.fromJson<int>(json['high']),
      low: serializer.fromJson<int>(json['low']),
      postingStatus: serializer.fromJson<String>(json['postingStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<int>(serverId),
      'groupName': serializer.toJson<String>(groupName),
      'description': serializer.toJson<String>(description),
      'high': serializer.toJson<int>(high),
      'low': serializer.toJson<int>(low),
      'postingStatus': serializer.toJson<String>(postingStatus),
    };
  }

  GroupCatalogData copyWith({
    int? serverId,
    String? groupName,
    String? description,
    int? high,
    int? low,
    String? postingStatus,
  }) => GroupCatalogData(
    serverId: serverId ?? this.serverId,
    groupName: groupName ?? this.groupName,
    description: description ?? this.description,
    high: high ?? this.high,
    low: low ?? this.low,
    postingStatus: postingStatus ?? this.postingStatus,
  );
  GroupCatalogData copyWithCompanion(GroupCatalogCompanion data) {
    return GroupCatalogData(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      description: data.description.present
          ? data.description.value
          : this.description,
      high: data.high.present ? data.high.value : this.high,
      low: data.low.present ? data.low.value : this.low,
      postingStatus: data.postingStatus.present
          ? data.postingStatus.value
          : this.postingStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupCatalogData(')
          ..write('serverId: $serverId, ')
          ..write('groupName: $groupName, ')
          ..write('description: $description, ')
          ..write('high: $high, ')
          ..write('low: $low, ')
          ..write('postingStatus: $postingStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(serverId, groupName, description, high, low, postingStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupCatalogData &&
          other.serverId == this.serverId &&
          other.groupName == this.groupName &&
          other.description == this.description &&
          other.high == this.high &&
          other.low == this.low &&
          other.postingStatus == this.postingStatus);
}

class GroupCatalogCompanion extends UpdateCompanion<GroupCatalogData> {
  final Value<int> serverId;
  final Value<String> groupName;
  final Value<String> description;
  final Value<int> high;
  final Value<int> low;
  final Value<String> postingStatus;
  final Value<int> rowid;
  const GroupCatalogCompanion({
    this.serverId = const Value.absent(),
    this.groupName = const Value.absent(),
    this.description = const Value.absent(),
    this.high = const Value.absent(),
    this.low = const Value.absent(),
    this.postingStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupCatalogCompanion.insert({
    required int serverId,
    required String groupName,
    this.description = const Value.absent(),
    this.high = const Value.absent(),
    this.low = const Value.absent(),
    this.postingStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : serverId = Value(serverId),
       groupName = Value(groupName);
  static Insertable<GroupCatalogData> custom({
    Expression<int>? serverId,
    Expression<String>? groupName,
    Expression<String>? description,
    Expression<int>? high,
    Expression<int>? low,
    Expression<String>? postingStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (groupName != null) 'group_name': groupName,
      if (description != null) 'description': description,
      if (high != null) 'high': high,
      if (low != null) 'low': low,
      if (postingStatus != null) 'posting_status': postingStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupCatalogCompanion copyWith({
    Value<int>? serverId,
    Value<String>? groupName,
    Value<String>? description,
    Value<int>? high,
    Value<int>? low,
    Value<String>? postingStatus,
    Value<int>? rowid,
  }) {
    return GroupCatalogCompanion(
      serverId: serverId ?? this.serverId,
      groupName: groupName ?? this.groupName,
      description: description ?? this.description,
      high: high ?? this.high,
      low: low ?? this.low,
      postingStatus: postingStatus ?? this.postingStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (high.present) {
      map['high'] = Variable<int>(high.value);
    }
    if (low.present) {
      map['low'] = Variable<int>(low.value);
    }
    if (postingStatus.present) {
      map['posting_status'] = Variable<String>(postingStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupCatalogCompanion(')
          ..write('serverId: $serverId, ')
          ..write('groupName: $groupName, ')
          ..write('description: $description, ')
          ..write('high: $high, ')
          ..write('low: $low, ')
          ..write('postingStatus: $postingStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ArticlesTable extends Articles with TableInfo<$ArticlesTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES servers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _fromRawMeta = const VerificationMeta(
    'fromRaw',
  );
  @override
  late final GeneratedColumn<String> fromRaw = GeneratedColumn<String>(
    'from_raw',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _authorNameMeta = const VerificationMeta(
    'authorName',
  );
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
    'author_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referencesMeta = const VerificationMeta(
    'references',
  );
  @override
  late final GeneratedColumn<String> references = GeneratedColumn<String>(
    'references',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bytesMeta = const VerificationMeta('bytes');
  @override
  late final GeneratedColumn<int> bytes = GeneratedColumn<int>(
    'bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _linesMeta = const VerificationMeta('lines');
  @override
  late final GeneratedColumn<int> lines = GeneratedColumn<int>(
    'lines',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isStarredMeta = const VerificationMeta(
    'isStarred',
  );
  @override
  late final GeneratedColumn<bool> isStarred = GeneratedColumn<bool>(
    'is_starred',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_starred" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _bodyTextMeta = const VerificationMeta(
    'bodyText',
  );
  @override
  late final GeneratedColumn<String> bodyText = GeneratedColumn<String>(
    'body_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyFetchedAtMeta = const VerificationMeta(
    'bodyFetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> bodyFetchedAt =
      GeneratedColumn<DateTime>(
        'body_fetched_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    groupName,
    number,
    messageId,
    subject,
    fromRaw,
    authorName,
    date,
    references,
    bytes,
    lines,
    isRead,
    isStarred,
    bodyText,
    bodyFetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Article> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    }
    if (data.containsKey('from_raw')) {
      context.handle(
        _fromRawMeta,
        fromRaw.isAcceptableOrUnknown(data['from_raw']!, _fromRawMeta),
      );
    }
    if (data.containsKey('author_name')) {
      context.handle(
        _authorNameMeta,
        authorName.isAcceptableOrUnknown(data['author_name']!, _authorNameMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('references')) {
      context.handle(
        _referencesMeta,
        references.isAcceptableOrUnknown(data['references']!, _referencesMeta),
      );
    }
    if (data.containsKey('bytes')) {
      context.handle(
        _bytesMeta,
        bytes.isAcceptableOrUnknown(data['bytes']!, _bytesMeta),
      );
    }
    if (data.containsKey('lines')) {
      context.handle(
        _linesMeta,
        lines.isAcceptableOrUnknown(data['lines']!, _linesMeta),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('is_starred')) {
      context.handle(
        _isStarredMeta,
        isStarred.isAcceptableOrUnknown(data['is_starred']!, _isStarredMeta),
      );
    }
    if (data.containsKey('body_text')) {
      context.handle(
        _bodyTextMeta,
        bodyText.isAcceptableOrUnknown(data['body_text']!, _bodyTextMeta),
      );
    }
    if (data.containsKey('body_fetched_at')) {
      context.handle(
        _bodyFetchedAtMeta,
        bodyFetchedAt.isAcceptableOrUnknown(
          data['body_fetched_at']!,
          _bodyFetchedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {serverId, groupName, number},
  ];
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Article(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_id'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      fromRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_raw'],
      )!,
      authorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_name'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      ),
      references: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}references'],
      )!,
      bytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bytes'],
      )!,
      lines: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lines'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      isStarred: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_starred'],
      )!,
      bodyText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_text'],
      ),
      bodyFetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}body_fetched_at'],
      ),
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }
}

class Article extends DataClass implements Insertable<Article> {
  final int id;
  final int serverId;
  final String groupName;
  final int number;
  final String messageId;
  final String subject;
  final String fromRaw;
  final String authorName;
  final DateTime? date;
  final String references;
  final int bytes;
  final int lines;
  final bool isRead;
  final bool isStarred;
  final String? bodyText;
  final DateTime? bodyFetchedAt;
  const Article({
    required this.id,
    required this.serverId,
    required this.groupName,
    required this.number,
    required this.messageId,
    required this.subject,
    required this.fromRaw,
    required this.authorName,
    this.date,
    required this.references,
    required this.bytes,
    required this.lines,
    required this.isRead,
    required this.isStarred,
    this.bodyText,
    this.bodyFetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<int>(serverId);
    map['group_name'] = Variable<String>(groupName);
    map['number'] = Variable<int>(number);
    map['message_id'] = Variable<String>(messageId);
    map['subject'] = Variable<String>(subject);
    map['from_raw'] = Variable<String>(fromRaw);
    map['author_name'] = Variable<String>(authorName);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    map['references'] = Variable<String>(references);
    map['bytes'] = Variable<int>(bytes);
    map['lines'] = Variable<int>(lines);
    map['is_read'] = Variable<bool>(isRead);
    map['is_starred'] = Variable<bool>(isStarred);
    if (!nullToAbsent || bodyText != null) {
      map['body_text'] = Variable<String>(bodyText);
    }
    if (!nullToAbsent || bodyFetchedAt != null) {
      map['body_fetched_at'] = Variable<DateTime>(bodyFetchedAt);
    }
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      id: Value(id),
      serverId: Value(serverId),
      groupName: Value(groupName),
      number: Value(number),
      messageId: Value(messageId),
      subject: Value(subject),
      fromRaw: Value(fromRaw),
      authorName: Value(authorName),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      references: Value(references),
      bytes: Value(bytes),
      lines: Value(lines),
      isRead: Value(isRead),
      isStarred: Value(isStarred),
      bodyText: bodyText == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyText),
      bodyFetchedAt: bodyFetchedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFetchedAt),
    );
  }

  factory Article.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<int>(json['serverId']),
      groupName: serializer.fromJson<String>(json['groupName']),
      number: serializer.fromJson<int>(json['number']),
      messageId: serializer.fromJson<String>(json['messageId']),
      subject: serializer.fromJson<String>(json['subject']),
      fromRaw: serializer.fromJson<String>(json['fromRaw']),
      authorName: serializer.fromJson<String>(json['authorName']),
      date: serializer.fromJson<DateTime?>(json['date']),
      references: serializer.fromJson<String>(json['references']),
      bytes: serializer.fromJson<int>(json['bytes']),
      lines: serializer.fromJson<int>(json['lines']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      isStarred: serializer.fromJson<bool>(json['isStarred']),
      bodyText: serializer.fromJson<String?>(json['bodyText']),
      bodyFetchedAt: serializer.fromJson<DateTime?>(json['bodyFetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<int>(serverId),
      'groupName': serializer.toJson<String>(groupName),
      'number': serializer.toJson<int>(number),
      'messageId': serializer.toJson<String>(messageId),
      'subject': serializer.toJson<String>(subject),
      'fromRaw': serializer.toJson<String>(fromRaw),
      'authorName': serializer.toJson<String>(authorName),
      'date': serializer.toJson<DateTime?>(date),
      'references': serializer.toJson<String>(references),
      'bytes': serializer.toJson<int>(bytes),
      'lines': serializer.toJson<int>(lines),
      'isRead': serializer.toJson<bool>(isRead),
      'isStarred': serializer.toJson<bool>(isStarred),
      'bodyText': serializer.toJson<String?>(bodyText),
      'bodyFetchedAt': serializer.toJson<DateTime?>(bodyFetchedAt),
    };
  }

  Article copyWith({
    int? id,
    int? serverId,
    String? groupName,
    int? number,
    String? messageId,
    String? subject,
    String? fromRaw,
    String? authorName,
    Value<DateTime?> date = const Value.absent(),
    String? references,
    int? bytes,
    int? lines,
    bool? isRead,
    bool? isStarred,
    Value<String?> bodyText = const Value.absent(),
    Value<DateTime?> bodyFetchedAt = const Value.absent(),
  }) => Article(
    id: id ?? this.id,
    serverId: serverId ?? this.serverId,
    groupName: groupName ?? this.groupName,
    number: number ?? this.number,
    messageId: messageId ?? this.messageId,
    subject: subject ?? this.subject,
    fromRaw: fromRaw ?? this.fromRaw,
    authorName: authorName ?? this.authorName,
    date: date.present ? date.value : this.date,
    references: references ?? this.references,
    bytes: bytes ?? this.bytes,
    lines: lines ?? this.lines,
    isRead: isRead ?? this.isRead,
    isStarred: isStarred ?? this.isStarred,
    bodyText: bodyText.present ? bodyText.value : this.bodyText,
    bodyFetchedAt: bodyFetchedAt.present
        ? bodyFetchedAt.value
        : this.bodyFetchedAt,
  );
  Article copyWithCompanion(ArticlesCompanion data) {
    return Article(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      number: data.number.present ? data.number.value : this.number,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      subject: data.subject.present ? data.subject.value : this.subject,
      fromRaw: data.fromRaw.present ? data.fromRaw.value : this.fromRaw,
      authorName: data.authorName.present
          ? data.authorName.value
          : this.authorName,
      date: data.date.present ? data.date.value : this.date,
      references: data.references.present
          ? data.references.value
          : this.references,
      bytes: data.bytes.present ? data.bytes.value : this.bytes,
      lines: data.lines.present ? data.lines.value : this.lines,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      isStarred: data.isStarred.present ? data.isStarred.value : this.isStarred,
      bodyText: data.bodyText.present ? data.bodyText.value : this.bodyText,
      bodyFetchedAt: data.bodyFetchedAt.present
          ? data.bodyFetchedAt.value
          : this.bodyFetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('groupName: $groupName, ')
          ..write('number: $number, ')
          ..write('messageId: $messageId, ')
          ..write('subject: $subject, ')
          ..write('fromRaw: $fromRaw, ')
          ..write('authorName: $authorName, ')
          ..write('date: $date, ')
          ..write('references: $references, ')
          ..write('bytes: $bytes, ')
          ..write('lines: $lines, ')
          ..write('isRead: $isRead, ')
          ..write('isStarred: $isStarred, ')
          ..write('bodyText: $bodyText, ')
          ..write('bodyFetchedAt: $bodyFetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    groupName,
    number,
    messageId,
    subject,
    fromRaw,
    authorName,
    date,
    references,
    bytes,
    lines,
    isRead,
    isStarred,
    bodyText,
    bodyFetchedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.groupName == this.groupName &&
          other.number == this.number &&
          other.messageId == this.messageId &&
          other.subject == this.subject &&
          other.fromRaw == this.fromRaw &&
          other.authorName == this.authorName &&
          other.date == this.date &&
          other.references == this.references &&
          other.bytes == this.bytes &&
          other.lines == this.lines &&
          other.isRead == this.isRead &&
          other.isStarred == this.isStarred &&
          other.bodyText == this.bodyText &&
          other.bodyFetchedAt == this.bodyFetchedAt);
}

class ArticlesCompanion extends UpdateCompanion<Article> {
  final Value<int> id;
  final Value<int> serverId;
  final Value<String> groupName;
  final Value<int> number;
  final Value<String> messageId;
  final Value<String> subject;
  final Value<String> fromRaw;
  final Value<String> authorName;
  final Value<DateTime?> date;
  final Value<String> references;
  final Value<int> bytes;
  final Value<int> lines;
  final Value<bool> isRead;
  final Value<bool> isStarred;
  final Value<String?> bodyText;
  final Value<DateTime?> bodyFetchedAt;
  const ArticlesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.groupName = const Value.absent(),
    this.number = const Value.absent(),
    this.messageId = const Value.absent(),
    this.subject = const Value.absent(),
    this.fromRaw = const Value.absent(),
    this.authorName = const Value.absent(),
    this.date = const Value.absent(),
    this.references = const Value.absent(),
    this.bytes = const Value.absent(),
    this.lines = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.bodyText = const Value.absent(),
    this.bodyFetchedAt = const Value.absent(),
  });
  ArticlesCompanion.insert({
    this.id = const Value.absent(),
    required int serverId,
    required String groupName,
    required int number,
    required String messageId,
    this.subject = const Value.absent(),
    this.fromRaw = const Value.absent(),
    this.authorName = const Value.absent(),
    this.date = const Value.absent(),
    this.references = const Value.absent(),
    this.bytes = const Value.absent(),
    this.lines = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.bodyText = const Value.absent(),
    this.bodyFetchedAt = const Value.absent(),
  }) : serverId = Value(serverId),
       groupName = Value(groupName),
       number = Value(number),
       messageId = Value(messageId);
  static Insertable<Article> custom({
    Expression<int>? id,
    Expression<int>? serverId,
    Expression<String>? groupName,
    Expression<int>? number,
    Expression<String>? messageId,
    Expression<String>? subject,
    Expression<String>? fromRaw,
    Expression<String>? authorName,
    Expression<DateTime>? date,
    Expression<String>? references,
    Expression<int>? bytes,
    Expression<int>? lines,
    Expression<bool>? isRead,
    Expression<bool>? isStarred,
    Expression<String>? bodyText,
    Expression<DateTime>? bodyFetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (groupName != null) 'group_name': groupName,
      if (number != null) 'number': number,
      if (messageId != null) 'message_id': messageId,
      if (subject != null) 'subject': subject,
      if (fromRaw != null) 'from_raw': fromRaw,
      if (authorName != null) 'author_name': authorName,
      if (date != null) 'date': date,
      if (references != null) 'references': references,
      if (bytes != null) 'bytes': bytes,
      if (lines != null) 'lines': lines,
      if (isRead != null) 'is_read': isRead,
      if (isStarred != null) 'is_starred': isStarred,
      if (bodyText != null) 'body_text': bodyText,
      if (bodyFetchedAt != null) 'body_fetched_at': bodyFetchedAt,
    });
  }

  ArticlesCompanion copyWith({
    Value<int>? id,
    Value<int>? serverId,
    Value<String>? groupName,
    Value<int>? number,
    Value<String>? messageId,
    Value<String>? subject,
    Value<String>? fromRaw,
    Value<String>? authorName,
    Value<DateTime?>? date,
    Value<String>? references,
    Value<int>? bytes,
    Value<int>? lines,
    Value<bool>? isRead,
    Value<bool>? isStarred,
    Value<String?>? bodyText,
    Value<DateTime?>? bodyFetchedAt,
  }) {
    return ArticlesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      groupName: groupName ?? this.groupName,
      number: number ?? this.number,
      messageId: messageId ?? this.messageId,
      subject: subject ?? this.subject,
      fromRaw: fromRaw ?? this.fromRaw,
      authorName: authorName ?? this.authorName,
      date: date ?? this.date,
      references: references ?? this.references,
      bytes: bytes ?? this.bytes,
      lines: lines ?? this.lines,
      isRead: isRead ?? this.isRead,
      isStarred: isStarred ?? this.isStarred,
      bodyText: bodyText ?? this.bodyText,
      bodyFetchedAt: bodyFetchedAt ?? this.bodyFetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (fromRaw.present) {
      map['from_raw'] = Variable<String>(fromRaw.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (references.present) {
      map['references'] = Variable<String>(references.value);
    }
    if (bytes.present) {
      map['bytes'] = Variable<int>(bytes.value);
    }
    if (lines.present) {
      map['lines'] = Variable<int>(lines.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (isStarred.present) {
      map['is_starred'] = Variable<bool>(isStarred.value);
    }
    if (bodyText.present) {
      map['body_text'] = Variable<String>(bodyText.value);
    }
    if (bodyFetchedAt.present) {
      map['body_fetched_at'] = Variable<DateTime>(bodyFetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('groupName: $groupName, ')
          ..write('number: $number, ')
          ..write('messageId: $messageId, ')
          ..write('subject: $subject, ')
          ..write('fromRaw: $fromRaw, ')
          ..write('authorName: $authorName, ')
          ..write('date: $date, ')
          ..write('references: $references, ')
          ..write('bytes: $bytes, ')
          ..write('lines: $lines, ')
          ..write('isRead: $isRead, ')
          ..write('isStarred: $isStarred, ')
          ..write('bodyText: $bodyText, ')
          ..write('bodyFetchedAt: $bodyFetchedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _syncIntervalMinutesMeta =
      const VerificationMeta('syncIntervalMinutes');
  @override
  late final GeneratedColumn<int> syncIntervalMinutes = GeneratedColumn<int>(
    'sync_interval_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _maxArticlesPerSyncMeta =
      const VerificationMeta('maxArticlesPerSync');
  @override
  late final GeneratedColumn<int> maxArticlesPerSync = GeneratedColumn<int>(
    'max_articles_per_sync',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(500),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncIntervalMinutes,
    maxArticlesPerSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_interval_minutes')) {
      context.handle(
        _syncIntervalMinutesMeta,
        syncIntervalMinutes.isAcceptableOrUnknown(
          data['sync_interval_minutes']!,
          _syncIntervalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('max_articles_per_sync')) {
      context.handle(
        _maxArticlesPerSyncMeta,
        maxArticlesPerSync.isAcceptableOrUnknown(
          data['max_articles_per_sync']!,
          _maxArticlesPerSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncIntervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_interval_minutes'],
      )!,
      maxArticlesPerSync: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_articles_per_sync'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final int syncIntervalMinutes;
  final int maxArticlesPerSync;
  const AppSetting({
    required this.id,
    required this.syncIntervalMinutes,
    required this.maxArticlesPerSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_interval_minutes'] = Variable<int>(syncIntervalMinutes);
    map['max_articles_per_sync'] = Variable<int>(maxArticlesPerSync);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      syncIntervalMinutes: Value(syncIntervalMinutes),
      maxArticlesPerSync: Value(maxArticlesPerSync),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      syncIntervalMinutes: serializer.fromJson<int>(
        json['syncIntervalMinutes'],
      ),
      maxArticlesPerSync: serializer.fromJson<int>(json['maxArticlesPerSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncIntervalMinutes': serializer.toJson<int>(syncIntervalMinutes),
      'maxArticlesPerSync': serializer.toJson<int>(maxArticlesPerSync),
    };
  }

  AppSetting copyWith({
    int? id,
    int? syncIntervalMinutes,
    int? maxArticlesPerSync,
  }) => AppSetting(
    id: id ?? this.id,
    syncIntervalMinutes: syncIntervalMinutes ?? this.syncIntervalMinutes,
    maxArticlesPerSync: maxArticlesPerSync ?? this.maxArticlesPerSync,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      syncIntervalMinutes: data.syncIntervalMinutes.present
          ? data.syncIntervalMinutes.value
          : this.syncIntervalMinutes,
      maxArticlesPerSync: data.maxArticlesPerSync.present
          ? data.maxArticlesPerSync.value
          : this.maxArticlesPerSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('syncIntervalMinutes: $syncIntervalMinutes, ')
          ..write('maxArticlesPerSync: $maxArticlesPerSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, syncIntervalMinutes, maxArticlesPerSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.syncIntervalMinutes == this.syncIntervalMinutes &&
          other.maxArticlesPerSync == this.maxArticlesPerSync);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<int> syncIntervalMinutes;
  final Value<int> maxArticlesPerSync;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.syncIntervalMinutes = const Value.absent(),
    this.maxArticlesPerSync = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.syncIntervalMinutes = const Value.absent(),
    this.maxArticlesPerSync = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<int>? syncIntervalMinutes,
    Expression<int>? maxArticlesPerSync,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncIntervalMinutes != null)
        'sync_interval_minutes': syncIntervalMinutes,
      if (maxArticlesPerSync != null)
        'max_articles_per_sync': maxArticlesPerSync,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? syncIntervalMinutes,
    Value<int>? maxArticlesPerSync,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      syncIntervalMinutes: syncIntervalMinutes ?? this.syncIntervalMinutes,
      maxArticlesPerSync: maxArticlesPerSync ?? this.maxArticlesPerSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncIntervalMinutes.present) {
      map['sync_interval_minutes'] = Variable<int>(syncIntervalMinutes.value);
    }
    if (maxArticlesPerSync.present) {
      map['max_articles_per_sync'] = Variable<int>(maxArticlesPerSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('syncIntervalMinutes: $syncIntervalMinutes, ')
          ..write('maxArticlesPerSync: $maxArticlesPerSync')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ServersTable servers = $ServersTable(this);
  late final $SubscriptionsTable subscriptions = $SubscriptionsTable(this);
  late final $GroupCatalogTable groupCatalog = $GroupCatalogTable(this);
  late final $ArticlesTable articles = $ArticlesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    servers,
    subscriptions,
    groupCatalog,
    articles,
    appSettings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'servers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subscriptions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'servers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('group_catalog', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'servers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('articles', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ServersTableCreateCompanionBuilder =
    ServersCompanion Function({
      Value<int> id,
      required String name,
      required String host,
      Value<int> port,
      Value<bool> useTls,
      Value<bool> allowBadCertificate,
      Value<String?> username,
      Value<bool> requiresAuth,
      Value<String?> fromName,
      Value<String?> email,
      Value<int> sortOrder,
    });
typedef $$ServersTableUpdateCompanionBuilder =
    ServersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> host,
      Value<int> port,
      Value<bool> useTls,
      Value<bool> allowBadCertificate,
      Value<String?> username,
      Value<bool> requiresAuth,
      Value<String?> fromName,
      Value<String?> email,
      Value<int> sortOrder,
    });

final class $$ServersTableReferences
    extends BaseReferences<_$AppDatabase, $ServersTable, Server> {
  $$ServersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SubscriptionsTable, List<Subscription>>
  _subscriptionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.subscriptions,
    aliasName: $_aliasNameGenerator(db.servers.id, db.subscriptions.serverId),
  );

  $$SubscriptionsTableProcessedTableManager get subscriptionsRefs {
    final manager = $$SubscriptionsTableTableManager(
      $_db,
      $_db.subscriptions,
    ).filter((f) => f.serverId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_subscriptionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GroupCatalogTable, List<GroupCatalogData>>
  _groupCatalogRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.groupCatalog,
    aliasName: $_aliasNameGenerator(db.servers.id, db.groupCatalog.serverId),
  );

  $$GroupCatalogTableProcessedTableManager get groupCatalogRefs {
    final manager = $$GroupCatalogTableTableManager(
      $_db,
      $_db.groupCatalog,
    ).filter((f) => f.serverId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_groupCatalogRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ArticlesTable, List<Article>> _articlesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.articles,
    aliasName: $_aliasNameGenerator(db.servers.id, db.articles.serverId),
  );

  $$ArticlesTableProcessedTableManager get articlesRefs {
    final manager = $$ArticlesTableTableManager(
      $_db,
      $_db.articles,
    ).filter((f) => f.serverId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_articlesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ServersTableFilterComposer
    extends Composer<_$AppDatabase, $ServersTable> {
  $$ServersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get host => $composableBuilder(
    column: $table.host,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get port => $composableBuilder(
    column: $table.port,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useTls => $composableBuilder(
    column: $table.useTls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allowBadCertificate => $composableBuilder(
    column: $table.allowBadCertificate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresAuth => $composableBuilder(
    column: $table.requiresAuth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromName => $composableBuilder(
    column: $table.fromName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> subscriptionsRefs(
    Expression<bool> Function($$SubscriptionsTableFilterComposer f) f,
  ) {
    final $$SubscriptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subscriptions,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubscriptionsTableFilterComposer(
            $db: $db,
            $table: $db.subscriptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> groupCatalogRefs(
    Expression<bool> Function($$GroupCatalogTableFilterComposer f) f,
  ) {
    final $$GroupCatalogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupCatalog,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupCatalogTableFilterComposer(
            $db: $db,
            $table: $db.groupCatalog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> articlesRefs(
    Expression<bool> Function($$ArticlesTableFilterComposer f) f,
  ) {
    final $$ArticlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.articles,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArticlesTableFilterComposer(
            $db: $db,
            $table: $db.articles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServersTableOrderingComposer
    extends Composer<_$AppDatabase, $ServersTable> {
  $$ServersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get host => $composableBuilder(
    column: $table.host,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get port => $composableBuilder(
    column: $table.port,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useTls => $composableBuilder(
    column: $table.useTls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allowBadCertificate => $composableBuilder(
    column: $table.allowBadCertificate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresAuth => $composableBuilder(
    column: $table.requiresAuth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromName => $composableBuilder(
    column: $table.fromName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServersTable> {
  $$ServersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get host =>
      $composableBuilder(column: $table.host, builder: (column) => column);

  GeneratedColumn<int> get port =>
      $composableBuilder(column: $table.port, builder: (column) => column);

  GeneratedColumn<bool> get useTls =>
      $composableBuilder(column: $table.useTls, builder: (column) => column);

  GeneratedColumn<bool> get allowBadCertificate => $composableBuilder(
    column: $table.allowBadCertificate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<bool> get requiresAuth => $composableBuilder(
    column: $table.requiresAuth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fromName =>
      $composableBuilder(column: $table.fromName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> subscriptionsRefs<T extends Object>(
    Expression<T> Function($$SubscriptionsTableAnnotationComposer a) f,
  ) {
    final $$SubscriptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subscriptions,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubscriptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.subscriptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> groupCatalogRefs<T extends Object>(
    Expression<T> Function($$GroupCatalogTableAnnotationComposer a) f,
  ) {
    final $$GroupCatalogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.groupCatalog,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupCatalogTableAnnotationComposer(
            $db: $db,
            $table: $db.groupCatalog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> articlesRefs<T extends Object>(
    Expression<T> Function($$ArticlesTableAnnotationComposer a) f,
  ) {
    final $$ArticlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.articles,
      getReferencedColumn: (t) => t.serverId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArticlesTableAnnotationComposer(
            $db: $db,
            $table: $db.articles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServersTable,
          Server,
          $$ServersTableFilterComposer,
          $$ServersTableOrderingComposer,
          $$ServersTableAnnotationComposer,
          $$ServersTableCreateCompanionBuilder,
          $$ServersTableUpdateCompanionBuilder,
          (Server, $$ServersTableReferences),
          Server,
          PrefetchHooks Function({
            bool subscriptionsRefs,
            bool groupCatalogRefs,
            bool articlesRefs,
          })
        > {
  $$ServersTableTableManager(_$AppDatabase db, $ServersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> host = const Value.absent(),
                Value<int> port = const Value.absent(),
                Value<bool> useTls = const Value.absent(),
                Value<bool> allowBadCertificate = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<bool> requiresAuth = const Value.absent(),
                Value<String?> fromName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ServersCompanion(
                id: id,
                name: name,
                host: host,
                port: port,
                useTls: useTls,
                allowBadCertificate: allowBadCertificate,
                username: username,
                requiresAuth: requiresAuth,
                fromName: fromName,
                email: email,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String host,
                Value<int> port = const Value.absent(),
                Value<bool> useTls = const Value.absent(),
                Value<bool> allowBadCertificate = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<bool> requiresAuth = const Value.absent(),
                Value<String?> fromName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ServersCompanion.insert(
                id: id,
                name: name,
                host: host,
                port: port,
                useTls: useTls,
                allowBadCertificate: allowBadCertificate,
                username: username,
                requiresAuth: requiresAuth,
                fromName: fromName,
                email: email,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ServersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subscriptionsRefs = false,
                groupCatalogRefs = false,
                articlesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (subscriptionsRefs) db.subscriptions,
                    if (groupCatalogRefs) db.groupCatalog,
                    if (articlesRefs) db.articles,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subscriptionsRefs)
                        await $_getPrefetchedData<
                          Server,
                          $ServersTable,
                          Subscription
                        >(
                          currentTable: table,
                          referencedTable: $$ServersTableReferences
                              ._subscriptionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServersTableReferences(
                                db,
                                table,
                                p0,
                              ).subscriptionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.serverId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (groupCatalogRefs)
                        await $_getPrefetchedData<
                          Server,
                          $ServersTable,
                          GroupCatalogData
                        >(
                          currentTable: table,
                          referencedTable: $$ServersTableReferences
                              ._groupCatalogRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServersTableReferences(
                                db,
                                table,
                                p0,
                              ).groupCatalogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.serverId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (articlesRefs)
                        await $_getPrefetchedData<
                          Server,
                          $ServersTable,
                          Article
                        >(
                          currentTable: table,
                          referencedTable: $$ServersTableReferences
                              ._articlesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServersTableReferences(
                                db,
                                table,
                                p0,
                              ).articlesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.serverId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ServersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServersTable,
      Server,
      $$ServersTableFilterComposer,
      $$ServersTableOrderingComposer,
      $$ServersTableAnnotationComposer,
      $$ServersTableCreateCompanionBuilder,
      $$ServersTableUpdateCompanionBuilder,
      (Server, $$ServersTableReferences),
      Server,
      PrefetchHooks Function({
        bool subscriptionsRefs,
        bool groupCatalogRefs,
        bool articlesRefs,
      })
    >;
typedef $$SubscriptionsTableCreateCompanionBuilder =
    SubscriptionsCompanion Function({
      Value<int> id,
      required int serverId,
      required String groupName,
      Value<String> description,
      Value<int> lastReadNumber,
      Value<int> serverHigh,
      Value<int> unreadCount,
      Value<DateTime?> lastSyncedAt,
      Value<int> sortOrder,
    });
typedef $$SubscriptionsTableUpdateCompanionBuilder =
    SubscriptionsCompanion Function({
      Value<int> id,
      Value<int> serverId,
      Value<String> groupName,
      Value<String> description,
      Value<int> lastReadNumber,
      Value<int> serverHigh,
      Value<int> unreadCount,
      Value<DateTime?> lastSyncedAt,
      Value<int> sortOrder,
    });

final class $$SubscriptionsTableReferences
    extends BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription> {
  $$SubscriptionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ServersTable _serverIdTable(_$AppDatabase db) =>
      db.servers.createAlias(
        $_aliasNameGenerator(db.subscriptions.serverId, db.servers.id),
      );

  $$ServersTableProcessedTableManager get serverId {
    final $_column = $_itemColumn<int>('server_id')!;

    final manager = $$ServersTableTableManager(
      $_db,
      $_db.servers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serverIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SubscriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableFilterComposer({
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

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastReadNumber => $composableBuilder(
    column: $table.lastReadNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverHigh => $composableBuilder(
    column: $table.serverHigh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ServersTableFilterComposer get serverId {
    final $$ServersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.servers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServersTableFilterComposer(
            $db: $db,
            $table: $db.servers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubscriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableOrderingComposer({
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

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastReadNumber => $composableBuilder(
    column: $table.lastReadNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverHigh => $composableBuilder(
    column: $table.serverHigh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ServersTableOrderingComposer get serverId {
    final $$ServersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.servers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServersTableOrderingComposer(
            $db: $db,
            $table: $db.servers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubscriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastReadNumber => $composableBuilder(
    column: $table.lastReadNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverHigh => $composableBuilder(
    column: $table.serverHigh,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ServersTableAnnotationComposer get serverId {
    final $$ServersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.servers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServersTableAnnotationComposer(
            $db: $db,
            $table: $db.servers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubscriptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubscriptionsTable,
          Subscription,
          $$SubscriptionsTableFilterComposer,
          $$SubscriptionsTableOrderingComposer,
          $$SubscriptionsTableAnnotationComposer,
          $$SubscriptionsTableCreateCompanionBuilder,
          $$SubscriptionsTableUpdateCompanionBuilder,
          (Subscription, $$SubscriptionsTableReferences),
          Subscription,
          PrefetchHooks Function({bool serverId})
        > {
  $$SubscriptionsTableTableManager(_$AppDatabase db, $SubscriptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> serverId = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> lastReadNumber = const Value.absent(),
                Value<int> serverHigh = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => SubscriptionsCompanion(
                id: id,
                serverId: serverId,
                groupName: groupName,
                description: description,
                lastReadNumber: lastReadNumber,
                serverHigh: serverHigh,
                unreadCount: unreadCount,
                lastSyncedAt: lastSyncedAt,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int serverId,
                required String groupName,
                Value<String> description = const Value.absent(),
                Value<int> lastReadNumber = const Value.absent(),
                Value<int> serverHigh = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => SubscriptionsCompanion.insert(
                id: id,
                serverId: serverId,
                groupName: groupName,
                description: description,
                lastReadNumber: lastReadNumber,
                serverHigh: serverHigh,
                unreadCount: unreadCount,
                lastSyncedAt: lastSyncedAt,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubscriptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({serverId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (serverId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.serverId,
                                referencedTable: $$SubscriptionsTableReferences
                                    ._serverIdTable(db),
                                referencedColumn: $$SubscriptionsTableReferences
                                    ._serverIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SubscriptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubscriptionsTable,
      Subscription,
      $$SubscriptionsTableFilterComposer,
      $$SubscriptionsTableOrderingComposer,
      $$SubscriptionsTableAnnotationComposer,
      $$SubscriptionsTableCreateCompanionBuilder,
      $$SubscriptionsTableUpdateCompanionBuilder,
      (Subscription, $$SubscriptionsTableReferences),
      Subscription,
      PrefetchHooks Function({bool serverId})
    >;
typedef $$GroupCatalogTableCreateCompanionBuilder =
    GroupCatalogCompanion Function({
      required int serverId,
      required String groupName,
      Value<String> description,
      Value<int> high,
      Value<int> low,
      Value<String> postingStatus,
      Value<int> rowid,
    });
typedef $$GroupCatalogTableUpdateCompanionBuilder =
    GroupCatalogCompanion Function({
      Value<int> serverId,
      Value<String> groupName,
      Value<String> description,
      Value<int> high,
      Value<int> low,
      Value<String> postingStatus,
      Value<int> rowid,
    });

final class $$GroupCatalogTableReferences
    extends
        BaseReferences<_$AppDatabase, $GroupCatalogTable, GroupCatalogData> {
  $$GroupCatalogTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ServersTable _serverIdTable(_$AppDatabase db) =>
      db.servers.createAlias(
        $_aliasNameGenerator(db.groupCatalog.serverId, db.servers.id),
      );

  $$ServersTableProcessedTableManager get serverId {
    final $_column = $_itemColumn<int>('server_id')!;

    final manager = $$ServersTableTableManager(
      $_db,
      $_db.servers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serverIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GroupCatalogTableFilterComposer
    extends Composer<_$AppDatabase, $GroupCatalogTable> {
  $$GroupCatalogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get high => $composableBuilder(
    column: $table.high,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get low => $composableBuilder(
    column: $table.low,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postingStatus => $composableBuilder(
    column: $table.postingStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$ServersTableFilterComposer get serverId {
    final $$ServersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.servers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServersTableFilterComposer(
            $db: $db,
            $table: $db.servers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupCatalogTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupCatalogTable> {
  $$GroupCatalogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get high => $composableBuilder(
    column: $table.high,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get low => $composableBuilder(
    column: $table.low,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postingStatus => $composableBuilder(
    column: $table.postingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$ServersTableOrderingComposer get serverId {
    final $$ServersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.servers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServersTableOrderingComposer(
            $db: $db,
            $table: $db.servers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupCatalogTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupCatalogTable> {
  $$GroupCatalogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get high =>
      $composableBuilder(column: $table.high, builder: (column) => column);

  GeneratedColumn<int> get low =>
      $composableBuilder(column: $table.low, builder: (column) => column);

  GeneratedColumn<String> get postingStatus => $composableBuilder(
    column: $table.postingStatus,
    builder: (column) => column,
  );

  $$ServersTableAnnotationComposer get serverId {
    final $$ServersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.servers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServersTableAnnotationComposer(
            $db: $db,
            $table: $db.servers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GroupCatalogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupCatalogTable,
          GroupCatalogData,
          $$GroupCatalogTableFilterComposer,
          $$GroupCatalogTableOrderingComposer,
          $$GroupCatalogTableAnnotationComposer,
          $$GroupCatalogTableCreateCompanionBuilder,
          $$GroupCatalogTableUpdateCompanionBuilder,
          (GroupCatalogData, $$GroupCatalogTableReferences),
          GroupCatalogData,
          PrefetchHooks Function({bool serverId})
        > {
  $$GroupCatalogTableTableManager(_$AppDatabase db, $GroupCatalogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupCatalogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupCatalogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupCatalogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> serverId = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> high = const Value.absent(),
                Value<int> low = const Value.absent(),
                Value<String> postingStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupCatalogCompanion(
                serverId: serverId,
                groupName: groupName,
                description: description,
                high: high,
                low: low,
                postingStatus: postingStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int serverId,
                required String groupName,
                Value<String> description = const Value.absent(),
                Value<int> high = const Value.absent(),
                Value<int> low = const Value.absent(),
                Value<String> postingStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupCatalogCompanion.insert(
                serverId: serverId,
                groupName: groupName,
                description: description,
                high: high,
                low: low,
                postingStatus: postingStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GroupCatalogTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({serverId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (serverId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.serverId,
                                referencedTable: $$GroupCatalogTableReferences
                                    ._serverIdTable(db),
                                referencedColumn: $$GroupCatalogTableReferences
                                    ._serverIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GroupCatalogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupCatalogTable,
      GroupCatalogData,
      $$GroupCatalogTableFilterComposer,
      $$GroupCatalogTableOrderingComposer,
      $$GroupCatalogTableAnnotationComposer,
      $$GroupCatalogTableCreateCompanionBuilder,
      $$GroupCatalogTableUpdateCompanionBuilder,
      (GroupCatalogData, $$GroupCatalogTableReferences),
      GroupCatalogData,
      PrefetchHooks Function({bool serverId})
    >;
typedef $$ArticlesTableCreateCompanionBuilder =
    ArticlesCompanion Function({
      Value<int> id,
      required int serverId,
      required String groupName,
      required int number,
      required String messageId,
      Value<String> subject,
      Value<String> fromRaw,
      Value<String> authorName,
      Value<DateTime?> date,
      Value<String> references,
      Value<int> bytes,
      Value<int> lines,
      Value<bool> isRead,
      Value<bool> isStarred,
      Value<String?> bodyText,
      Value<DateTime?> bodyFetchedAt,
    });
typedef $$ArticlesTableUpdateCompanionBuilder =
    ArticlesCompanion Function({
      Value<int> id,
      Value<int> serverId,
      Value<String> groupName,
      Value<int> number,
      Value<String> messageId,
      Value<String> subject,
      Value<String> fromRaw,
      Value<String> authorName,
      Value<DateTime?> date,
      Value<String> references,
      Value<int> bytes,
      Value<int> lines,
      Value<bool> isRead,
      Value<bool> isStarred,
      Value<String?> bodyText,
      Value<DateTime?> bodyFetchedAt,
    });

final class $$ArticlesTableReferences
    extends BaseReferences<_$AppDatabase, $ArticlesTable, Article> {
  $$ArticlesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ServersTable _serverIdTable(_$AppDatabase db) => db.servers
      .createAlias($_aliasNameGenerator(db.articles.serverId, db.servers.id));

  $$ServersTableProcessedTableManager get serverId {
    final $_column = $_itemColumn<int>('server_id')!;

    final manager = $$ServersTableTableManager(
      $_db,
      $_db.servers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serverIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableFilterComposer({
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

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromRaw => $composableBuilder(
    column: $table.fromRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get references => $composableBuilder(
    column: $table.references,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lines => $composableBuilder(
    column: $table.lines,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyText => $composableBuilder(
    column: $table.bodyText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bodyFetchedAt => $composableBuilder(
    column: $table.bodyFetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ServersTableFilterComposer get serverId {
    final $$ServersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.servers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServersTableFilterComposer(
            $db: $db,
            $table: $db.servers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableOrderingComposer({
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

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromRaw => $composableBuilder(
    column: $table.fromRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get references => $composableBuilder(
    column: $table.references,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lines => $composableBuilder(
    column: $table.lines,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyText => $composableBuilder(
    column: $table.bodyText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bodyFetchedAt => $composableBuilder(
    column: $table.bodyFetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ServersTableOrderingComposer get serverId {
    final $$ServersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.servers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServersTableOrderingComposer(
            $db: $db,
            $table: $db.servers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get fromRaw =>
      $composableBuilder(column: $table.fromRaw, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get references => $composableBuilder(
    column: $table.references,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bytes =>
      $composableBuilder(column: $table.bytes, builder: (column) => column);

  GeneratedColumn<int> get lines =>
      $composableBuilder(column: $table.lines, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<bool> get isStarred =>
      $composableBuilder(column: $table.isStarred, builder: (column) => column);

  GeneratedColumn<String> get bodyText =>
      $composableBuilder(column: $table.bodyText, builder: (column) => column);

  GeneratedColumn<DateTime> get bodyFetchedAt => $composableBuilder(
    column: $table.bodyFetchedAt,
    builder: (column) => column,
  );

  $$ServersTableAnnotationComposer get serverId {
    final $$ServersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serverId,
      referencedTable: $db.servers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServersTableAnnotationComposer(
            $db: $db,
            $table: $db.servers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArticlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArticlesTable,
          Article,
          $$ArticlesTableFilterComposer,
          $$ArticlesTableOrderingComposer,
          $$ArticlesTableAnnotationComposer,
          $$ArticlesTableCreateCompanionBuilder,
          $$ArticlesTableUpdateCompanionBuilder,
          (Article, $$ArticlesTableReferences),
          Article,
          PrefetchHooks Function({bool serverId})
        > {
  $$ArticlesTableTableManager(_$AppDatabase db, $ArticlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> serverId = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<int> number = const Value.absent(),
                Value<String> messageId = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String> fromRaw = const Value.absent(),
                Value<String> authorName = const Value.absent(),
                Value<DateTime?> date = const Value.absent(),
                Value<String> references = const Value.absent(),
                Value<int> bytes = const Value.absent(),
                Value<int> lines = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isStarred = const Value.absent(),
                Value<String?> bodyText = const Value.absent(),
                Value<DateTime?> bodyFetchedAt = const Value.absent(),
              }) => ArticlesCompanion(
                id: id,
                serverId: serverId,
                groupName: groupName,
                number: number,
                messageId: messageId,
                subject: subject,
                fromRaw: fromRaw,
                authorName: authorName,
                date: date,
                references: references,
                bytes: bytes,
                lines: lines,
                isRead: isRead,
                isStarred: isStarred,
                bodyText: bodyText,
                bodyFetchedAt: bodyFetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int serverId,
                required String groupName,
                required int number,
                required String messageId,
                Value<String> subject = const Value.absent(),
                Value<String> fromRaw = const Value.absent(),
                Value<String> authorName = const Value.absent(),
                Value<DateTime?> date = const Value.absent(),
                Value<String> references = const Value.absent(),
                Value<int> bytes = const Value.absent(),
                Value<int> lines = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isStarred = const Value.absent(),
                Value<String?> bodyText = const Value.absent(),
                Value<DateTime?> bodyFetchedAt = const Value.absent(),
              }) => ArticlesCompanion.insert(
                id: id,
                serverId: serverId,
                groupName: groupName,
                number: number,
                messageId: messageId,
                subject: subject,
                fromRaw: fromRaw,
                authorName: authorName,
                date: date,
                references: references,
                bytes: bytes,
                lines: lines,
                isRead: isRead,
                isStarred: isStarred,
                bodyText: bodyText,
                bodyFetchedAt: bodyFetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ArticlesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({serverId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (serverId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.serverId,
                                referencedTable: $$ArticlesTableReferences
                                    ._serverIdTable(db),
                                referencedColumn: $$ArticlesTableReferences
                                    ._serverIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ArticlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArticlesTable,
      Article,
      $$ArticlesTableFilterComposer,
      $$ArticlesTableOrderingComposer,
      $$ArticlesTableAnnotationComposer,
      $$ArticlesTableCreateCompanionBuilder,
      $$ArticlesTableUpdateCompanionBuilder,
      (Article, $$ArticlesTableReferences),
      Article,
      PrefetchHooks Function({bool serverId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<int> syncIntervalMinutes,
      Value<int> maxArticlesPerSync,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<int> syncIntervalMinutes,
      Value<int> maxArticlesPerSync,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
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

  ColumnFilters<int> get syncIntervalMinutes => $composableBuilder(
    column: $table.syncIntervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxArticlesPerSync => $composableBuilder(
    column: $table.maxArticlesPerSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
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

  ColumnOrderings<int> get syncIntervalMinutes => $composableBuilder(
    column: $table.syncIntervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxArticlesPerSync => $composableBuilder(
    column: $table.maxArticlesPerSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get syncIntervalMinutes => $composableBuilder(
    column: $table.syncIntervalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxArticlesPerSync => $composableBuilder(
    column: $table.maxArticlesPerSync,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> syncIntervalMinutes = const Value.absent(),
                Value<int> maxArticlesPerSync = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                syncIntervalMinutes: syncIntervalMinutes,
                maxArticlesPerSync: maxArticlesPerSync,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> syncIntervalMinutes = const Value.absent(),
                Value<int> maxArticlesPerSync = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                syncIntervalMinutes: syncIntervalMinutes,
                maxArticlesPerSync: maxArticlesPerSync,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ServersTableTableManager get servers =>
      $$ServersTableTableManager(_db, _db.servers);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db, _db.subscriptions);
  $$GroupCatalogTableTableManager get groupCatalog =>
      $$GroupCatalogTableTableManager(_db, _db.groupCatalog);
  $$ArticlesTableTableManager get articles =>
      $$ArticlesTableTableManager(_db, _db.articles);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
