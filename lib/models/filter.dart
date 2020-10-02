import 'dart:convert';

List<Filter> filterFromJson(String str) => List<Filter>.from(json.decode(str).map((x) => Filter.fromJson(x)));

String filterToJson(Filter data) => json.encode(data.toJson());

class Filter {
    Filter({
        this.id,
        this.startYear,
        this.endYear,
        this.gender,
        this.countries,
        this.colors,
    });

    int id;
    int startYear;
    int endYear;
    String gender;
    List<String> countries;
    List<String> colors;

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        id: json["id"],
        startYear: json["start_year"],
        endYear: json["end_year"],
        gender: json["gender"],
        countries: List<String>.from(json["countries"].map((x) => x)),
        colors: List<String>.from(json["colors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "start_year": startYear,
        "end_year": endYear,
        "gender": gender,
        "countries": List<dynamic>.from(countries.map((x) => x)),
        "colors": List<dynamic>.from(colors.map((x) => x)),
    };
}
