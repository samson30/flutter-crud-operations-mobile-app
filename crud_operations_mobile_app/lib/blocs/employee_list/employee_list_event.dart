import 'package:crud_operations_mobile_app/models/employee.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeListEvent extends Equatable {
  const EmployeeListEvent();
}

class EmployeeListLoadedEvent extends EmployeeListEvent {
  @override
  List<Object> get props => [];
}

class DeleteEmployeeEvent extends EmployeeListEvent {
  final Employee employee;
  const DeleteEmployeeEvent(this.employee);

  @override
  List<Object> get props => [employee];
}

class EmployeeListErrorEvent extends EmployeeListEvent {
  final String message;
  const EmployeeListErrorEvent(this.message);

  @override
  List<Object> get props => [message];
}
