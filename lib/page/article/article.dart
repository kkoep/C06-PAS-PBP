import 'package:c06_pas_pbp/main.dart';
import 'package:c06_pas_pbp/model/article.dart';
import 'package:c06_pas_pbp/page/article/articleForm.dart';
import 'package:flutter/material.dart';
import 'package:c06_pas_pbp/drawer.dart';
import 'package:c06_pas_pbp/page/article/articleDetail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:c06_pas_pbp/page/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artikel Stunting',
      theme: ThemeData(
        textTheme: const TextTheme(headline4: TextStyle(color: Colors.red)),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyArticlePage(),
    );
  }
}

class MyArticlePage extends StatefulWidget {
  const MyArticlePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'Article Page';

  @override
  State<MyArticlePage> createState() => _articlePage();
}

class _articlePage extends State<MyArticlePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          backgroundColor: Color(0xffAA8B56),
          centerTitle: true,
        ),
        drawer: const PTS_Drawer(),
        endDrawer: Column(
          children: [
            if (LoginState.loggedIn == true)
              if (LoginState.userRole == "DOKTER")
                Container(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(100, 45),
                          backgroundColor: Color(0xffAA8B56)),
                      child: Text(
                        'Post Article',
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xfff0ebce)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleForm()),
                        );
                      },
                    )),
          ],
        ),
        body: FutureBuilder(
            future: Articles.fetchMyArticles(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8),
                    color: Color(0xfff0ebce),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Artikel kosong",
                            style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Container(
                            padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  minimumSize: const Size(100, 45)),
                              child: Text(
                                'Back',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage()),
                                );
                              },
                            )),
                        Container(
                            padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  minimumSize: const Size(100, 45)),
                              child: Text(
                                'Create Article',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage()),
                                );
                              },
                            )),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyDetailPage(
                                      modelArtikel: snapshot.data![index])),
                            ),
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${snapshot.data![index].pk}",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ));
                }
              }
            }));
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.
  }
}
