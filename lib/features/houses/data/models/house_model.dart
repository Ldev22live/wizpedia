// data/models/house_model.dart

import 'package:wizpedia/features/houses/domain/entities/house.dart';

class HouseModel extends House {
  HouseModel({
    required String id,
    required String name,
    required String houseColours,
    required String founder,
    required String animal,
    required String element,
    required String ghost,
    required String commonRoom,
    required List<HouseHeadModel> heads,
    required List<HouseTraitModel> traits,
  }) : super(
          id: id,
          name: name,
          houseColours: houseColours,
          founder: founder,
          animal: animal,
          element: element,
          ghost: ghost,
          commonRoom: commonRoom,
          heads: heads,
          traits: traits,
        );

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      name: json['name'],
      houseColours: json['houseColours'],
      founder: json['founder'],
      animal: json['animal'],
      element: json['element'],
      ghost: json['ghost'],
      commonRoom: json['commonRoom'],
      heads: (json['heads'] as List)
          .map((head) => HouseHeadModel.fromJson(head))
          .toList(),
      traits: (json['traits'] as List)
          .map((trait) => HouseTraitModel.fromJson(trait))
          .toList(),
    );
  }
}

class HouseHeadModel extends HouseHead {
  HouseHeadModel({
    required String id,
    required String firstName,
    required String lastName,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
        );

  factory HouseHeadModel.fromJson(Map<String, dynamic> json) {
    return HouseHeadModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class HouseTraitModel extends HouseTrait {
  HouseTraitModel({
    required String id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory HouseTraitModel.fromJson(Map<String, dynamic> json) {
    return HouseTraitModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
