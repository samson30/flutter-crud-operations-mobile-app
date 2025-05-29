import 'package:crud_operations_mobile_app/enums/employee_role.dart';
import 'package:crud_operations_mobile_app/models/employee.dart';
import 'package:equatable/equatable.dart';

abstract class EnrollEmployeeState extends Equatable {
  // I have used this code below because when same event is called again and again the blocbuilder would not rebuild. so by adding this code it fixes that issue.
  @override
  bool operator ==(Object other) => false;
  const EnrollEmployeeState();

  @override
  List<Object?> get props => [];
}

class EnrollInitialState extends EnrollEmployeeState {}

class EnrollSubmittingState extends EnrollEmployeeState {}

class EnrollSuccessState extends EnrollEmployeeState {}

class EnrollFailureState extends EnrollEmployeeState {
  final String error;

  const EnrollFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateSuccessState extends EnrollEmployeeState {}

class UpdateFailureState extends EnrollEmployeeState {
  final String error;

  const UpdateFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class EnrollEmployeeLoadState extends EnrollEmployeeState {
  final Employee? currentEmployee;

  const EnrollEmployeeLoadState(this.currentEmployee);

  @override
  List<Object?> get props => [];
}

class EnrollEmployeeLoadingState extends EnrollEmployeeState {
  const EnrollEmployeeLoadingState();

  @override
  List<Object?> get props => [];
}

class EnrollEmployeeLoadedState extends EnrollEmployeeState {
  const EnrollEmployeeLoadedState();

  @override
  List<Object?> get props => [];
}

class EnrollFormState extends EnrollEmployeeState {
  // NEW
  final EmployeeRole? role;
  final String? dob;

  const EnrollFormState({this.role, this.dob});

  @override
  List<Object?> get props => [role, dob];
}

class UpdateEmployeeDetailsForEditPageState extends EnrollEmployeeState {
  // NEW
  final Employee currentEmployee;

  const UpdateEmployeeDetailsForEditPageState({required this.currentEmployee});
}
