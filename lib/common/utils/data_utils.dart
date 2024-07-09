import '../const/data.dart';

class DataUtils{
  //무조건 static여야함
  static pathToUrl(String value){
    return "http://$ip$value}";
  }

  static listPathsToUrls(List<String> paths){
    return paths.map((e)=>pathToUrl(e)).toList();
  }
}