import 'package:crud_operations_mobile_app/models/employee.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeListState extends Equatable {
  const EmployeeListState();

  @override
  List<Object> get props => [];
}

class EmployeeListInitialState extends EmployeeListState {}

class EmployeeListLoadingState extends EmployeeListState {}

class EmployeeListLoadedState extends EmployeeListState {
  final List<Employee> employees;
  const EmployeeListLoadedState(this.employees);

  @override
  List<Object> get props => [employees];
}

class EmployeeListErrorState extends EmployeeListState {
  final String message;
  const EmployeeListErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteEmployeeState extends EmployeeListState {
  final Employee employee;
  const DeleteEmployeeState(this.employee);

  @override
  List<Object> get props => [employee];
}
