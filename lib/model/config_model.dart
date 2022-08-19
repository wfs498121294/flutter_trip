
class ConfigModel{
  String searchUrl;
  ConfigModel({required this.searchUrl});

  factory ConfigModel.fromJson(Map<String,dynamic> json){
    return ConfigModel(searchUrl:json["searchUrl"]);
  }
}