// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfileTable extends UserProfile
    with TableInfo<$UserProfileTable, UserProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _playStyleMeta = const VerificationMeta(
    'playStyle',
  );
  @override
  late final GeneratedColumn<String> playStyle = GeneratedColumn<String>(
    'play_style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _currentSimulationDateMeta =
      const VerificationMeta('currentSimulationDate');
  @override
  late final GeneratedColumn<DateTime> currentSimulationDate =
      GeneratedColumn<DateTime>(
        'current_simulation_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    playStyle,
    createdAt,
    balance,
    currentSimulationDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileData> instance, {
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
    if (data.containsKey('play_style')) {
      context.handle(
        _playStyleMeta,
        playStyle.isAcceptableOrUnknown(data['play_style']!, _playStyleMeta),
      );
    } else if (isInserting) {
      context.missing(_playStyleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('current_simulation_date')) {
      context.handle(
        _currentSimulationDateMeta,
        currentSimulationDate.isAcceptableOrUnknown(
          data['current_simulation_date']!,
          _currentSimulationDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      playStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}play_style'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      currentSimulationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}current_simulation_date'],
      ),
    );
  }

  @override
  $UserProfileTable createAlias(String alias) {
    return $UserProfileTable(attachedDatabase, alias);
  }
}

class UserProfileData extends DataClass implements Insertable<UserProfileData> {
  final int id;
  final String name;
  final String playStyle;
  final DateTime createdAt;
  final double balance;
  final DateTime? currentSimulationDate;
  const UserProfileData({
    required this.id,
    required this.name,
    required this.playStyle,
    required this.createdAt,
    required this.balance,
    this.currentSimulationDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['play_style'] = Variable<String>(playStyle);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['balance'] = Variable<double>(balance);
    if (!nullToAbsent || currentSimulationDate != null) {
      map['current_simulation_date'] = Variable<DateTime>(
        currentSimulationDate,
      );
    }
    return map;
  }

  UserProfileCompanion toCompanion(bool nullToAbsent) {
    return UserProfileCompanion(
      id: Value(id),
      name: Value(name),
      playStyle: Value(playStyle),
      createdAt: Value(createdAt),
      balance: Value(balance),
      currentSimulationDate: currentSimulationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(currentSimulationDate),
    );
  }

  factory UserProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      playStyle: serializer.fromJson<String>(json['playStyle']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      balance: serializer.fromJson<double>(json['balance']),
      currentSimulationDate: serializer.fromJson<DateTime?>(
        json['currentSimulationDate'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'playStyle': serializer.toJson<String>(playStyle),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'balance': serializer.toJson<double>(balance),
      'currentSimulationDate': serializer.toJson<DateTime?>(
        currentSimulationDate,
      ),
    };
  }

  UserProfileData copyWith({
    int? id,
    String? name,
    String? playStyle,
    DateTime? createdAt,
    double? balance,
    Value<DateTime?> currentSimulationDate = const Value.absent(),
  }) => UserProfileData(
    id: id ?? this.id,
    name: name ?? this.name,
    playStyle: playStyle ?? this.playStyle,
    createdAt: createdAt ?? this.createdAt,
    balance: balance ?? this.balance,
    currentSimulationDate: currentSimulationDate.present
        ? currentSimulationDate.value
        : this.currentSimulationDate,
  );
  UserProfileData copyWithCompanion(UserProfileCompanion data) {
    return UserProfileData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      playStyle: data.playStyle.present ? data.playStyle.value : this.playStyle,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      balance: data.balance.present ? data.balance.value : this.balance,
      currentSimulationDate: data.currentSimulationDate.present
          ? data.currentSimulationDate.value
          : this.currentSimulationDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('playStyle: $playStyle, ')
          ..write('createdAt: $createdAt, ')
          ..write('balance: $balance, ')
          ..write('currentSimulationDate: $currentSimulationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    playStyle,
    createdAt,
    balance,
    currentSimulationDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileData &&
          other.id == this.id &&
          other.name == this.name &&
          other.playStyle == this.playStyle &&
          other.createdAt == this.createdAt &&
          other.balance == this.balance &&
          other.currentSimulationDate == this.currentSimulationDate);
}

class UserProfileCompanion extends UpdateCompanion<UserProfileData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> playStyle;
  final Value<DateTime> createdAt;
  final Value<double> balance;
  final Value<DateTime?> currentSimulationDate;
  const UserProfileCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.playStyle = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.balance = const Value.absent(),
    this.currentSimulationDate = const Value.absent(),
  });
  UserProfileCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String playStyle,
    this.createdAt = const Value.absent(),
    this.balance = const Value.absent(),
    this.currentSimulationDate = const Value.absent(),
  }) : name = Value(name),
       playStyle = Value(playStyle);
  static Insertable<UserProfileData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? playStyle,
    Expression<DateTime>? createdAt,
    Expression<double>? balance,
    Expression<DateTime>? currentSimulationDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (playStyle != null) 'play_style': playStyle,
      if (createdAt != null) 'created_at': createdAt,
      if (balance != null) 'balance': balance,
      if (currentSimulationDate != null)
        'current_simulation_date': currentSimulationDate,
    });
  }

  UserProfileCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? playStyle,
    Value<DateTime>? createdAt,
    Value<double>? balance,
    Value<DateTime?>? currentSimulationDate,
  }) {
    return UserProfileCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      playStyle: playStyle ?? this.playStyle,
      createdAt: createdAt ?? this.createdAt,
      balance: balance ?? this.balance,
      currentSimulationDate:
          currentSimulationDate ?? this.currentSimulationDate,
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
    if (playStyle.present) {
      map['play_style'] = Variable<String>(playStyle.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (currentSimulationDate.present) {
      map['current_simulation_date'] = Variable<DateTime>(
        currentSimulationDate.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('playStyle: $playStyle, ')
          ..write('createdAt: $createdAt, ')
          ..write('balance: $balance, ')
          ..write('currentSimulationDate: $currentSimulationDate')
          ..write(')'))
        .toString();
  }
}

class $StocksTable extends Stocks with TableInfo<$StocksTable, Stock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tickerMeta = const VerificationMeta('ticker');
  @override
  late final GeneratedColumn<String> ticker = GeneratedColumn<String>(
    'ticker',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentPriceMeta = const VerificationMeta(
    'currentPrice',
  );
  @override
  late final GeneratedColumn<double> currentPrice = GeneratedColumn<double>(
    'current_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousPriceMeta = const VerificationMeta(
    'previousPrice',
  );
  @override
  late final GeneratedColumn<double> previousPrice = GeneratedColumn<double>(
    'previous_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<int> volume = GeneratedColumn<int>(
    'volume',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    ticker,
    name,
    description,
    currentPrice,
    previousPrice,
    volume,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Stock> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ticker')) {
      context.handle(
        _tickerMeta,
        ticker.isAcceptableOrUnknown(data['ticker']!, _tickerMeta),
      );
    } else if (isInserting) {
      context.missing(_tickerMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('current_price')) {
      context.handle(
        _currentPriceMeta,
        currentPrice.isAcceptableOrUnknown(
          data['current_price']!,
          _currentPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentPriceMeta);
    }
    if (data.containsKey('previous_price')) {
      context.handle(
        _previousPriceMeta,
        previousPrice.isAcceptableOrUnknown(
          data['previous_price']!,
          _previousPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousPriceMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(
        _volumeMeta,
        volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ticker};
  @override
  Stock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Stock(
      ticker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ticker'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      currentPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_price'],
      )!,
      previousPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}previous_price'],
      )!,
      volume: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume'],
      )!,
    );
  }

  @override
  $StocksTable createAlias(String alias) {
    return $StocksTable(attachedDatabase, alias);
  }
}

class Stock extends DataClass implements Insertable<Stock> {
  final String ticker;
  final String name;
  final String? description;
  final double currentPrice;
  final double previousPrice;
  final int volume;
  const Stock({
    required this.ticker,
    required this.name,
    this.description,
    required this.currentPrice,
    required this.previousPrice,
    required this.volume,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ticker'] = Variable<String>(ticker);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['current_price'] = Variable<double>(currentPrice);
    map['previous_price'] = Variable<double>(previousPrice);
    map['volume'] = Variable<int>(volume);
    return map;
  }

  StocksCompanion toCompanion(bool nullToAbsent) {
    return StocksCompanion(
      ticker: Value(ticker),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      currentPrice: Value(currentPrice),
      previousPrice: Value(previousPrice),
      volume: Value(volume),
    );
  }

  factory Stock.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Stock(
      ticker: serializer.fromJson<String>(json['ticker']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      currentPrice: serializer.fromJson<double>(json['currentPrice']),
      previousPrice: serializer.fromJson<double>(json['previousPrice']),
      volume: serializer.fromJson<int>(json['volume']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ticker': serializer.toJson<String>(ticker),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'currentPrice': serializer.toJson<double>(currentPrice),
      'previousPrice': serializer.toJson<double>(previousPrice),
      'volume': serializer.toJson<int>(volume),
    };
  }

  Stock copyWith({
    String? ticker,
    String? name,
    Value<String?> description = const Value.absent(),
    double? currentPrice,
    double? previousPrice,
    int? volume,
  }) => Stock(
    ticker: ticker ?? this.ticker,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    currentPrice: currentPrice ?? this.currentPrice,
    previousPrice: previousPrice ?? this.previousPrice,
    volume: volume ?? this.volume,
  );
  Stock copyWithCompanion(StocksCompanion data) {
    return Stock(
      ticker: data.ticker.present ? data.ticker.value : this.ticker,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      currentPrice: data.currentPrice.present
          ? data.currentPrice.value
          : this.currentPrice,
      previousPrice: data.previousPrice.present
          ? data.previousPrice.value
          : this.previousPrice,
      volume: data.volume.present ? data.volume.value : this.volume,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Stock(')
          ..write('ticker: $ticker, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('previousPrice: $previousPrice, ')
          ..write('volume: $volume')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    ticker,
    name,
    description,
    currentPrice,
    previousPrice,
    volume,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Stock &&
          other.ticker == this.ticker &&
          other.name == this.name &&
          other.description == this.description &&
          other.currentPrice == this.currentPrice &&
          other.previousPrice == this.previousPrice &&
          other.volume == this.volume);
}

class StocksCompanion extends UpdateCompanion<Stock> {
  final Value<String> ticker;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> currentPrice;
  final Value<double> previousPrice;
  final Value<int> volume;
  final Value<int> rowid;
  const StocksCompanion({
    this.ticker = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.currentPrice = const Value.absent(),
    this.previousPrice = const Value.absent(),
    this.volume = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StocksCompanion.insert({
    required String ticker,
    required String name,
    this.description = const Value.absent(),
    required double currentPrice,
    required double previousPrice,
    required int volume,
    this.rowid = const Value.absent(),
  }) : ticker = Value(ticker),
       name = Value(name),
       currentPrice = Value(currentPrice),
       previousPrice = Value(previousPrice),
       volume = Value(volume);
  static Insertable<Stock> custom({
    Expression<String>? ticker,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? currentPrice,
    Expression<double>? previousPrice,
    Expression<int>? volume,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ticker != null) 'ticker': ticker,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (currentPrice != null) 'current_price': currentPrice,
      if (previousPrice != null) 'previous_price': previousPrice,
      if (volume != null) 'volume': volume,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StocksCompanion copyWith({
    Value<String>? ticker,
    Value<String>? name,
    Value<String?>? description,
    Value<double>? currentPrice,
    Value<double>? previousPrice,
    Value<int>? volume,
    Value<int>? rowid,
  }) {
    return StocksCompanion(
      ticker: ticker ?? this.ticker,
      name: name ?? this.name,
      description: description ?? this.description,
      currentPrice: currentPrice ?? this.currentPrice,
      previousPrice: previousPrice ?? this.previousPrice,
      volume: volume ?? this.volume,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ticker.present) {
      map['ticker'] = Variable<String>(ticker.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (currentPrice.present) {
      map['current_price'] = Variable<double>(currentPrice.value);
    }
    if (previousPrice.present) {
      map['previous_price'] = Variable<double>(previousPrice.value);
    }
    if (volume.present) {
      map['volume'] = Variable<int>(volume.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StocksCompanion(')
          ..write('ticker: $ticker, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('currentPrice: $currentPrice, ')
          ..write('previousPrice: $previousPrice, ')
          ..write('volume: $volume, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PortfoliosTable extends Portfolios
    with TableInfo<$PortfoliosTable, Portfolio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PortfoliosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tickerMeta = const VerificationMeta('ticker');
  @override
  late final GeneratedColumn<String> ticker = GeneratedColumn<String>(
    'ticker',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLotsMeta = const VerificationMeta(
    'totalLots',
  );
  @override
  late final GeneratedColumn<int> totalLots = GeneratedColumn<int>(
    'total_lots',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _averageBuyPriceMeta = const VerificationMeta(
    'averageBuyPrice',
  );
  @override
  late final GeneratedColumn<double> averageBuyPrice = GeneratedColumn<double>(
    'average_buy_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ticker,
    totalLots,
    averageBuyPrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'portfolios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Portfolio> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ticker')) {
      context.handle(
        _tickerMeta,
        ticker.isAcceptableOrUnknown(data['ticker']!, _tickerMeta),
      );
    } else if (isInserting) {
      context.missing(_tickerMeta);
    }
    if (data.containsKey('total_lots')) {
      context.handle(
        _totalLotsMeta,
        totalLots.isAcceptableOrUnknown(data['total_lots']!, _totalLotsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalLotsMeta);
    }
    if (data.containsKey('average_buy_price')) {
      context.handle(
        _averageBuyPriceMeta,
        averageBuyPrice.isAcceptableOrUnknown(
          data['average_buy_price']!,
          _averageBuyPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_averageBuyPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Portfolio map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Portfolio(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ticker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ticker'],
      )!,
      totalLots: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_lots'],
      )!,
      averageBuyPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}average_buy_price'],
      )!,
    );
  }

  @override
  $PortfoliosTable createAlias(String alias) {
    return $PortfoliosTable(attachedDatabase, alias);
  }
}

class Portfolio extends DataClass implements Insertable<Portfolio> {
  final int id;
  final String ticker;
  final int totalLots;
  final double averageBuyPrice;
  const Portfolio({
    required this.id,
    required this.ticker,
    required this.totalLots,
    required this.averageBuyPrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ticker'] = Variable<String>(ticker);
    map['total_lots'] = Variable<int>(totalLots);
    map['average_buy_price'] = Variable<double>(averageBuyPrice);
    return map;
  }

  PortfoliosCompanion toCompanion(bool nullToAbsent) {
    return PortfoliosCompanion(
      id: Value(id),
      ticker: Value(ticker),
      totalLots: Value(totalLots),
      averageBuyPrice: Value(averageBuyPrice),
    );
  }

  factory Portfolio.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Portfolio(
      id: serializer.fromJson<int>(json['id']),
      ticker: serializer.fromJson<String>(json['ticker']),
      totalLots: serializer.fromJson<int>(json['totalLots']),
      averageBuyPrice: serializer.fromJson<double>(json['averageBuyPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ticker': serializer.toJson<String>(ticker),
      'totalLots': serializer.toJson<int>(totalLots),
      'averageBuyPrice': serializer.toJson<double>(averageBuyPrice),
    };
  }

  Portfolio copyWith({
    int? id,
    String? ticker,
    int? totalLots,
    double? averageBuyPrice,
  }) => Portfolio(
    id: id ?? this.id,
    ticker: ticker ?? this.ticker,
    totalLots: totalLots ?? this.totalLots,
    averageBuyPrice: averageBuyPrice ?? this.averageBuyPrice,
  );
  Portfolio copyWithCompanion(PortfoliosCompanion data) {
    return Portfolio(
      id: data.id.present ? data.id.value : this.id,
      ticker: data.ticker.present ? data.ticker.value : this.ticker,
      totalLots: data.totalLots.present ? data.totalLots.value : this.totalLots,
      averageBuyPrice: data.averageBuyPrice.present
          ? data.averageBuyPrice.value
          : this.averageBuyPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Portfolio(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('totalLots: $totalLots, ')
          ..write('averageBuyPrice: $averageBuyPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ticker, totalLots, averageBuyPrice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Portfolio &&
          other.id == this.id &&
          other.ticker == this.ticker &&
          other.totalLots == this.totalLots &&
          other.averageBuyPrice == this.averageBuyPrice);
}

class PortfoliosCompanion extends UpdateCompanion<Portfolio> {
  final Value<int> id;
  final Value<String> ticker;
  final Value<int> totalLots;
  final Value<double> averageBuyPrice;
  const PortfoliosCompanion({
    this.id = const Value.absent(),
    this.ticker = const Value.absent(),
    this.totalLots = const Value.absent(),
    this.averageBuyPrice = const Value.absent(),
  });
  PortfoliosCompanion.insert({
    this.id = const Value.absent(),
    required String ticker,
    required int totalLots,
    required double averageBuyPrice,
  }) : ticker = Value(ticker),
       totalLots = Value(totalLots),
       averageBuyPrice = Value(averageBuyPrice);
  static Insertable<Portfolio> custom({
    Expression<int>? id,
    Expression<String>? ticker,
    Expression<int>? totalLots,
    Expression<double>? averageBuyPrice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ticker != null) 'ticker': ticker,
      if (totalLots != null) 'total_lots': totalLots,
      if (averageBuyPrice != null) 'average_buy_price': averageBuyPrice,
    });
  }

  PortfoliosCompanion copyWith({
    Value<int>? id,
    Value<String>? ticker,
    Value<int>? totalLots,
    Value<double>? averageBuyPrice,
  }) {
    return PortfoliosCompanion(
      id: id ?? this.id,
      ticker: ticker ?? this.ticker,
      totalLots: totalLots ?? this.totalLots,
      averageBuyPrice: averageBuyPrice ?? this.averageBuyPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ticker.present) {
      map['ticker'] = Variable<String>(ticker.value);
    }
    if (totalLots.present) {
      map['total_lots'] = Variable<int>(totalLots.value);
    }
    if (averageBuyPrice.present) {
      map['average_buy_price'] = Variable<double>(averageBuyPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PortfoliosCompanion(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('totalLots: $totalLots, ')
          ..write('averageBuyPrice: $averageBuyPrice')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tickerMeta = const VerificationMeta('ticker');
  @override
  late final GeneratedColumn<String> ticker = GeneratedColumn<String>(
    'ticker',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lotsMeta = const VerificationMeta('lots');
  @override
  late final GeneratedColumn<int> lots = GeneratedColumn<int>(
    'lots',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pricePerLotMeta = const VerificationMeta(
    'pricePerLot',
  );
  @override
  late final GeneratedColumn<double> pricePerLot = GeneratedColumn<double>(
    'price_per_lot',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ticker,
    type,
    lots,
    pricePerLot,
    totalAmount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ticker')) {
      context.handle(
        _tickerMeta,
        ticker.isAcceptableOrUnknown(data['ticker']!, _tickerMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('lots')) {
      context.handle(
        _lotsMeta,
        lots.isAcceptableOrUnknown(data['lots']!, _lotsMeta),
      );
    }
    if (data.containsKey('price_per_lot')) {
      context.handle(
        _pricePerLotMeta,
        pricePerLot.isAcceptableOrUnknown(
          data['price_per_lot']!,
          _pricePerLotMeta,
        ),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ticker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ticker'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      lots: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lots'],
      ),
      pricePerLot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_lot'],
      ),
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final String? ticker;
  final String type;
  final int? lots;
  final double? pricePerLot;
  final double totalAmount;
  final DateTime createdAt;
  const Transaction({
    required this.id,
    this.ticker,
    required this.type,
    this.lots,
    this.pricePerLot,
    required this.totalAmount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || ticker != null) {
      map['ticker'] = Variable<String>(ticker);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || lots != null) {
      map['lots'] = Variable<int>(lots);
    }
    if (!nullToAbsent || pricePerLot != null) {
      map['price_per_lot'] = Variable<double>(pricePerLot);
    }
    map['total_amount'] = Variable<double>(totalAmount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      ticker: ticker == null && nullToAbsent
          ? const Value.absent()
          : Value(ticker),
      type: Value(type),
      lots: lots == null && nullToAbsent ? const Value.absent() : Value(lots),
      pricePerLot: pricePerLot == null && nullToAbsent
          ? const Value.absent()
          : Value(pricePerLot),
      totalAmount: Value(totalAmount),
      createdAt: Value(createdAt),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      ticker: serializer.fromJson<String?>(json['ticker']),
      type: serializer.fromJson<String>(json['type']),
      lots: serializer.fromJson<int?>(json['lots']),
      pricePerLot: serializer.fromJson<double?>(json['pricePerLot']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ticker': serializer.toJson<String?>(ticker),
      'type': serializer.toJson<String>(type),
      'lots': serializer.toJson<int?>(lots),
      'pricePerLot': serializer.toJson<double?>(pricePerLot),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Transaction copyWith({
    int? id,
    Value<String?> ticker = const Value.absent(),
    String? type,
    Value<int?> lots = const Value.absent(),
    Value<double?> pricePerLot = const Value.absent(),
    double? totalAmount,
    DateTime? createdAt,
  }) => Transaction(
    id: id ?? this.id,
    ticker: ticker.present ? ticker.value : this.ticker,
    type: type ?? this.type,
    lots: lots.present ? lots.value : this.lots,
    pricePerLot: pricePerLot.present ? pricePerLot.value : this.pricePerLot,
    totalAmount: totalAmount ?? this.totalAmount,
    createdAt: createdAt ?? this.createdAt,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      ticker: data.ticker.present ? data.ticker.value : this.ticker,
      type: data.type.present ? data.type.value : this.type,
      lots: data.lots.present ? data.lots.value : this.lots,
      pricePerLot: data.pricePerLot.present
          ? data.pricePerLot.value
          : this.pricePerLot,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('type: $type, ')
          ..write('lots: $lots, ')
          ..write('pricePerLot: $pricePerLot, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ticker, type, lots, pricePerLot, totalAmount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.ticker == this.ticker &&
          other.type == this.type &&
          other.lots == this.lots &&
          other.pricePerLot == this.pricePerLot &&
          other.totalAmount == this.totalAmount &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<String?> ticker;
  final Value<String> type;
  final Value<int?> lots;
  final Value<double?> pricePerLot;
  final Value<double> totalAmount;
  final Value<DateTime> createdAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.ticker = const Value.absent(),
    this.type = const Value.absent(),
    this.lots = const Value.absent(),
    this.pricePerLot = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.ticker = const Value.absent(),
    required String type,
    this.lots = const Value.absent(),
    this.pricePerLot = const Value.absent(),
    required double totalAmount,
    this.createdAt = const Value.absent(),
  }) : type = Value(type),
       totalAmount = Value(totalAmount);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<String>? ticker,
    Expression<String>? type,
    Expression<int>? lots,
    Expression<double>? pricePerLot,
    Expression<double>? totalAmount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ticker != null) 'ticker': ticker,
      if (type != null) 'type': type,
      if (lots != null) 'lots': lots,
      if (pricePerLot != null) 'price_per_lot': pricePerLot,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<String?>? ticker,
    Value<String>? type,
    Value<int?>? lots,
    Value<double?>? pricePerLot,
    Value<double>? totalAmount,
    Value<DateTime>? createdAt,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      ticker: ticker ?? this.ticker,
      type: type ?? this.type,
      lots: lots ?? this.lots,
      pricePerLot: pricePerLot ?? this.pricePerLot,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ticker.present) {
      map['ticker'] = Variable<String>(ticker.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (lots.present) {
      map['lots'] = Variable<int>(lots.value);
    }
    if (pricePerLot.present) {
      map['price_per_lot'] = Variable<double>(pricePerLot.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('ticker: $ticker, ')
          ..write('type: $type, ')
          ..write('lots: $lots, ')
          ..write('pricePerLot: $pricePerLot, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfileTable userProfile = $UserProfileTable(this);
  late final $StocksTable stocks = $StocksTable(this);
  late final $PortfoliosTable portfolios = $PortfoliosTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final UserProfileDao userProfileDao = UserProfileDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfile,
    stocks,
    portfolios,
    transactions,
  ];
}

typedef $$UserProfileTableCreateCompanionBuilder =
    UserProfileCompanion Function({
      Value<int> id,
      required String name,
      required String playStyle,
      Value<DateTime> createdAt,
      Value<double> balance,
      Value<DateTime?> currentSimulationDate,
    });
typedef $$UserProfileTableUpdateCompanionBuilder =
    UserProfileCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> playStyle,
      Value<DateTime> createdAt,
      Value<double> balance,
      Value<DateTime?> currentSimulationDate,
    });

class $$UserProfileTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableFilterComposer({
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

  ColumnFilters<String> get playStyle => $composableBuilder(
    column: $table.playStyle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get currentSimulationDate => $composableBuilder(
    column: $table.currentSimulationDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfileTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableOrderingComposer({
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

  ColumnOrderings<String> get playStyle => $composableBuilder(
    column: $table.playStyle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get currentSimulationDate => $composableBuilder(
    column: $table.currentSimulationDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfileTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableAnnotationComposer({
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

  GeneratedColumn<String> get playStyle =>
      $composableBuilder(column: $table.playStyle, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<DateTime> get currentSimulationDate => $composableBuilder(
    column: $table.currentSimulationDate,
    builder: (column) => column,
  );
}

class $$UserProfileTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfileTable,
          UserProfileData,
          $$UserProfileTableFilterComposer,
          $$UserProfileTableOrderingComposer,
          $$UserProfileTableAnnotationComposer,
          $$UserProfileTableCreateCompanionBuilder,
          $$UserProfileTableUpdateCompanionBuilder,
          (
            UserProfileData,
            BaseReferences<_$AppDatabase, $UserProfileTable, UserProfileData>,
          ),
          UserProfileData,
          PrefetchHooks Function()
        > {
  $$UserProfileTableTableManager(_$AppDatabase db, $UserProfileTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> playStyle = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<DateTime?> currentSimulationDate = const Value.absent(),
              }) => UserProfileCompanion(
                id: id,
                name: name,
                playStyle: playStyle,
                createdAt: createdAt,
                balance: balance,
                currentSimulationDate: currentSimulationDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String playStyle,
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<DateTime?> currentSimulationDate = const Value.absent(),
              }) => UserProfileCompanion.insert(
                id: id,
                name: name,
                playStyle: playStyle,
                createdAt: createdAt,
                balance: balance,
                currentSimulationDate: currentSimulationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfileTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfileTable,
      UserProfileData,
      $$UserProfileTableFilterComposer,
      $$UserProfileTableOrderingComposer,
      $$UserProfileTableAnnotationComposer,
      $$UserProfileTableCreateCompanionBuilder,
      $$UserProfileTableUpdateCompanionBuilder,
      (
        UserProfileData,
        BaseReferences<_$AppDatabase, $UserProfileTable, UserProfileData>,
      ),
      UserProfileData,
      PrefetchHooks Function()
    >;
typedef $$StocksTableCreateCompanionBuilder = StocksCompanion Function({
  required String ticker,
  required String name,
  Value<String?> description,
  required double currentPrice,
  required double previousPrice,
  required int volume,
  Value<int> rowid,
});
typedef $$StocksTableUpdateCompanionBuilder = StocksCompanion Function({
  Value<String> ticker,
  Value<String> name,
  Value<String?> description,
  Value<double> currentPrice,
  Value<double> previousPrice,
  Value<int> volume,
  Value<int> rowid,
});

class $$StocksTableFilterComposer
    extends Composer<_$AppDatabase, $StocksTable> {
  $$StocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get previousPrice => $composableBuilder(
    column: $table.previousPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StocksTableOrderingComposer
    extends Composer<_$AppDatabase, $StocksTable> {
  $$StocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get previousPrice => $composableBuilder(
    column: $table.previousPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $StocksTable> {
  $$StocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ticker =>
      $composableBuilder(column: $table.ticker, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentPrice => $composableBuilder(
    column: $table.currentPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get previousPrice => $composableBuilder(
    column: $table.previousPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get volume =>
      $composableBuilder(column: $table.volume, builder: (column) => column);
}

class $$StocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StocksTable,
          Stock,
          $$StocksTableFilterComposer,
          $$StocksTableOrderingComposer,
          $$StocksTableAnnotationComposer,
          $$StocksTableCreateCompanionBuilder,
          $$StocksTableUpdateCompanionBuilder,
          (Stock, BaseReferences<_$AppDatabase, $StocksTable, Stock>),
          Stock,
          PrefetchHooks Function()
        > {
  $$StocksTableTableManager(_$AppDatabase db, $StocksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> ticker = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> currentPrice = const Value.absent(),
                Value<double> previousPrice = const Value.absent(),
                Value<int> volume = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StocksCompanion(
                ticker: ticker,
                name: name,
                description: description,
                currentPrice: currentPrice,
                previousPrice: previousPrice,
                volume: volume,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ticker,
                required String name,
                Value<String?> description = const Value.absent(),
                required double currentPrice,
                required double previousPrice,
                required int volume,
                Value<int> rowid = const Value.absent(),
              }) => StocksCompanion.insert(
                ticker: ticker,
                name: name,
                description: description,
                currentPrice: currentPrice,
                previousPrice: previousPrice,
                volume: volume,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StocksTable,
      Stock,
      $$StocksTableFilterComposer,
      $$StocksTableOrderingComposer,
      $$StocksTableAnnotationComposer,
      $$StocksTableCreateCompanionBuilder,
      $$StocksTableUpdateCompanionBuilder,
      (Stock, BaseReferences<_$AppDatabase, $StocksTable, Stock>),
      Stock,
      PrefetchHooks Function()
    >;
typedef $$PortfoliosTableCreateCompanionBuilder = PortfoliosCompanion Function({
  Value<int> id,
  required String ticker,
  required int totalLots,
  required double averageBuyPrice,
});
typedef $$PortfoliosTableUpdateCompanionBuilder = PortfoliosCompanion Function({
  Value<int> id,
  Value<String> ticker,
  Value<int> totalLots,
  Value<double> averageBuyPrice,
});

class $$PortfoliosTableFilterComposer
    extends Composer<_$AppDatabase, $PortfoliosTable> {
  $$PortfoliosTableFilterComposer({
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

  ColumnFilters<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalLots => $composableBuilder(
    column: $table.totalLots,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get averageBuyPrice => $composableBuilder(
    column: $table.averageBuyPrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PortfoliosTableOrderingComposer
    extends Composer<_$AppDatabase, $PortfoliosTable> {
  $$PortfoliosTableOrderingComposer({
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

  ColumnOrderings<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalLots => $composableBuilder(
    column: $table.totalLots,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get averageBuyPrice => $composableBuilder(
    column: $table.averageBuyPrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PortfoliosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PortfoliosTable> {
  $$PortfoliosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ticker =>
      $composableBuilder(column: $table.ticker, builder: (column) => column);

  GeneratedColumn<int> get totalLots =>
      $composableBuilder(column: $table.totalLots, builder: (column) => column);

  GeneratedColumn<double> get averageBuyPrice => $composableBuilder(
    column: $table.averageBuyPrice,
    builder: (column) => column,
  );
}

class $$PortfoliosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PortfoliosTable,
          Portfolio,
          $$PortfoliosTableFilterComposer,
          $$PortfoliosTableOrderingComposer,
          $$PortfoliosTableAnnotationComposer,
          $$PortfoliosTableCreateCompanionBuilder,
          $$PortfoliosTableUpdateCompanionBuilder,
          (
            Portfolio,
            BaseReferences<_$AppDatabase, $PortfoliosTable, Portfolio>,
          ),
          Portfolio,
          PrefetchHooks Function()
        > {
  $$PortfoliosTableTableManager(_$AppDatabase db, $PortfoliosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PortfoliosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PortfoliosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PortfoliosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ticker = const Value.absent(),
                Value<int> totalLots = const Value.absent(),
                Value<double> averageBuyPrice = const Value.absent(),
              }) => PortfoliosCompanion(
                id: id,
                ticker: ticker,
                totalLots: totalLots,
                averageBuyPrice: averageBuyPrice,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ticker,
                required int totalLots,
                required double averageBuyPrice,
              }) => PortfoliosCompanion.insert(
                id: id,
                ticker: ticker,
                totalLots: totalLots,
                averageBuyPrice: averageBuyPrice,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PortfoliosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PortfoliosTable,
      Portfolio,
      $$PortfoliosTableFilterComposer,
      $$PortfoliosTableOrderingComposer,
      $$PortfoliosTableAnnotationComposer,
      $$PortfoliosTableCreateCompanionBuilder,
      $$PortfoliosTableUpdateCompanionBuilder,
      (Portfolio, BaseReferences<_$AppDatabase, $PortfoliosTable, Portfolio>),
      Portfolio,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<String?> ticker,
      required String type,
      Value<int?> lots,
      Value<double?> pricePerLot,
      required double totalAmount,
      Value<DateTime> createdAt,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<String?> ticker,
      Value<String> type,
      Value<int?> lots,
      Value<double?> pricePerLot,
      Value<double> totalAmount,
      Value<DateTime> createdAt,
    });

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
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

  ColumnFilters<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lots => $composableBuilder(
    column: $table.lots,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerLot => $composableBuilder(
    column: $table.pricePerLot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lots => $composableBuilder(
    column: $table.lots,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerLot => $composableBuilder(
    column: $table.pricePerLot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ticker =>
      $composableBuilder(column: $table.ticker, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get lots =>
      $composableBuilder(column: $table.lots, builder: (column) => column);

  GeneratedColumn<double> get pricePerLot => $composableBuilder(
    column: $table.pricePerLot,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (
            Transaction,
            BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
          ),
          Transaction,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> ticker = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int?> lots = const Value.absent(),
                Value<double?> pricePerLot = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                ticker: ticker,
                type: type,
                lots: lots,
                pricePerLot: pricePerLot,
                totalAmount: totalAmount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> ticker = const Value.absent(),
                required String type,
                Value<int?> lots = const Value.absent(),
                Value<double?> pricePerLot = const Value.absent(),
                required double totalAmount,
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                ticker: ticker,
                type: type,
                lots: lots,
                pricePerLot: pricePerLot,
                totalAmount: totalAmount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (
        Transaction,
        BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
      ),
      Transaction,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfileTableTableManager get userProfile =>
      $$UserProfileTableTableManager(_db, _db.userProfile);
  $$StocksTableTableManager get stocks =>
      $$StocksTableTableManager(_db, _db.stocks);
  $$PortfoliosTableTableManager get portfolios =>
      $$PortfoliosTableTableManager(_db, _db.portfolios);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
