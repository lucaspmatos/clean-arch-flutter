import 'package:clean_arch/modules/search/domain/entities/search_result.dart';

class SearchResultModel extends SearchResult {
  String? title;
  String? content;
  String? img;

  SearchResultModel({
    this.title,
    this.content,
    this.img,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['title'] = title;
    map['content'] = content;
    map['img'] = img;

    return map;
  }

  SearchResultModel.fromJson(dynamic json) {
    title = json['title'];
    content = json['content'];
    img = json['img'];
  }
}
