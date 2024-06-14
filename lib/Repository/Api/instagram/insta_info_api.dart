import 'dart:convert';



import 'package:http/http.dart';
import 'package:instagram/Repository/Api/api_client.dart';
import 'package:instagram/Repository/Model/Insta_follower_model.dart';
import 'package:instagram/Repository/Model/inst_highlight_model.dart';
import 'package:instagram/Repository/Model/insta_following_model.dart';
import 'package:instagram/Repository/Model/insta_info_model.dart';
import 'package:instagram/Repository/Model/insta_post_model.dart';



class InstagramApi {
  ApiClient apiClient = ApiClient();


  Future<Infomodel> getInfo(String name) async {
    String trendingpath = 'https://instagram-scraper-api2.p.rapidapi.com/v1/info?username_or_id_or_url=${name}';
    var body = {

    };
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return Infomodel.fromJson(jsonDecode(response.body));
  }
   Future<Highlightmodel> getHighlight(String name) async {
    String trendingpath = 'https://instagram-scraper-api2.p.rapidapi.com/v1/highlights?username_or_id_or_url=${name}';
    var body = {

    };
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return Highlightmodel.fromJson(jsonDecode(response.body));
  }
    Future<Postmodel> getpost(String name) async {
     
    String trendingpath = 'https://instagram-scraper-api2.p.rapidapi.com/v1.2/posts?username_or_id_or_url=${name}';
    var body = {

    };
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return Postmodel.fromJson(jsonDecode(response.body));
  }
   Future<Followersmodel> getFollower(String name) async {
     
    String trendingpath = 'https://instagram-scraper-api2.p.rapidapi.com/v1/followers?username_or_id_or_url=${name}';
    var body = {

    };
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return Followersmodel.fromJson(jsonDecode(response.body));
  }
  Future<Followingmodel> getFollowing(String name) async {
     
    String trendingpath = 'https://instagram-scraper-api2.p.rapidapi.com/v1/following?username_or_id_or_url=${name}';
    var body = {

    };
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', body);

    return Followingmodel.fromJson(jsonDecode(response.body));
  }
}