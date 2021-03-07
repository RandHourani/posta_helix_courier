class PodModel{

}
class Proof{
Images img;


}
class Images{
  String name;
  int size=0;
  Images({this.name,this.size});

  factory Images.fromJson(Map<String,dynamic>json)
  {return Images(
    name: json['name']as String,
    size: json['size']as int
  );}
}