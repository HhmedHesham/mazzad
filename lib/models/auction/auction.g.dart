// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Auction _$$_AuctionFromJson(Map<String, dynamic> json) => _$_Auction(
      id: json['id'] as int? ?? -1,
      category_id: json['category_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String?).toList(),
      initial_price: (json['initial_price'] as num).toDouble(),
      start_date: DateTime.parse(json['start_date'] as String),
      end_date: DateTime.parse(json['end_date'] as String),
      type: $enumDecode(_$StatusEnumMap, json['type']),
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_AuctionToJson(_$_Auction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.category_id,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'initial_price': instance.initial_price,
      'start_date': instance.start_date.toIso8601String(),
      'end_date': instance.end_date.toIso8601String(),
      'type': _$StatusEnumMap[instance.type],
      'keywords': instance.keywords,
    };

const _$StatusEnumMap = {
  Status.live: 'live',
  Status.scheduled: 'scheduled',
  Status.soon: 'soon',
};
