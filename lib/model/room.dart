class Room{
  static const String COLLECTION_NAME="Rooms";
  String id;
  String title;
  String desc;
  String CatId;

  Room({ this.id=" ",required this.title,required this.desc,required this.CatId});

  Room.fromjson(Map<String,dynamic>json):this(
      id: json["id"],
      title: json["title"],
      desc: json["desc"],
      CatId: json["CatId"]
  );
  Map<String,dynamic>tojson(){
    return{
      "id":id,
      "title":title,
      "desc":desc,
      "CatId":CatId
    };
  }
}