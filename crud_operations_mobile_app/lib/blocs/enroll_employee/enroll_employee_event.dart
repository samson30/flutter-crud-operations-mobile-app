import 'package:crud_operations_mobile_app/enums/employee_role.dart';
import 'package:equatable/equatable.dart';

abstract class EnrollEmployeeEvent extends Equatable {
  const EnrollEmployeeEvent();

  @override
  List<Object?> get props => [];
}

class SubmitEmployeeEvent extends EnrollEmployeeEvent {
  final String firstName;
  final String lastName;
  final String dob;
  final EmployeeRole role;
  final String roleDescription;
  final String email;
  final String phone;

  const SubmitEmployeeEvent({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.role,
    required this.roleDescription,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    dob,
    role,
    roleDescription,
    email,
    phone,
  ];
}

class EnrollEmployeeLoadingEvent extends EnrollEmployeeEvent {}

class EnrollSubmittingEvent extends EnrollEmployeeEvent {}

class EnrollSuccessEvent extends EnrollEmployeeEvent {}

class EnrollFailureEvent extends EnrollEmployeeEvent {
  final String error;

  const EnrollFailureEvent(this.error);

  @override
  List<Object?> get props => [error];
}

class EnrollEmployeeLoadEvent extends EnrollEmployeeEvent {
  final int? employeeId;

  const EnrollEmployeeLoadEvent({this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class EnrollEmployeeLoadedEvent extends EnrollEmployeeEvent {
  final int? employeeId;

  const EnrollEmployeeLoadedEvent({this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

class UpdateRoleEvent extends EnrollEmployeeEvent {
  final EmployeeRole role;
  const UpdateRoleEvent(this.role);
}

class UpdateDobEvent extends EnrollEmployeeEvent {
  final String dob;
  const UpdateDobEvent(this.dob);
}

class UpdateSuccessEvent extends EnrollEmployeeEvent {}

class UpdateFailureEvent extends EnrollEmployeeEvent {
  final String error;

  const UpdateFailureEvent(this.error);

  @override
  List<Object?> get props => [error];
}
