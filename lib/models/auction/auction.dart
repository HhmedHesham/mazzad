import 'package:freezed_annotation/freezed_annotation.dart';

import '../../components/auction_status.dart';

part 'auction.freezed.dart';
part 'auction.g.dart';

@freezed
class Auction with _$Auction {
  const Auction._();

  const factory Auction({
    @Default(-1) int id,
    required int category_id,
    required String name,
    required String description,
    required List<String?> images,
    required double initial_price,
    required DateTime start_date,
    required DateTime end_date,
    required Status type,
    required List<String> keywords,
  }) = _Auction;

  factory Auction.fromJson(Map<String, dynamic> json) =>
      _$AuctionFromJson(json);
}
