class BidderModel {
  int? id;
  String? bidType;
  int? auctionId;
  int? price;
  int? userId;
  String? createdAt;
  User? user;

  BidderModel(
      {this.id,
      this.bidType,
      this.auctionId,
      this.price,
      this.userId,
      this.createdAt,
      this.user});

  BidderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bidType = json['bid_type'];
    auctionId = json['auction_id'];
    price = json['price'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}