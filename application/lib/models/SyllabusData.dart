class SyllabusModel {
  final String id;
  final String iconUrl;
  final String screenName;
  final String name;
  final String description;

  SyllabusModel(
      {required this.id,
      required this.iconUrl,
      required this.screenName,
      required this.name,
      required this.description});

  factory SyllabusModel.fromJson(List<dynamic> json) {
    // print(json);
    return SyllabusModel(
        id: "json['id']",
        iconUrl: "json['profile_image_url']",
        screenName: "json['screen_name']",
        name: "json['name']",
        description: "json['description']");
  }
}

class SyllabusResponse {
  final List<SyllabusModel> syllabus;

  SyllabusResponse({required this.syllabus});

  factory SyllabusResponse.fromJson(List<dynamic> json) {
    List<SyllabusModel> data =
        json.map((item) => SyllabusModel.fromJson(item)).toList();
    return SyllabusResponse(syllabus: data);
  }
}
