class Player {
  final String firstName;
  final String lastName;

  Player({required this.firstName, required this.lastName});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
