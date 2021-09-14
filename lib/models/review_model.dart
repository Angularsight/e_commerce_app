class ReviewModel {
  int? totalReviews;
  StarsStat? starsStat;
  List<Result>? result;

  ReviewModel({this.totalReviews, this.starsStat, this.result});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    totalReviews = json['total_reviews'];
    starsStat = json['stars_stat'] != null
        ? new StarsStat.fromJson(json['stars_stat'])
        : null;
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_reviews'] = this.totalReviews;
    if (this.starsStat != null) {
      data['stars_stat'] = this.starsStat!.toJson();
    }
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StarsStat {
  String? s1;
  String? s2;
  String? s3;
  String? s4;
  String? s5;

  StarsStat({this.s1, this.s2, this.s3, this.s4, this.s5});

  StarsStat.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.s5;
    return data;
  }
}

class Result {
  String? id;
  Asin ?asin;
  String? reviewData;
  Date? date;
  String? name;
  int? rating;
  String? title;
  String? review;
  bool? verifiedPurchase;

  Result(
      {this.id,
        this.asin,
        this.reviewData,
        this.date,
        this.name,
        this.rating,
        this.title,
        this.review,
        this.verifiedPurchase});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    asin = json['asin'] != null ? new Asin.fromJson(json['asin']) : null;
    reviewData = json['review_data'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    name = json['name'];
    rating = json['rating'];
    title = json['title'];
    review = json['review'];
    verifiedPurchase = json['verified_purchase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.asin != null) {
      data['asin'] = this.asin!.toJson();
    }
    data['review_data'] = this.reviewData;
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['review'] = this.review;
    data['verified_purchase'] = this.verifiedPurchase;
    return data;
  }
}

class Asin {
  String? original;
  String? variant;

  Asin({this.original, this.variant});

  Asin.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    variant = json['variant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this.original;
    data['variant'] = this.variant;
    return data;
  }
}

class Date {
  String? date;
  int? unix;

  Date({this.date, this.unix});

  Date.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    unix = json['unix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['unix'] = this.unix;
    return data;
  }
}
