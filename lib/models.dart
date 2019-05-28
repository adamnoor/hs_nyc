//This file has all of the models of the objects used in this app

class School {
  final String schoolName;
  final String dbn;
  final String boro;
  final String ellPrograms;
  final String languageClasses;
  final String advancedPlacementCourses;
  final String neighborhood;
  final String sharedSpace;
  final String buildingCode;
  final String location;
  final String latitude;
  final String longitude;
  final String phoneNumber;
  final String faxNumber;
  final String schoolEmail;
  final String website;
  final String subway;
  final String bus;
  final String grades2018;
  final String finalGrades;
  final String totalStudents;
  final String startTime;
  final String endTime;
  final String attendanceRate;
  final String graduationRate;


  School(
      this.schoolName,
      this.dbn,
      this.boro,
      this.ellPrograms,
      this.languageClasses,
      this.advancedPlacementCourses,
      this.neighborhood,
      this.sharedSpace,
      this.buildingCode,
      this.location,
      this.latitude,
      this.longitude,
      this.phoneNumber,
      this.faxNumber,
      this.schoolEmail,
      this.website,
      this.subway,
      this.bus,
      this.grades2018,
      this.finalGrades,
      this.totalStudents,
      this.startTime,
      this.endTime,
      this.attendanceRate,
      this.graduationRate,
      );

  String iZone =  "N/A";
  String apTestTakers =  "N/A";
  String apExamsTaken =  "N/A";
  String apExamsPassed =  "N/A";
  String satTestTakers =  "N/A";
  String satMathAvgScore =  "N/A";
  String satWritingAvgScore =  "N/A";
  String satCriticalReadingAvgScore =  "N/A";

}


class SchoolInfo {
  final String subway;
  final String subwayTitle = "Subway";
  final String bus;
  final String busTitle = "Bus";
  final String grades;
  final String gradesTitle = "Grades";
  final String ell;
  final String ellTitle = "ELL";
  final String language;
  final String languageTitle = "Language Classes";
  final String startTime;
  final String endTime;
  final String schoolDayTitle = "School Day";
  final String population;
  final String attendance;
  final String graduation;
  final String studentTitle = "Students";
  final String iZone;
  final String iZoneTitle = "iZone Initiative";
  final String apTestTakers;
  final String apExamsTaken;
  final String apExamsPassed;
  final String apExamsTitle = "AP Exam Results- 2012";
  final String satTestTakers;
  final String satMathAvgScore;
  final String satWritingAvgScore;
  final String satCriticalReadingAvgScore;
  final String satTitle = "SAT Results- 2012";



  SchoolInfo(
      this.subway,
      this.bus,
      this.grades,
      this.ell,
      this.language,
      this.startTime,
      this.endTime,
      this.population,
      this.attendance,
      this.graduation,
      this.iZone,
      this.apTestTakers,
      this.apExamsTaken,
      this.apExamsPassed,
      this.satTestTakers,
      this.satMathAvgScore,
      this.satWritingAvgScore,
      this.satCriticalReadingAvgScore);
}

class IZoneSchool {
  final String dbn;
  final String schoolName;
  final String initiative;

  IZoneSchool(this.dbn, this.schoolName, this.initiative);
}

class ApExam {
  final String dbn;
  final String schoolName;
  final String testTakers;
  final String examsTaken;
  final String examsPassed;

  ApExam(this.dbn, this.schoolName, this.testTakers, this.examsTaken, this.examsPassed);
}

class SatExam {
  final String dbn;
  final String schoolName;
  final String testTakers;
  final String mathAvgScore;
  final String writingAvgScore;
  final String criticalReadingAvgScore;

  SatExam(
      this.dbn,
      this.schoolName,
      this.testTakers,
      this.mathAvgScore,
      this.writingAvgScore,
      this.criticalReadingAvgScore);
}
