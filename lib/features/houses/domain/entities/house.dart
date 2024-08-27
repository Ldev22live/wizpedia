class House {
  final String id;
  final String name;
  final String houseColours;
  final String founder;
  final String animal;
  final String element;
  final String ghost;
  final String commonRoom;
  final List<HouseHead> heads;
  final List<HouseTrait> traits;

  House({
    required this.id,
    required this.name,
    required this.houseColours,
    required this.founder,
    required this.animal,
    required this.element,
    required this.ghost,
    required this.commonRoom,
    required this.heads,
    required this.traits,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    var headsList = json['heads'] as List;
    List<HouseHead> heads =
        headsList.map((i) => HouseHead.fromJson(i)).toList();

    var traitsList = json['traits'] as List;
    List<HouseTrait> traits =
        traitsList.map((i) => HouseTrait.fromJson(i)).toList();

    return House(
      id: json['id'],
      name: json['name'],
      houseColours: json['houseColours'],
      founder: json['founder'],
      animal: json['animal'],
      element: json['element'],
      ghost: json['ghost'],
      commonRoom: json['commonRoom'],
      heads: heads,
      traits: traits,
    );
  }
}

class HouseHead {
  final String id;
  final String firstName;
  final String lastName;

  HouseHead({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  // Factory method to create a HouseHead from JSON
  factory HouseHead.fromJson(Map<String, dynamic> json) {
    return HouseHead(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class HouseTrait {
  final String id;
  final String name;

  HouseTrait({
    required this.id,
    required this.name,
  });

  // Factory method to create a HouseTrait from JSON
  factory HouseTrait.fromJson(Map<String, dynamic> json) {
    return HouseTrait(
      id: json['id'],
      name: json['name'],
    );
  }
}
