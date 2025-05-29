import 'package:crud_operations_mobile_app/enums/employee_role.dart';

// This is the model used for each Employee
class Employee {
  final int? id;
  final String firstName;
  final String lastName;
  final EmployeeRole role;
  final String roleDescription;
  final String dob;
  final String? phone;
  final String? email;

  Employee({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.roleDescription,
    required this.dob,
    required this.phone,
    required this.email,
  });

  // I have used this to change the format like json when posting or putting in database
  Map<String, dynamic> toMap() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'role': role.name,
    'roleDescription': roleDescription,
    'dob': dob,
    'phone': phone ?? "",
    'email': email ?? "",
  };

  // I have used to get the data from database like converting from json to dart format.
  factory Employee.fromMap(Map<String, dynamic> map) => Employee(
    id: map['id'],
    firstName: map['firstName'],
    lastName: map['lastName'],
    role: EmployeeRole.values.firstWhere((e) => e.name == map['role']),
    roleDescription: map['roleDescription'] ?? "",
    dob: map['dob'],
    phone: map['phone'] ?? "",
    email: map['email'],
  );
}
