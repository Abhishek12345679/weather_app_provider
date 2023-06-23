// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchedPlaceResponse {
  final List<SearchedPlace> predictions;

  SearchedPlaceResponse({
    required this.predictions,
  });

  factory SearchedPlaceResponse.fromJson(Map<String, dynamic> json) =>
      SearchedPlaceResponse(
        predictions: List<SearchedPlace>.from(
            json["predictions"].map((x) => SearchedPlace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "predictions": List<dynamic>.from(predictions.map((x) => x.toJson())),
      };
}

class SearchedPlace {
  final String description;
  final String placeId;
  final StructuredFormatting structuredFormatting;

  SearchedPlace({
    required this.description,
    required this.placeId,
    required this.structuredFormatting,
  });

  factory SearchedPlace.fromJson(Map<String, dynamic> json) => SearchedPlace(
        description: json["description"],
        placeId: json["place_id"],
        structuredFormatting:
            StructuredFormatting.fromJson(json["structured_formatting"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "place_id": placeId,
        "structured_formatting": structuredFormatting.toJson(),
      };
}

class MatchedSubstring {
  final int length;
  final int offset;

  MatchedSubstring({
    required this.length,
    required this.offset,
  });

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      MatchedSubstring(
        length: json["length"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "offset": offset,
      };
}

class StructuredFormatting {
  final String mainText;
  final List<MatchedSubstring> mainTextMatchedSubstrings;
  final String secondaryText;

  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      StructuredFormatting(
        mainText: json["main_text"],
        mainTextMatchedSubstrings: List<MatchedSubstring>.from(
            json["main_text_matched_substrings"]
                .map((x) => MatchedSubstring.fromJson(x))),
        secondaryText: json["secondary_text"],
      );

  Map<String, dynamic> toJson() => {
        "main_text": mainText,
        "main_text_matched_substrings": List<dynamic>.from(
            mainTextMatchedSubstrings.map((x) => x.toJson())),
        "secondary_text": secondaryText,
      };
}
