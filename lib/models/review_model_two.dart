class ReviewModelTwo {
  int? totalreviews;
  Starsstat? starsstat;
  List<Results>? result;

  ReviewModelTwo({this.totalreviews, this.starsstat, this.result});

  ReviewModelTwo.fromJson(Map<String, dynamic> json) {
    totalreviews = json['totalreviews'];
    starsstat = json['starsstat'] != null
        ? new Starsstat.fromJson(json['starsstat'])
        : null;
    if (json['result'] != null) {
      result = <Results>[];
      json['result'].forEach((v) {
        result!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalreviews'] = this.totalreviews;
    if (this.starsstat != null) {
      data['starsstat'] = this.starsstat!.toJson();
    }
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Starsstat {
  String? s1;
  String? s2;
  String? s3;
  String? s4;
  String? s5;

  Starsstat({this.s1, this.s2, this.s3, this.s4, this.s5});

  Starsstat.fromJson(Map<String, dynamic> json) {
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

class Results {
  String? id;
  Asin? asin;
  String? reviewdata;
  Date? date;
  String? name;
  int? rating;
  String? title;
  String? review;
  bool? verifiedpurchase;

  Results(
      {this.id,
        this.asin,
        this.reviewdata,
        this.date,
        this.name,
        this.rating,
        this.title,
        this.review,
        this.verifiedpurchase});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    asin = json['asin'] != null ? new Asin.fromJson(json['asin']) : null;
    reviewdata = json['reviewdata'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    name = json['name'];
    rating = json['rating'];
    title = json['title'];
    review = json['review'];
    verifiedpurchase = json['verifiedpurchase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.asin != null) {
      data['asin'] = this.asin!.toJson();
    }
    data['reviewdata'] = this.reviewdata;
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['review'] = this.review;
    data['verifiedpurchase'] = this.verifiedpurchase;
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
