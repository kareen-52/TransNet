class PartyEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userNumber;

  const PartyEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.userNumber,
  });

  String get fullName => '$firstName $lastName';
}
