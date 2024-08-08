import 'package:hankkitoktok/models/base_model.dart';

class SideDish extends BaseModel{
  String tag;
  String name;
  String imageUrl;

  SideDish(this.tag, this.name, this.imageUrl);

  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    return SideDish(
      map['tag'],
      map['name'],
      map['imageUrl'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'name': name,
      'imageUrl': imageUrl,
    };
  }


}