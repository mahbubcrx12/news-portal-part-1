import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:news_portal/news_model/news_model.dart';

//https://newsapi.org/v2/everything?q=apple&from=2022-09-06&to=2022-09-06&
// sortBy=popularity&apiKey=503143c1974d402b8c7f7f9f3d2fd7a3

class NewsApiService{

  Future<List<Articles>> fetchNewsData()async{
    List<Articles> newsArticlesList=[];
    var link=Uri.parse(
        "https://newsapi.org/v2/everything?q=apple&from=2022-09-06&to=2022-09-06&sortBy=popularity&apiKey=503143c1974d402b8c7f7f9f3d2fd7a3"
    );
    var response=await http.get(link);
    //print("response is ${response.body}");
    var data=jsonDecode(response.body);
    Articles articles;
    for(var i in data["articles"]){
        articles=Articles.fromJson(i);
        newsArticlesList.add(articles);
    }

    return newsArticlesList;
  }

}