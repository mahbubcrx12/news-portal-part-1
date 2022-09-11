import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_portal/news_model/news_model.dart';
import 'package:news_portal/widget/const.dart';
import 'package:news_portal/service/news_portal_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Articles> newsList = [];

  @override
  void didChangeDependencies() async {
    newsList = await NewsApiService().fetchNewsData();
    setState(() {});
    super.didChangeDependencies();
  }

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0XFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0XFFF5F5F5),
        leading: Icon(
          Icons.menu,
          color: Colors.black,
          size: 28,
        ),
        centerTitle: true,
        title: Text(
          "News App",
          style: GoogleFonts.dancingScript(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 28,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "All News",
                style: myStyle(22, Colors.black, FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * .04,
                child: Row(
                  children: [
                    paginationButton(onTap: () {}, title: "Prev"),
                    Flexible(
                        child: ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 1),
                                  child: MaterialButton(
                                    color: index + 1 == currentIndex
                                        ? Colors.blue
                                        : Colors.white54,
                                    minWidth: 8,
                                    onPressed: () {
                                      setState(() {
                                        currentIndex = index + 1;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text("${index + 1}"),
                                    ),
                                  ));
                            })),
                    paginationButton(onTap: () {}, title: "Next")
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: Color(0XFFFFFFFF)
                ),
                child: Center(
                  child: Text("publishedAt"),
                )
              )
            ],),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color: Color(0XFFFFFFFF)),
                          height: size.height * .15,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: NetworkImage(
                                        "${newsList[index].urlToImage}"),
                                    width: 130,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${newsList[index].title}",
                                          maxLines: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Icon(Icons.alarm_sharp,size: 25),
                                            Text(
                                              "less then one minute",
                                            ),
                                          ],),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                          Icon(Icons.link,size: 25,color: Colors.blue,),
                                          Text(
                                            "${newsList[index].publishedAt}",
                                          ),
                                        ],)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 8,
                            child: Container(
                              height: 60,
                              width: 10,
                              color: Color(0XFF79A3B1),
                            )),
                        Positioned(
                            top: 8,
                            left: 9,
                            child: Container(
                              height: 10,
                              width: 50,
                              color: Color(0XFF79A3B1),
                            )),
                        Positioned(
                            bottom: 8,
                            right: 9,
                            child: Container(
                              height: 10,
                              width: 50,
                              color: Color(0XFF79A3B1),
                            )),
                        Positioned(
                            right: 1,
                            bottom: 8,
                            child: Container(
                              height: 60,
                              width: 10,
                              color: Color(0XFF79A3B1),
                            )),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton paginationButton({VoidCallback? onTap, String? title}) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(
          "$title",
          style: myStyle(18, Colors.white),
        ));
  }
}
