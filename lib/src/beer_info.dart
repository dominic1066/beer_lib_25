enum OnTapStatus { now, next, no }

// typedef Comparator<BeerInfo> = CompareABVFunc(BeerInfo a, BeerInfo b);

// int compareABV(BeerInfo a, BeerInfo b) {
//   if (double.parse(a.ABV) < double.parse(b.ABV)) {
//     return -1;
//   } else if (a.ABV == b.ABV) {
//     return 0;
//   } else {
//     return 1;
//   }
// }

class BeerInfo {
  String name = "";
  String brewery = "";
  String image = "";
  String style = "";
  // ignore: non_constant_identifier_names
  String ABV = "";
  String volume = "";
  String price = "";
  String pouring = "";
  String description = "";
  String handpump = "";
  String country = "";
  // ignore: non_constant_identifier_names
  String IBU = "";
  String tapBadge = "";
  String comments = "";
  int rowNum = 0;

  BeerInfo.dontUse(String name) {
    name = name;
  }

  BeerInfo(sheetRow, Map<int, String> columnMappings) {
    for (var i = 0; i < sheetRow.length; i++) {
      var colHeading = columnMappings[i];
      var cellValue = sheetRow[i];
      switch (colHeading) {
        case 'Beer':
          name = cellValue.value;
          break;

        case 'On Tap':
          pouring = cellValue.value;
          break;

        case 'Brewery':
          brewery = cellValue.value;
          break;

        case 'Style':
          style = cellValue.value;
          break;

        case 'ABV':
          ABV = cellValue.value;
          break;

        case 'Volume':
          volume = cellValue.value;
          break;

        case 'Price':
          price = cellValue.value;
          break;

        case 'Image':
          image = cellValue.value;
          break;

        case 'Handpump':
          handpump = cellValue.value;
          break;

        case 'IBU':
          IBU = cellValue.value;
          break;

        case 'Tap Badge':
          tapBadge = cellValue.value;
          break;

        case 'Comments':
          comments = cellValue.value;
          break;

        default:
          //print(colHeading);
          break;
      }
    }
  }

  OnTapStatus onTap() {
    if (pouring == 'Now') {
      return OnTapStatus.now;
    } else if (pouring == 'Next') {
      return OnTapStatus.next;
    } else if (pouring == 'No') {
      return OnTapStatus.no;
    } else {
      return OnTapStatus.no;
    }
  }

  String fullName() {
    return '$brewery $name';
  }

  String key() {
    return '$brewery|$name|$style|$handpump';
  }
}
