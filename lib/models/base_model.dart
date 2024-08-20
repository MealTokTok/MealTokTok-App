abstract class BaseModelPost {
  Map<String, dynamic> toJson();
}

abstract class BaseModelGet {
  BaseModelGet fromMap(Map<String, dynamic> map);
}

abstract class BaseModel {
  Map<String, dynamic> toJson();
  BaseModel fromMap(Map<String, dynamic> map);
}