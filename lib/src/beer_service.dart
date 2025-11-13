import 'package:gsheets/gsheets.dart';
import 'beer_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'secrets.dart';



class BeerListService {
  Map<int, String> columnMappings = <int, String>{};


  BeerListService();



  // new version using script on sheet

  doDoubleBeerStatusChange(BeerInfo beer1, OnTapStatus newStatus1,
      BeerInfo beer2, OnTapStatus newStatus2) async {
    String newStatusStr = "";
    switch (newStatus1) {
      case OnTapStatus.next:
        newStatusStr = "next";
        break;
      case OnTapStatus.no:
        newStatusStr = "no";
        break;
      case OnTapStatus.now:
        newStatusStr = "now";
        break;
      default:
        break;
    }
    try {
      Uri changeStatusURI = Uri(
          host: "script.google.com",
          path: Secrets.scriptPath,
          query: "action=changeStatus&$newStatusStr=${beer1.key()}",
          scheme: "https");
      print("URI:$changeStatusURI");
      await http.get(changeStatusURI).then((response) {
        print(convert.jsonDecode(response.body)['status']);
      });
      print("returned!");

      //      await http.get(URL);
    } catch (e) {
      print(e.toString());
    }
    switch (newStatus2) {
      case OnTapStatus.next:
        newStatusStr = "next";
        break;
      case OnTapStatus.no:
        newStatusStr = "no";
        break;
      case OnTapStatus.now:
        newStatusStr = "now";
        break;
      default:
        break;
    }
    try {
      Uri changeStatusURI = Uri(
          host: "script.google.com",
          path: Secrets.scriptPath,
          query: "action=changeStatus&$newStatusStr=${beer2.key()}",
          scheme: "https");
      print("URI:$changeStatusURI");
      await http.get(changeStatusURI).then((response) {
        print(convert.jsonDecode(response.body)['status']);
      });
      print("returned!");

      //      await http.get(URL);
    } catch (e) {
      print(e.toString());
    }
  }

  updateBeerTapStatus(BeerInfo currentBeer, OnTapStatus newStatus) async {
    print("in updateBeerTapStatus");
    print(currentBeer.key());
    String newStatusStr = "";
    switch (newStatus) {
      case OnTapStatus.next:
        newStatusStr = "next";
        break;
      case OnTapStatus.no:
        newStatusStr = "no";
        break;
      case OnTapStatus.now:
        newStatusStr = "now";
        break;
      default:
        break;
    }
    try {
      Uri changeStatusURI = Uri(
          host: "script.google.com",
          path: Secrets.scriptPath,
          query:
              "action=changeStatus&$newStatusStr=${currentBeer.key()}",
          scheme: "https");
      print("URI:$changeStatusURI");
      await http.get(changeStatusURI).then((response) {
        print(convert.jsonDecode(response.body)['status']);
      });
      print("returned!");

      //      await http.get(URL);
    } catch (e) {
      print(e.toString());
    }
  }

/*
  doSort() async {
    impl.postNewBeer("abc");
  }
*/
  Future<List<BeerInfo>> getTapList(OnTapStatus targetStatus,
      {bool byBrewery = false}) async {
    var colMappings = <int, String>{};
    final gsheets = GSheets(Secrets.credentials);
    final ss = await gsheets.spreadsheet(Secrets.spreadsheetId);
    var sheet = ss.worksheetByTitle('Sheet1');

    //ss.worksheetByTitle(title).
    //var rowCount = sheet.rowCount;

    var result = <BeerInfo>[];

    var colHeadings = await sheet?.values.row(1);
    if (colHeadings != null) {
      for (var i = 0; i < colHeadings.length; i++) {
        //print(ColHeadings[i]);
        colMappings[i] = colHeadings[i];
        //print(colHeadings[i]);
      }
      try {
        var allRows = await sheet?.cells.allRows();
        if (allRows != null) {
          var rowCount = allRows.length;
          /*print(
              'TOTAL rowCount: $rowCount searching for ${targetStatus.toString()}');*/
          //print('$rowCount rows');
          //      for (var j=1; j < 10; j++)
          for (var j = 1; j < rowCount; j++) {
            var currentRow = allRows[j];
            var newBeer = BeerInfo(currentRow, colMappings);
            newBeer.rowNum = j;
            if (newBeer.onTap() == targetStatus) {
              result.add(newBeer);
            }
          }
        } else {
          print('no rows returned!');
        }
/*          if (newBeer.pouring == 'now') {
              print('${newBeer.brewery} ${newBeer.name}');
          } else if(newBeer.pouring == 'New')
          {
              print('next - ${newBeer.brewery} ${newBeer.name}');
          }*/
      } on GSheetsException catch (e) {
        print(e);
      }
    }

    if (byBrewery) {
      result.sort((a, b) => a.fullName().compareTo(b.fullName()));
    }
    print('returning from GetTapList');
    return result;
  }
}
