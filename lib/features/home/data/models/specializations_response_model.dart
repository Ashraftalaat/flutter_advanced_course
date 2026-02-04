import 'package:json_annotation/json_annotation.dart';

part 'specializations_response_model.g.dart';
//data شاملة لكل التخصصات 
@JsonSerializable()
class SpecializationsResponseModel {
  @JsonKey(name: 'data')
  //specializationDataList = data الموجودة في  api response
  // مثل   List data = [];
  List<SpecializationsData?>? specializationDataList;

  SpecializationsResponseModel({
    this.specializationDataList,
  });

  factory SpecializationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SpecializationsResponseModelFromJson(json);
}

//SpecializationsData الداتا الخاصة بكل تخصص علي حده
@JsonSerializable()
class SpecializationsData {
  int? id;
  String? name;
  @JsonKey(name: 'doctors')
  List<Doctors?>? doctorsList;

  SpecializationsData({
    this.id,
    this.name,
    this.doctorsList,
  });

  factory SpecializationsData.fromJson(Map<String, dynamic> json) =>
      _$SpecializationsDataFromJson(json);
}

//Doctors الداتا الخاصة بكل دكتور علي حده
@JsonSerializable()
class Doctors {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? gender;
  @JsonKey(name: 'appoint_price')
  int? price;
  String degree;

  Doctors({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.gender,
    this.price,
    required this.degree,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) =>
      _$DoctorsFromJson(json);
}