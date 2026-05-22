/// Pure domain entity representing a party involved in a shipment
/// (either a driver or a client). No serialization dependencies.
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

  /// Full display name composed from first and last name.
  String get fullName => '$firstName $lastName';
}
