import 'package:flutter/material.dart';
import 'package:hs_nyc/data.dart';
import 'package:hs_nyc/models.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:hs_nyc/search_delegate.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //private variables

  List _schoolList;

  //UI Build

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Data>(
        builder: (context, child, data) => Scaffold(
              backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  widget.title,
                  style: TextStyle(color: Colors.blue[900]),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(_schoolList),
                      );
                    },
                  ),
                ],
              ),
              body: FutureBuilder<List<School>>(
                future: data.getSchoolData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<School>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Icon(
                                Icons.signal_wifi_off,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                'Unable to connect.  Check connection & try again.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                onPressed: () => {
                                      data.getSchoolData(),
                                      setState(() {
                                        build(context);
                                      }),
                                    },
                                child: Text("Press Here to Try Again",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      );
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError)
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Icon(
                                  Icons.signal_wifi_off,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  'Unable to connect.  Check connection & try again.',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  onPressed: () => {
                                        data.getSchoolData(),
                                        setState(() {
                                          build(context);
                                        }),
                                      },
                                  child: Text("Press Here to Try Again",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        );

                      _schoolList = snapshot
                          .data; //populates the local list with School objects from endpoints

                      //The style for the table was from a Medium Article found here:
                      //https://proandroiddev.com/flutter-thursday-02-beautiful-list-ui-and-detail-page-a9245f5ceaf0

                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              snapshot.data == null ? 0 : snapshot.data.length,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return Container(
                                child: Center(
                                    child: Column(
                              // Stretch the cards in horizontal axis
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(64, 75, 96, .9)),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      onTap: () => data.navigateToExamPage(
                                          snapshot.data[index], context),
                                      leading: Container(
                                        padding: EdgeInsets.only(right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(
                                                    width: 1.0,
                                                    color: Colors.white24))),
                                        child: CircleAvatar(
                                            child: Text(
                                                "${snapshot.data[index].boro}")),
                                      ),
                                      title: Text(
                                        "${snapshot.data[index].schoolName}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .45,
                                              child: Text(
                                                  "${snapshot.data[index].neighborhood}",
                                                  style: TextStyle(
                                                      color: Colors.white)))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )));
                          });
                  }
                },
              ),
            ));
  }
}
