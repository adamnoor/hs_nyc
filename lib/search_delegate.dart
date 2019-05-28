import 'package:flutter/material.dart';
import 'package:hs_nyc/data.dart';
import 'package:hs_nyc/models.dart';


//This class creates the search feature when the magnifying glass is pressed

class CustomSearchDelegate extends SearchDelegate {
  final List<School> _schoolList;

  CustomSearchDelegate(
      this._schoolList); //Constructor brings in a list of School objects

  //private variables

  final List<String> _recentSearches = [];
  List<String> _schoolNameList = [];

  //private functions

  //creates list of school names
  List<String> _createSchoolName(nameList, schoolList) {
    if (nameList.length != schoolList.length) {
      for (var value in schoolList) {
        nameList.add(value.schoolName);
      }
    }
    return nameList;
  }

  //opens the school page after a user selects a school from a search
  void _openSchoolPageFromSearch(name, schoolList, context) {
    for (var value in schoolList) {
      if (value.schoolName == name) {
        close(context, null);
        Data().navigateToExamPage(value, context);
      }
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;

    //I"m not using this override as I am using the onTap function of the list
    //of returned search items to launch the school page.
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    //This override allows a user to build a list of schools from a query then
    //tap on the school and launch the school page

    final List<String> lclSchoolNameList =
    _createSchoolName(_schoolNameList, _schoolList);
    final List<String> lclSuggestionList = query.isEmpty
        ? _recentSearches
        : lclSchoolNameList
        .where((p) => p.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () => {
          _openSchoolPageFromSearch(
              lclSuggestionList[index], _schoolList, context),
        },
        leading: Icon(Icons.school),
        title: Text(lclSuggestionList[index]),
      ),
      itemCount: lclSuggestionList.length,
    );
  }
}
