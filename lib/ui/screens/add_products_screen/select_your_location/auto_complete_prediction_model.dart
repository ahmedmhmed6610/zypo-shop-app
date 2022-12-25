//
// import 'package:google_maps_webservice/places.dart';
//
// class AutocompletePrediction {
//
//   String? description;
//   String? placeId;
//   String? reference;
//   StructuredFormatting? structuredFormatting;
//
//   AutocompletePrediction({this.description,this.structuredFormatting,this.placeId,this.reference});
//
//   factory AutocompletePrediction.fromJson(Map<String,dynamic> json){
//     return AutocompletePrediction(
//       description: json['description'] as String? ,
//       placeId:  json['place_Id'] as String?,
//       reference:  json['reference'] as String?,
//       structuredFormatting: json['structured_formatting'] != null ?
//       StructuredFormatting.fromjson(json['structured_formatting']) : null
//     );
//   }
//
// }
//
// class StructuredFormatting {
//   final String? mainText;
//   final String? secondaryText;
//
//   StructuredFormatting({
//     required this.mainText,
//     this.secondaryText,
//   });
//
//   factory StructuredFormatting.fromjson(Map<String,dynamic> json){
//     return StructuredFormatting(
//       mainText:  json['mainT_text'] as String?,
//       secondaryText:  json['secondary_text'] as String?,
//     );
//   }
// }