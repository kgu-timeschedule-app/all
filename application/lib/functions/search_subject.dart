import 'package:fuzzy/fuzzy.dart';

List<Map<String, dynamic>> searchConditional(int syllabusData,
    List<Map<String, dynamic>> searchlistInFunction, String syllabusName) {
  List<Map<String, dynamic>> searchlistInFunctionResult = searchlistInFunction;
  if (syllabusData != 0) {
    searchlistInFunctionResult = searchlistInFunction
        .where((e) => e[syllabusName] == syllabusData - 1)
        .toList();
  }
  return searchlistInFunctionResult;
}

List<Map<String, dynamic>> searchConditionalHowto(int syllabusData,
    List<Map<String, dynamic>> searchlistInFunction, String syllabusName) {
  List<Map<String, dynamic>> searchlistInFunctionResult = searchlistInFunction;
  print(searchlistInFunction);
  if (syllabusData == 1) {
    searchlistInFunctionResult = searchlistInFunction
        .where((e) =>
            e[syllabusName] != null && e[syllabusName].indexOf("本登録") != -1)
        .toList();
    return searchlistInFunctionResult;
  } else if (syllabusData == 2) {
    searchlistInFunctionResult = searchlistInFunction
        .where((e) =>
            e[syllabusName] != null && e[syllabusName].indexOf("予備") != -1)
        .toList();
    return searchlistInFunctionResult;
  } else if (syllabusData == 3) {
    searchlistInFunctionResult = searchlistInFunction
        .where((e) =>
            e[syllabusName] != null && e[syllabusName].indexOf("申込") != -1)
        .toList();
    return searchlistInFunctionResult;
  }
  return searchlistInFunction;
}

List<Map<String, dynamic>> searchConditionalList(
    int syllabusData, List<Map<String, dynamic>> searchlistInFunction) {
  int i = 1;
  bool check = false;
  List<Map<String, dynamic>> searchlistInFunctionResult = searchlistInFunction;
  if (syllabusData != 0) {
    searchlistInFunctionResult = searchlistInFunction.where((e) {
      check = false;
      if (e["時限1"] == null) {
        return check;
      }
      i = 1;
      while (e["時限" + i.toString()] != null) {
        if (e["時限" + i.toString()] == syllabusData - 1) {
          check = true;
          break;
        }
        i++;
      }
      return check;
    }).toList();
  }
  return searchlistInFunctionResult;
}

Future<List> serchSyllabus(Map<String, dynamic> syllabusData) async {
  // "school": school, "season": season, "date": date, "dept" : dept, "howto": howto
  List<Map<String, dynamic>> searchlist = [];
  searchlist = searchConditional(syllabusData["school"],
      syllabusData["data"].cast<Map<String, dynamic>>(), "campas");
  searchlist = searchConditional(syllabusData["season"], searchlist, "開講期");
  searchlist = searchConditional(syllabusData["dept"], searchlist, "管理部署");
  searchlist =
      searchConditionalHowto(syllabusData["howto"], searchlist, "履修登録方法");
  searchlist = searchConditionalList(syllabusData["date"], searchlist);
  var fuse = Fuzzy(searchlist,
      options: FuzzyOptions(
          findAllMatches: true,
          isCaseSensitive: true,
          shouldSort: true,
          // tryVersion
          tokenize: true,
          threshold: 0.6,
          keys: [
            WeightedKey(
                name: "name",
                getter: (e) => (e as Map)["name"].toString(),
                weight: 1),
            WeightedKey(
                name: "担当者",
                getter: (e) => (e as Map)["担当者"].toString(),
                weight: 1)
          ]));
  if (syllabusData["keyword"] == "") {
    return searchlist;
  }
  final r = fuse.search(syllabusData["keyword"]);
  final result = r.map((e) => e.item).toList();
  // if (result == null) {
  //   return [];
  // }
  return result;
}
