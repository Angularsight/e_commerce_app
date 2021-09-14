class ProductModel {
  String? totalProducts;
  String? category;
  List<Result>? result;

  ProductModel({this.totalProducts, this.category, this.result});

  ProductModel.fromJson(Map<String, dynamic> json) {
    totalProducts = json['totalProducts'];
    category = json['category'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalProducts'] = this.totalProducts;
    data['category'] = this.category;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  Position? position;
  String? asin;
  Price? price;
  Reviews? reviews;
  String? url;
  String? score;
  bool? sponsored;
  bool? amazonChoice;
  bool? bestSeller;
  bool? amazonPrime;
  String? title;
  String? thumbnail;

  Result(
      {this.position,
        this.asin,
        this.price,
        this.reviews,
        this.url,
        this.score,
        this.sponsored,
        this.amazonChoice,
        this.bestSeller,
        this.amazonPrime,
        this.title,
        this.thumbnail});

  Result.fromJson(Map<String, dynamic> json) {
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    asin = json['asin'];
    price = (json['price'] != null ? new Price.fromJson(json['price']) : null);
    reviews =
    json['reviews'] != null ? new Reviews.fromJson(json['reviews']) : null;
    url = json['url'];
    score = json['score'];
    sponsored = json['sponsored'];
    amazonChoice = json['amazonChoice'];
    bestSeller = json['bestSeller'];
    amazonPrime = json['amazonPrime'];
    title = json['title'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    data['asin'] = this.asin;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.toJson();
    }
    data['url'] = this.url;
    data['score'] = this.score;
    data['sponsored'] = this.sponsored;
    data['amazonChoice'] = this.amazonChoice;
    data['bestSeller'] = this.bestSeller;
    data['amazonPrime'] = this.amazonPrime;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class Position {
  int? page;
  int? position;
  int? globalPosition;

  Position({this.page, this.position, this.globalPosition});

  Position.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    position = json['position'];
    globalPosition = json['global_position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['position'] = this.position;
    data['global_position'] = this.globalPosition;
    return data;
  }
}

class Price {
  bool? discounted;
  double? currentPrice;
  String? currency;
  int? beforePrice;
  int? savingsAmount;
  double? savingsPercent;

  Price(
      {this.discounted,
        this.currentPrice,
        this.currency,
        this.beforePrice,
        this.savingsAmount,
        this.savingsPercent});

  Price.fromJson(Map<String, dynamic> json) {
    discounted = json['discounted'];
    currentPrice = json['current_price'].toDouble();
    currency = json['currency'];
    beforePrice = json['before_price'];
    savingsAmount = json['savings_amount'];
    savingsPercent = json['savings_percent'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discounted'] = this.discounted;
    data['current_price'] = this.currentPrice;
    data['currency'] = this.currency;
    data['before_price'] = this.beforePrice;
    data['savings_amount'] = this.savingsAmount;
    data['savings_percent'] = this.savingsPercent;
    return data;
  }
}

class Reviews {
  int? totalReviews;
  int? rating;

  Reviews({this.totalReviews, this.rating});

  Reviews.fromJson(Map<String, dynamic> json) {
    totalReviews = json['total_reviews'];
    rating = json['rating'].toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_reviews'] = this.totalReviews;
    data['rating'] = this.rating;
    return data;
  }
}
