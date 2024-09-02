class Medication {
  int? id; // Ensure that id is of type int
  final String name;
  final String dosage;
  final DateTime time;
  final String instructions;

  Medication({
    this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.instructions,
  });

  // Assuming you have a fromJson method to create a Medication object from a map.
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
      dosage: json['dosage'],
      time: DateTime.parse(json['time']),
      instructions: json['instructions'],
    );
  }

  // Method to convert Medication object to map for database storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'time': time.toIso8601String(),
      'instructions': instructions,
    };
  }
}
