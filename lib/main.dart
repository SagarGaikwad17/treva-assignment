import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Movie.dart';
import 'MovieService.dart';
import 'MoviesItem.dart';
import 'MoviesList.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage();
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
  new GlobalKey<ScaffoldState>();

  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }

  void _startSearch() {
    print("open search box");
    ModalRoute
        .of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }

  Widget _buildTitle(BuildContext context) {

    return Center(child: Text('treva',style: TextStyle(fontSize: 29,letterSpacing: 0.5),));
  }

  Widget _buildSearchField() {
    return  TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {

    setState(() {
      searchQuery = newQuery;
    });
    print("search query " + newQuery);

  }

  List<Widget> _buildActions() {

    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      key: scaffoldKey,
      appBar:  AppBar(
        leading: _isSearching ? const BackButton() : Icon(Icons.menu),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.blue,
                    Colors.lightBlueAccent
                  ])
          ),
        ),
      ),
      body:_isSearching
          ?
      (searchQuery.length > 0)? FutureBuilder<List<Movie>>(
            future: searchMovies(searchQuery),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    decoration: BoxDecoration(color: Color(0xff3E3962)),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top:30,left: 25,right: 25,bottom:25),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            // mars
                            Padding(
                              padding:  EdgeInsets.only(bottom:28.0),
                              child: Container(

                                height:100,
                                child: Stack(

                                  children: <Widget>[

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              Text(''),
                                            ],
                                          ),


                                        ),
                                        Expanded(
                                          flex: 10,

                                          child: Container(

                                            decoration:BoxDecoration(

                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black45,
                                                  blurRadius: 8.0, // soften the shadow
                                                  spreadRadius: 5.0, //extend the shadow
                                                  offset: Offset(
                                                    5.0, // Move to right 10  horizontally
                                                    10.0, // Move to bottom 10 Vertically
                                                  ),
                                                )
                                              ],

                                              borderRadius: BorderRadius.all(Radius.circular(5)),

                                              color:Color(0xff444273),

                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: <Widget>[

                                                Expanded(
                                                    flex:10,
                                                    child:Padding(
                                                      padding:  EdgeInsets.only(left: 55,top:15),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[

                                                          Text(snapshot.data[index].title,style:
                                                          TextStyle(
                                                              fontSize: 13,
                                                              color: Colors.white,
                                                              letterSpacing: 0.6

                                                          ),
                                                          ),

                                                          Padding(
                                                            padding:  EdgeInsets.only(top:3.0),
                                                            child: Text(snapshot.data[index].year,style:
                                                            TextStyle(
                                                                fontSize: 11,
                                                                color: Color(0xff9593C4),
                                                                letterSpacing: 0.2

                                                            ),
                                                            ),
                                                          ),

                                                          Padding(
                                                            padding:  EdgeInsets.only(top:5.0),
                                                            child: Container(
                                                              width:25,
                                                              height:2,
                                                              color: Colors.lightBlue,
                                                            ),
                                                          ),

                                                          Padding(
                                                            padding:  EdgeInsets.only(top:16.0),
                                                            child: Row(

                                                              children: <Widget>[


                                                                Padding(
                                                                  padding:  EdgeInsets.only(left: 5),
                                                                  child: Text(snapshot.data[index].type,
                                                                    style:
                                                                    TextStyle(
                                                                        fontSize: 10,
                                                                        color: Color(0xff9593C4),
                                                                        letterSpacing: 0.2

                                                                    ),
                                                                  ),
                                                                ),



                                                              ],

                                                            ),
                                                          )


                                                        ],


                                                      ),
                                                    )
                                                ),

                                                Expanded(
                                                    flex:2,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Center(

                                                            child:
                                                            Padding(
                                                              padding:  EdgeInsets.only(top:15),
                                                              child: Icon(Icons.more_vert,color: Color(0xff9593C4),),
                                                            )

                                                        ),
                                                      ],
                                                    )
                                                ),




                                              ],


                                            ),
                                          ),

                                        ),





                                      ],
                                    ),

                                    Positioned(

                                      top:12,
                                      left: 10,
                                      child: Container(
                                        width: 75,
                                        height: 75,
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image:  NetworkImage(snapshot.data[index].poster)
                                        )
                                        ),



                                      ),
                                    ),


                                  ],
                                ),


                              ),
                            );

                        })
                   // snapshot.data[index]
                );
              } else if (snapshot.hasError) {
                return Container(color:Color(0xff3E3962),child: Center(child:(searchQuery.length > 0)? Text("${snapshot.error}",style: TextStyle(color: Colors.white),):Text("Search",style: TextStyle(color: Colors.white))));
              }
              return Container(color:Color(0xff3E3962),child: Center(child: CircularProgressIndicator()));
            }) : Container(color:Color(0xff3E3962),child:Center(child: Text("Search",style: TextStyle(color: Colors.white),)))
          :
      Container(

        color:Color(0xff3E3962),
        child:ListView(
          padding: EdgeInsets.only(top:30,left: 25,right: 25,bottom:25),
          children: <Widget>[

            // mars
            Padding(
              padding:  EdgeInsets.only(bottom:28.0),
              child: Container(

                height:100,
                child: Stack(

                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Text(''),
                            ],
                          ),


                        ),
                        Expanded(
                          flex: 10,

                          child: Container(

                            decoration:BoxDecoration(

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 8.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    10.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],

                              borderRadius: BorderRadius.all(Radius.circular(5)),

                              color:Color(0xff444273),

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[

                                Expanded(
                                    flex:10,
                                    child:Padding(
                                      padding:  EdgeInsets.only(left: 55,top:15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Text("Mars",style:
                                          TextStyle(
                                            fontSize: 19,
                                            color: Colors.white,
                                            letterSpacing: 0.6

                                          ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:3.0),
                                            child: Text("Milkyway Glaxey",style:
                                            TextStyle(
                                                fontSize: 11,
                                                color: Color(0xff9593C4),
                                                letterSpacing: 0.2

                                            ),
                                            ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:5.0),
                                            child: Container(
                                              width:25,
                                              height:2,
                                              color: Colors.lightBlue,
                                            ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:16.0),
                                            child: Row(

                                              children: <Widget>[

                                                Icon(Icons.place,size: 15,color:Color(0xff9593C4) ,),

                                                Padding(
                                                  padding:  EdgeInsets.only(top:2.0,left: 5),
                                                  child: Text("54.6m km",
                                                    style:
                                                  TextStyle(
                                                      fontSize: 10,
                                                      color: Color(0xff9593C4),
                                                      letterSpacing: 0.2

                                                  ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding:  EdgeInsets.only(left: 8),
                                                  child: Icon(Icons.swap_vert,size: 15,color:Color(0xff9593C4) ,),
                                                ),


                                                Padding(
                                                  padding:  EdgeInsets.only(top:2.0,left: 1),
                                                  child: Text("3.711 m/s",
                                                    style:
                                                    TextStyle(
                                                        fontSize: 10,
                                                        color: Color(0xff9593C4),
                                                        letterSpacing: 0.2

                                                    ),
                                                  ),
                                                ),

                                              ],

                                            ),
                                          )


                                        ],


                                      ),
                                    )
                                ),

                                Expanded(
                                    flex:2,
                                    child: Column(
                                      children: <Widget>[
                                        Center(

                                            child:
                                            Padding(
                                              padding:  EdgeInsets.only(top:15),
                                              child: Icon(Icons.more_vert,color: Color(0xff9593C4),),
                                            )

                                        ),
                                      ],
                                    )
                                ),




                              ],


                            ),
                          ),

                        ),





                      ],
                    ),

                    Positioned(

                      top:12,
                      left: 10,
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle
                        ),

                      ),
                    ),


                  ],
                ),


              ),
            ),

            //neptune
            Padding(
              padding:  EdgeInsets.only(bottom:28.0),
              child: Container(

                height:100,
                child: Stack(

                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Text(''),
                            ],
                          ),


                        ),
                        Expanded(
                          flex: 10,

                          child: Container(

                            decoration:BoxDecoration(

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 8.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    10.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],

                              borderRadius: BorderRadius.all(Radius.circular(5)),

                              color:Color(0xff444273),

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[

                                Expanded(
                                    flex:10,
                                    child:Padding(
                                      padding:  EdgeInsets.only(left: 55,top:15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Text("Neptune",style:
                                          TextStyle(
                                              fontSize: 19,
                                              color: Colors.white,
                                              letterSpacing: 0.6

                                          ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:3.0),
                                            child: Text("Milkyway Glaxey",style:
                                            TextStyle(
                                                fontSize: 11,
                                                color: Color(0xff9593C4),
                                                letterSpacing: 0.2

                                            ),
                                            ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:5.0),
                                            child: Container(
                                              width:25,
                                              height:2,
                                              color: Colors.lightBlue,
                                            ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:16.0),
                                            child: Row(

                                              children: <Widget>[

                                                Icon(Icons.place,size: 15,color:Color(0xff9593C4) ,),

                                                Padding(
                                                  padding:  EdgeInsets.only(top:2.0,left: 5),
                                                  child: Text("2.7b km",
                                                    style:
                                                    TextStyle(
                                                        fontSize: 10,
                                                        color: Color(0xff9593C4),
                                                        letterSpacing: 0.2

                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding:  EdgeInsets.only(left: 8),
                                                  child: Icon(Icons.swap_vert,size: 15,color:Color(0xff9593C4) ,),
                                                ),


                                                Padding(
                                                  padding:  EdgeInsets.only(top:2.0,left: 1),
                                                  child: Text("11.5 m/s",
                                                    style:
                                                    TextStyle(
                                                        fontSize: 10,
                                                        color: Color(0xff9593C4),
                                                        letterSpacing: 0.2

                                                    ),
                                                  ),
                                                ),

                                              ],

                                            ),
                                          )


                                        ],


                                      ),
                                    )
                                ),

                                Expanded(
                                    flex:2,
                                    child: Column(
                                      children: <Widget>[
                                        Center(

                                            child:
                                            Padding(
                                              padding:  EdgeInsets.only(top:15),
                                              child: Icon(Icons.more_vert,color: Color(0xff9593C4),),
                                            )

                                        ),
                                      ],
                                    )
                                ),




                              ],


                            ),
                          ),

                        ),



                      ],
                    ),

                    Positioned(

                      top:12,
                      left: 10,
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle
                        ),
                        child: Center(child: Icon(Icons.ac_unit)),
                      ),
                    ),


                  ],
                ),


              ),
            ),


            //moon
            Padding(
              padding:  EdgeInsets.only(bottom:28.0),
              child: Container(

                height:100,
                child: Stack(

                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Text(''),
                            ],
                          ),


                        ),
                        Expanded(
                          flex: 10,

                          child: Container(

                            decoration:BoxDecoration(

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 8.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    10.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],

                              borderRadius: BorderRadius.all(Radius.circular(5)),

                              color:Color(0xff444273),

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[

                                Expanded(
                                    flex:10,
                                    child:Padding(
                                      padding:  EdgeInsets.only(left: 55,top:15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Text("Moon",style:
                                          TextStyle(
                                              fontSize: 19,
                                              color: Colors.white,
                                              letterSpacing: 0.6

                                          ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:3.0),
                                            child: Text("Milkyway Glaxey",style:
                                            TextStyle(
                                                fontSize: 11,
                                                color: Color(0xff9593C4),
                                                letterSpacing: 0.2

                                            ),
                                            ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:5.0),
                                            child: Container(
                                              width:25,
                                              height:2,
                                              color: Colors.lightBlue,
                                            ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:16.0),
                                            child: Row(

                                              children: <Widget>[

                                                Icon(Icons.place,size: 15,color:Color(0xff9593C4) ,),

                                                Padding(
                                                  padding:  EdgeInsets.only(top:2.0,left: 5),
                                                  child: Text("384.4k km",
                                                    style:
                                                    TextStyle(
                                                        fontSize: 10,
                                                        color: Color(0xff9593C4),
                                                        letterSpacing: 0.2

                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding:  EdgeInsets.only(left: 8),
                                                  child: Icon(Icons.swap_vert,size: 15,color:Color(0xff9593C4) ,),
                                                ),


                                                Padding(
                                                  padding:  EdgeInsets.only(top:2.0,left: 1),
                                                  child: Text("1.62 m/s",
                                                    style:
                                                    TextStyle(
                                                        fontSize: 10,
                                                        color: Color(0xff9593C4),
                                                        letterSpacing: 0.2

                                                    ),
                                                  ),
                                                ),

                                              ],

                                            ),
                                          )


                                        ],


                                      ),
                                    )
                                ),

                                Expanded(
                                    flex:2,
                                    child: Column(
                                      children: <Widget>[
                                        Center(

                                            child:
                                            Padding(
                                              padding:  EdgeInsets.only(top:15),
                                              child: Icon(Icons.more_vert,color: Color(0xff9593C4),),
                                            )

                                        ),
                                      ],
                                    )
                                ),




                              ],


                            ),
                          ),

                        ),



                      ],
                    ),

                    Positioned(

                      top:12,
                      left: 10,
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                        ),
                        child: Center(child: Icon(Icons.ac_unit)),
                      ),
                    ),


                  ],
                ),


              ),
            ),


            //earth
            Padding(
              padding:  EdgeInsets.only(bottom:28.0),
              child: Container(

                height:100,
                child: Stack(

                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Text(''),
                            ],
                          ),


                        ),
                        Expanded(
                          flex: 10,

                          child: Container(

                            decoration:BoxDecoration(

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 8.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    10.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],

                              borderRadius: BorderRadius.all(Radius.circular(5)),

                              color:Color(0xff444273),

                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[

                                Expanded(
                                    flex:10,
                                    child:Padding(
                                      padding:  EdgeInsets.only(left: 55,top:15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Text("Earth",style:
                                          TextStyle(
                                              fontSize: 19,
                                              color: Colors.white,
                                              letterSpacing: 0.6

                                          ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:3.0),
                                            child: Text("Milkyway Glaxey",style:
                                            TextStyle(
                                                fontSize: 11,
                                                color: Color(0xff9593C4),
                                                letterSpacing: 0.2

                                            ),
                                            ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:5.0),
                                            child: Container(
                                              width:25,
                                              height:2,
                                              color: Colors.lightBlue,
                                            ),
                                          ),

                                          Padding(
                                            padding:  EdgeInsets.only(top:16.0),
                                            child: Row(

                                              children: <Widget>[

                                                Icon(Icons.place,size: 15,color:Color(0xff9593C4) ,),

                                                Padding(
                                                  padding:  EdgeInsets.only(top:2.0,left: 5),
                                                  child: Text("2.7b km",
                                                    style:
                                                    TextStyle(
                                                        fontSize: 10,
                                                        color: Color(0xff9593C4),
                                                        letterSpacing: 0.2

                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding:  EdgeInsets.only(left: 8),
                                                  child: Icon(Icons.swap_vert,size: 15,color:Color(0xff9593C4) ,),
                                                ),


                                                Padding(
                                                  padding:  EdgeInsets.only(top:2.0,left: 1),
                                                  child: Text("11.5 m/s",
                                                    style:
                                                    TextStyle(
                                                        fontSize: 10,
                                                        color: Color(0xff9593C4),
                                                        letterSpacing: 0.2

                                                    ),
                                                  ),
                                                ),

                                              ],

                                            ),
                                          )


                                        ],


                                      ),
                                    )
                                ),

                                Expanded(
                                    flex:2,
                                    child: Column(
                                      children: <Widget>[
                                        Center(

                                            child:
                                            Padding(
                                              padding:  EdgeInsets.only(top:15),
                                              child: Icon(Icons.more_vert,color: Color(0xff9593C4),),
                                            )

                                        ),
                                      ],
                                    )
                                ),




                              ],


                            ),
                          ),

                        ),



                      ],
                    ),

                    Positioned(

                      top:12,
                      left: 10,
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle
                        ),
                        child: Center(child: Icon(Icons.ac_unit)),
                      ),
                    ),


                  ],
                ),


              ),
            ),



          ],

        )


      )

    );
  }
}