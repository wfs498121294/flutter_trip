
class CommonModel{
   final String icon;
   final String? title;
   final String? url;
   final String? statusBarColor;
   final bool? hideAppBar;

  CommonModel(
      this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar);

  factory CommonModel.fromJson(Map<String,dynamic> json){
    return CommonModel(json["icon"] ?? "",  json["title"] ?? "", json["url"] ?? "", json["statusBarColor"] ?? "", json["hideAppBar"] ?? false);
    // return CommonModel(json["icon"], json["title"], json["url"], json["statusBarColor"], json["hideAppBar"])
    // return CommonModel(
    //     icon: json["icon"],
    //     title:json["title"],
    //     url: json["url"],
    //     statusBarColor: json["statusBarColor"],
    //     hideAppBar: json["hideAppBar"] );
  }
// CommonModel({required this.icon,required this.title,required this.url,required this.statusBarColor,required this.hideAppBar});
// control + enter 弹出构造方法
}

