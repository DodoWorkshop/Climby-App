// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionEntry _$SessionEntryFromJson(Map<String, dynamic> json) {
  return _SessionEntry.fromJson(json);
}

/// @nodoc
mixin _$SessionEntry {
  int get id => throw _privateConstructorUsedError;
  DifficultyLevel get difficultyLevel => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionEntryCopyWith<SessionEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionEntryCopyWith<$Res> {
  factory $SessionEntryCopyWith(
          SessionEntry value, $Res Function(SessionEntry) then) =
      _$SessionEntryCopyWithImpl<$Res, SessionEntry>;
  @useResult
  $Res call({int id, DifficultyLevel difficultyLevel, DateTime createdAt});

  $DifficultyLevelCopyWith<$Res> get difficultyLevel;
}

/// @nodoc
class _$SessionEntryCopyWithImpl<$Res, $Val extends SessionEntry>
    implements $SessionEntryCopyWith<$Res> {
  _$SessionEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? difficultyLevel = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DifficultyLevelCopyWith<$Res> get difficultyLevel {
    return $DifficultyLevelCopyWith<$Res>(_value.difficultyLevel, (value) {
      return _then(_value.copyWith(difficultyLevel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionEntryImplCopyWith<$Res>
    implements $SessionEntryCopyWith<$Res> {
  factory _$$SessionEntryImplCopyWith(
          _$SessionEntryImpl value, $Res Function(_$SessionEntryImpl) then) =
      __$$SessionEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, DifficultyLevel difficultyLevel, DateTime createdAt});

  @override
  $DifficultyLevelCopyWith<$Res> get difficultyLevel;
}

/// @nodoc
class __$$SessionEntryImplCopyWithImpl<$Res>
    extends _$SessionEntryCopyWithImpl<$Res, _$SessionEntryImpl>
    implements _$$SessionEntryImplCopyWith<$Res> {
  __$$SessionEntryImplCopyWithImpl(
      _$SessionEntryImpl _value, $Res Function(_$SessionEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? difficultyLevel = null,
    Object? createdAt = null,
  }) {
    return _then(_$SessionEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionEntryImpl implements _SessionEntry {
  const _$SessionEntryImpl(
      {required this.id,
      required this.difficultyLevel,
      required this.createdAt});

  factory _$SessionEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionEntryImplFromJson(json);

  @override
  final int id;
  @override
  final DifficultyLevel difficultyLevel;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'SessionEntry(id: $id, difficultyLevel: $difficultyLevel, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, difficultyLevel, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionEntryImplCopyWith<_$SessionEntryImpl> get copyWith =>
      __$$SessionEntryImplCopyWithImpl<_$SessionEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionEntryImplToJson(
      this,
    );
  }
}

abstract class _SessionEntry implements SessionEntry {
  const factory _SessionEntry(
      {required final int id,
      required final DifficultyLevel difficultyLevel,
      required final DateTime createdAt}) = _$SessionEntryImpl;

  factory _SessionEntry.fromJson(Map<String, dynamic> json) =
      _$SessionEntryImpl.fromJson;

  @override
  int get id;
  @override
  DifficultyLevel get difficultyLevel;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$SessionEntryImplCopyWith<_$SessionEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
