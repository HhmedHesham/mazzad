// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Auction _$AuctionFromJson(Map<String, dynamic> json) {
  return _Auction.fromJson(json);
}

/// @nodoc
mixin _$Auction {
  int get id => throw _privateConstructorUsedError;
  int get category_id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String?> get images => throw _privateConstructorUsedError;
  double get initial_price => throw _privateConstructorUsedError;
  DateTime get start_date => throw _privateConstructorUsedError;
  DateTime get end_date => throw _privateConstructorUsedError;
  Status get type => throw _privateConstructorUsedError;
  List<String> get keywords => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuctionCopyWith<Auction> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuctionCopyWith<$Res> {
  factory $AuctionCopyWith(Auction value, $Res Function(Auction) then) =
      _$AuctionCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int category_id,
      String name,
      String description,
      List<String?> images,
      double initial_price,
      DateTime start_date,
      DateTime end_date,
      Status type,
      List<String> keywords});
}

/// @nodoc
class _$AuctionCopyWithImpl<$Res> implements $AuctionCopyWith<$Res> {
  _$AuctionCopyWithImpl(this._value, this._then);

  final Auction _value;
  // ignore: unused_field
  final $Res Function(Auction) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? category_id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? images = freezed,
    Object? initial_price = freezed,
    Object? start_date = freezed,
    Object? end_date = freezed,
    Object? type = freezed,
    Object? keywords = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      category_id: category_id == freezed
          ? _value.category_id
          : category_id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      initial_price: initial_price == freezed
          ? _value.initial_price
          : initial_price // ignore: cast_nullable_to_non_nullable
              as double,
      start_date: start_date == freezed
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end_date: end_date == freezed
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Status,
      keywords: keywords == freezed
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_AuctionCopyWith<$Res> implements $AuctionCopyWith<$Res> {
  factory _$$_AuctionCopyWith(
          _$_Auction value, $Res Function(_$_Auction) then) =
      __$$_AuctionCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int category_id,
      String name,
      String description,
      List<String?> images,
      double initial_price,
      DateTime start_date,
      DateTime end_date,
      Status type,
      List<String> keywords});
}

/// @nodoc
class __$$_AuctionCopyWithImpl<$Res> extends _$AuctionCopyWithImpl<$Res>
    implements _$$_AuctionCopyWith<$Res> {
  __$$_AuctionCopyWithImpl(_$_Auction _value, $Res Function(_$_Auction) _then)
      : super(_value, (v) => _then(v as _$_Auction));

  @override
  _$_Auction get _value => super._value as _$_Auction;

  @override
  $Res call({
    Object? id = freezed,
    Object? category_id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? images = freezed,
    Object? initial_price = freezed,
    Object? start_date = freezed,
    Object? end_date = freezed,
    Object? type = freezed,
    Object? keywords = freezed,
  }) {
    return _then(_$_Auction(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      category_id: category_id == freezed
          ? _value.category_id
          : category_id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: images == freezed
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      initial_price: initial_price == freezed
          ? _value.initial_price
          : initial_price // ignore: cast_nullable_to_non_nullable
              as double,
      start_date: start_date == freezed
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end_date: end_date == freezed
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as Status,
      keywords: keywords == freezed
          ? _value._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Auction extends _Auction {
  const _$_Auction(
      {this.id = -1,
      required this.category_id,
      required this.name,
      required this.description,
      required final List<String?> images,
      required this.initial_price,
      required this.start_date,
      required this.end_date,
      required this.type,
      required final List<String> keywords})
      : _images = images,
        _keywords = keywords,
        super._();

  factory _$_Auction.fromJson(Map<String, dynamic> json) =>
      _$$_AuctionFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final int category_id;
  @override
  final String name;
  @override
  final String description;
  final List<String?> _images;
  @override
  List<String?> get images {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final double initial_price;
  @override
  final DateTime start_date;
  @override
  final DateTime end_date;
  @override
  final Status type;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  String toString() {
    return 'Auction(id: $id, category_id: $category_id, name: $name, description: $description, images: $images, initial_price: $initial_price, start_date: $start_date, end_date: $end_date, type: $type, keywords: $keywords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Auction &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.category_id, category_id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality()
                .equals(other.initial_price, initial_price) &&
            const DeepCollectionEquality()
                .equals(other.start_date, start_date) &&
            const DeepCollectionEquality().equals(other.end_date, end_date) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(category_id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(initial_price),
      const DeepCollectionEquality().hash(start_date),
      const DeepCollectionEquality().hash(end_date),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(_keywords));

  @JsonKey(ignore: true)
  @override
  _$$_AuctionCopyWith<_$_Auction> get copyWith =>
      __$$_AuctionCopyWithImpl<_$_Auction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuctionToJson(this);
  }
}

abstract class _Auction extends Auction {
  const factory _Auction(
      {final int id,
      required final int category_id,
      required final String name,
      required final String description,
      required final List<String?> images,
      required final double initial_price,
      required final DateTime start_date,
      required final DateTime end_date,
      required final Status type,
      required final List<String> keywords}) = _$_Auction;
  const _Auction._() : super._();

  factory _Auction.fromJson(Map<String, dynamic> json) = _$_Auction.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  int get category_id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  List<String?> get images => throw _privateConstructorUsedError;
  @override
  double get initial_price => throw _privateConstructorUsedError;
  @override
  DateTime get start_date => throw _privateConstructorUsedError;
  @override
  DateTime get end_date => throw _privateConstructorUsedError;
  @override
  Status get type => throw _privateConstructorUsedError;
  @override
  List<String> get keywords => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AuctionCopyWith<_$_Auction> get copyWith =>
      throw _privateConstructorUsedError;
}
