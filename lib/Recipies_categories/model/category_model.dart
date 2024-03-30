class CategoryModel {
  String? catId;
  String? catName;
  String? catImage;

  CategoryModel({this.catId, this.catName, this.catImage});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catImage = json['cat_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_image'] = this.catImage;
    return data;
  }
}
