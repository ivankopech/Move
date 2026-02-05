class CreateReviewModel {
  String? comment;
  int? rating;

  CreateReviewModel({this.comment, this.rating});

  CreateReviewModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    data['rating'] = rating;
    return data;
  }
}
