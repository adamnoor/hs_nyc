import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:hs_nyc/school_page.dart';
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:hs_nyc/models.dart';
import 'package:url_launcher/url_launcher.dart';

class Data extends Model {
  List<School> schoolList = List<School>();
  String endPointSchool =
      "https://data.cityofnewyork.us/resource/uq7m-95z8.json";
  bool schoolReturned = false;
  List<SatExam> satList = List<SatExam>();
  String endPointSatExam =
      "https://data.cityofnewyork.us/resource/f9bf-2cp4.json";
  bool satReturned = false;
  String endPointIZoneSchools =
      "https://data.cityofnewyork.us/resource/cr93-x2xf.json";
  List<IZoneSchool> iZoneList = List<IZoneSchool>();
  bool iZoneReturned = false;
  String endPointApExam =
      "https://data.cityofnewyork.us/resource/9ct9-prf9.json";
  List<ApExam> apExamList = List<ApExam>();
  bool apExamReturned = false;

  //This function retrieves and parses the school data and calls the functions
  //tha call other endpoints.  The function has a boolean to prevent unnecessary
  //repeated action.

  Future<List<School>> getSchoolData() async {
    //Uses a boolean to unnecessary calls of this function
    if (schoolReturned == false) {
      var response = await http.get(
          Uri.encodeFull(endPointSchool), // Encode the url
          headers: {"Accept": "application/json"}); // Only accept JSON response
      var dataConvertedToJSON = json.decode(response.body);

      // Extract the required part and assign it to the global variable named data
      if (schoolList.length == 0) {
        for (var value in dataConvertedToJSON) {
          //parses the data- this section handles the location data
          List _lclLocationList = value["location"].split('(');
          String _lclLocation = _lclLocationList[0];
          _lclLocationList = _lclLocationList[1].split(')');
          _lclLocationList = _lclLocationList[0].split(',');
          String _lclLatitude = _lclLocationList[0];
          String _lclLongitude = _lclLocationList[1];

          //creates a school object
          School school = School(
            value["school_name"],
            value["dbn"],
            value["boro"],
            value["ell_programs"],
            value["language_classes"],
            value["advanced_placement_courses"],
            value["neighborhood"],
            value["shared_space"],
            value["building_code"],
            _lclLocation,
            _lclLatitude,
            _lclLongitude,
            value["phone_number"],
            value["fax_number"],
            value["school_email"],
            value["website"],
            value["subway"],
            value["bus"],
            value["grades2018"],
            value["finalgrades"],
            value["total_students"],
            value["start_time"],
            value["end_time"],
            value["attendance_rate"],
            value["graduation_rate"],
          );
          schoolList.add(school);
        }
      }

      //Calls the three functions to get SAT results, AP Exam results and Izone school results.
      getSatExamData();
      getIZoneData();
      getApExamData();

      //sorts the list by school name
      schoolList.sort((a, b) => a.schoolName.compareTo(b.schoolName));
    }

    //Sets the boolean to true to declare that all data has been brought in from the endpoints
    if (schoolList.length != 0 &&
        satList.length != 0 &&
        iZoneList.length != 0 &&
        apExamList.length != 0) {
      schoolReturned = true;
    }

    return schoolList;
  }

  //This function retrieves and parses the SAT data

  Future<List<SatExam>> getSatExamData() async {
    var response = await http.get(
        // Encode the url
        Uri.encodeFull(endPointSatExam),
        // Only accept JSON response
        headers: {"Accept": "application/json"});

    var dataConvertedToJSON = json.decode(response.body);
    // Extract the required part and assign it to the global variable named data

    if (satList.length == 0) {
      for (var value in dataConvertedToJSON) {
        SatExam _satScore = SatExam(
            value["dbn"],
            value["school_name"],
            value["num_of_sat_test_takers"],
            value["sat_math_avg_score"],
            value["sat_writing_avg_score"],
            value["sat_critical_reading_avg_score"]);
        satList.add(_satScore);
      }
    }

    if (satReturned == false) {
      if (satList.length != 0 && schoolList.length != 0) {
        satReturned = true;
        for (var value in satList) {
          for (var school in schoolList) {
            if (value.dbn == school.dbn) {
              school.satTestTakers = value.testTakers;
              school.satMathAvgScore = value.mathAvgScore;
              school.satWritingAvgScore = value.writingAvgScore;
              school.satCriticalReadingAvgScore = value.criticalReadingAvgScore;
            } else {
              //Do nothing here
            }
          }
        }
      }
    }

    return satList;
  }

  //This function retrieves and parses the iZone school data

  Future<List<IZoneSchool>> getIZoneData() async {
    var response = await http.get(Uri.encodeFull(endPointIZoneSchools),
        headers: {"Accept": "application/json"});

    var dataConvertedToJSON = json.decode(response.body);

    if (iZoneList.length == 0) {
      for (var value in dataConvertedToJSON) {
        IZoneSchool iZoneSchool = IZoneSchool(
          value["dbn"],
          value["school"],
          value["initiative"],
        );
        iZoneList.add(iZoneSchool);
      }
    }

    if (iZoneReturned == false) {
      if (iZoneList.length != 0 && schoolList.length != 0) {
        iZoneReturned = true;
        for (var value in iZoneList) {
          for (var school in schoolList) {
            if (value.dbn == school.dbn) {
              school.iZone = value.initiative;
            } else {
              //Do nothing here
            }
          }
        }
      }
    }

    return iZoneList;
  }

  //This function retrieves and parses the AP Exam data

  Future<List<ApExam>> getApExamData() async {
    var response = await http.get(Uri.encodeFull(endPointApExam),
        headers: {"Accept": "application/json"});

    var dataConvertedToJSON = json.decode(response.body);

    if (apExamList.length == 0) {
      for (var value in dataConvertedToJSON) {
        ApExam apExam = ApExam(
          value["dbn"],
          value["school_name"],
          value["num_of_ap_test_takers"],
          value["num_of_ap_total_exams_taken"],
          value["num_of_ap_exams_passed"],
        );
        apExamList.add(apExam);
      }
    }

    if (apExamReturned == false) {
      if (apExamList.length != 0 && schoolList.length != 0) {
        apExamReturned = true;
        for (var value in apExamList) {
          for (var school in schoolList) {
            if (value.dbn == school.dbn) {
              school.apTestTakers = value.testTakers;
              school.apExamsTaken = value.examsTaken;
              school.apExamsPassed = value.examsPassed;
            } else {
              //Do nothing here
            }
          }
        }
      }
    }

    return apExamList;
  }

  //this function navigates to a school page and is call either when a school
  //is selected from the homepage list or when a school is selected from a
  //search list

  void navigateToExamPage(school, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SchoolPage(school),
      ),
    );
  }

  //function that launches the maps feature when a user taps the address

  void launchMapsUrl(String lat, String lon) async {
    double latitude = double.parse(lat);
    double longitude = double.parse(lon);
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
