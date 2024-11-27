class Character {

  final String firstName;
  final String lastName;
  final String fullName;
  final String title;
  final String family;
  final String image;

  Character({
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.family,
    required this.image
  })
      : fullName = "$firstName $lastName";

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(

      firstName: json["firstName"],
      lastName: json["lastName"],
      title: json["title"],
      family: json["family"],
      image: json["imageUrl"]

    );
  }
}
