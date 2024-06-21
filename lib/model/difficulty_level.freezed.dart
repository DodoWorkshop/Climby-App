// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'difficulty_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DifficultyLevel _$DifficultyLevelFromJson(Map<String, dynamic> json) {
  return _DifficultyLevel.fromJson(json);
}

/// @nodoc
mixin _$DifficultyLevel {
  int get id => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DifficultyLevelCopyWith<DifficultyLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DifficultyLevelCopyWith<$Res> {
  factory $DifficultyLevelCopyWith(
          DifficultyLevel value, $Res Function(DifficultyLevel) then) =
      _$DifficultyLevelCopyWithImpl<$Res, DifficultyLevel>;
  @useResult
  $Res call({int id, int color, int score});
}

/// @nodoc
class _$DifficultyLevelCopyWithImpl<$Res, $Val extends DifficultyLevel>
    implements $DifficultyLevelCopyWith<$Res> {
  _$DifficultyLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? color = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DifficultyLevelImplCopyWith<$Res>
    implements $DifficultyLevelCopyWith<$Res> {
  factory _$$DifficultyLevelImplCopyWith(_$DifficultyLevelImpl value,
          $Res Function(_$DifficultyLevelImpl) then) =
      __$$DifficultyLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int color, int score});
}

/// @nodoc
class __$$DifficultyLevelImplCopyWithImpl<$Res>
    extends _$DifficultyLevelCopyWithImpl<$Res, _$DifficultyLevelImpl>
    implements _$$DifficultyLevelImplCopyWith<$Res> {
  __$$DifficultyLevelImplCopyWithImpl(
      _$DifficultyLevelImpl _value, $Res Function(_$DifficultyLevelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? color = null,
    Object? score = null,
  }) {
    return _then(_$DifficultyLevelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DifficultyLevelImpl implements _DifficultyLevel {
  const _$DifficultyLevelImpl(
      {required this.id, required this.color, required this.score});

  factory _$DifficultyLevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DifficultyLevelImplFromJson(json);

  @override
  final int id;
  @override
  final int color;
  @override
  final int score;

  @override
  String toString() {
    return 'DifficultyLevel(id: $id, color: $color, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DifficultyLevelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, color, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DifficultyLevelImplCopyWith<_$DifficultyLevelImpl> get copyWith =>
      __$$DifficultyLevelImplCopyWithImpl<_$DifficultyLevelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DifficultyLevelImplToJson(
      this,
    );
  }
}

abstract class _DifficultyLevel implements DifficultyLevel {
  const factory _DifficultyLevel(
      {required final int id,
      required final int color,
      required final int score}) = _$DifficultyLevelImpl;

  factory _DifficultyLevel.fromJson(Map<String, dynamic> json) =
      _$DifficultyLevelImpl.fromJson;

  @override
  int get id;
  @override
  int get color;
  @override
  int get score;
  @override
  @JsonKey(ignore: true)
  _$$DifficultyLevelImplCopyWith<_$DifficultyLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
