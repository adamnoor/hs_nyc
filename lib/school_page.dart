import 'package:flutter/material.dart';
import 'package:hs_nyc/data.dart';
import 'package:hs_nyc/models.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';


class SchoolPage extends StatefulWidget {
  final School school;

  SchoolPage(this.school); //Constructor brings in the School object selected

  @override
  _SchoolPageState createState() => _SchoolPageState();
}


class _SchoolPageState extends State<SchoolPage> {

  //private variables

  SchoolInfo _schoolInfo;
  List _titleList;
  List _infoList;
  String _lclNumber;


  //init function- populates data for this screen

  @override
  void initState() {

    //Creates an object that contains the data from the school for the table

    _schoolInfo = SchoolInfo(
        widget.school.subway,
        widget.school.bus,
        widget.school.finalGrades,
        widget.school.ellPrograms,
        widget.school.languageClasses,
        widget.school.startTime,
        widget.school.endTime,
        widget.school.totalStudents,
        widget.school.attendanceRate,
        widget.school.graduationRate,
        widget.school.iZone,
        widget.school.apTestTakers,
        widget.school.apExamsTaken,
        widget.school.apExamsPassed,
        widget.school.satTestTakers,
        widget.school.satMathAvgScore,
        widget.school.satWritingAvgScore,
        widget.school.satCriticalReadingAvgScore);

    //creates a list of titles for the table

    _titleList = [
      _schoolInfo.subwayTitle,
      _schoolInfo.busTitle,
      _schoolInfo.gradesTitle,
      _schoolInfo.studentTitle,
      _schoolInfo.schoolDayTitle,
      _schoolInfo.languageTitle,
      _schoolInfo.ellTitle,
      _schoolInfo.iZoneTitle,
      _schoolInfo.apExamsTitle,
      _schoolInfo.satTitle,
    ];

    //creates a list of information about the school for the table

    _infoList = [
      _schoolInfo.subway,
      _schoolInfo.bus,
      _schoolInfo.grades,
      "Number of Students: ${_schoolInfo.population}\n\nAttendance Rate: ${_schoolInfo.attendance}\n\nGraduation Rate: ${_schoolInfo.graduation}",
      "Start Time: ${_schoolInfo.startTime}\n\nEnd Time: ${_schoolInfo.endTime}",
      _schoolInfo.language,
      _schoolInfo.ell,
      _schoolInfo.iZone,
      "Test Takers:  ${_schoolInfo.apTestTakers}\n\nExams Taken:  ${_schoolInfo.apExamsTaken}\n\nExams Passed:  ${_schoolInfo.apExamsPassed}\n\n",
      "Test Takers:  ${_schoolInfo.satTestTakers}\n\nMath Score:  ${_schoolInfo.satMathAvgScore}\n\nWriting Score:  ${_schoolInfo.satWritingAvgScore}\n\nCritical Reading Score:  ${_schoolInfo.satCriticalReadingAvgScore}"
    ];

    //parses the phone number so that it can be read by the phone

    _lclNumber = "tel:/${widget.school.phoneNumber.replaceAll(new RegExp(r'-'), '')}";
    
    
    super.initState();
  }


  //UI Build

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "SCHOOL INFORMATION",
            style: TextStyle(color: Colors.blue[900]),
          ),
        ),
        body: ScopedModelDescendant<Data>(
          builder: (context, child, model) => Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(
                        "${widget.school.schoolName}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FlatButton(
                      onPressed: () => {
                            model.launchMapsUrl(
                                widget.school.latitude, widget.school.longitude)
                          },
                      child: Text(
                        "${widget.school.location}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FlatButton(
                      onPressed: () =>
                          {launch("mailto:${widget.school.schoolEmail}")},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          Text(
                            "  ${widget.school.schoolEmail}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () =>
                          {launch("http://${widget.school.website}")},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.computer,
                            color: Colors.white,
                          ),
                          Text(
                            "  ${widget.school.website}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () => {
                            launch(_lclNumber),
                          },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone_in_talk,
                            color: Colors.white,
                          ),
                          Text(
                            "  ${widget.school.phoneNumber}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height * .35,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: _titleList.length,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return Container(
                                child: Center(
                                    child: Column(
                              children: <Widget>[
                                Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(64, 75, 96, .9)),
                                    child: Column(

                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .8,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .3,
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "${_titleList[index]}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  "\n${_infoList[index]}",
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )));
                          }),
                    ),
                  ],
                ),
              ),
        ));
  }
}
