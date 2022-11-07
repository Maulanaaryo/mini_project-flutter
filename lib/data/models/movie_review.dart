class ReviewModel {
  late int? id;
  late String title;
  late String descrption;

  ReviewModel({this.id, required this.title, required this.descrption});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': descrption,
    };
  }

  ReviewModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    descrption = map["description"];
  }
}
