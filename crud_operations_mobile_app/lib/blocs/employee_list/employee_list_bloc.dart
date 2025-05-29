import 'package:crud_operations_mobile_app/models/api_response.dart';
import 'package:crud_operations_mobile_app/models/employee.dart';
import 'package:crud_operations_mobile_app/repositories/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_list_event.dart';
import 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final employeeRepo = EmployeeRepository();
  List<Employee> employees = [];

  EmployeeListBloc() : super(EmployeeListInitialState()) {
    on<EmployeeListLoadedEvent>((event, emit) async {
      // Getting all the employee items
      await onLoad();
      emit(EmployeeListLoadedState(employees));
    });

    on<DeleteEmployeeEvent>((event, emit) async {
      // deleting employee using id
      await deleteEmployee(event.employee.id ?? 0);
      emit(DeleteEmployeeState(event.employee));
    });
    on<EmployeeListErrorEvent>((event, emit) async {
      // triggers in case of errors
      emit(EmployeeListErrorState(event.message));
    });
  }

  // deletes employee
  Future<void> deleteEmployee(int employeeId) async {
    try {
      var res = await employeeRepo.deleteEmployee(employeeId);
      if (res.statusCode == 200) {
        employees.removeWhere((e) => e.id == employeeId);
        add(EmployeeListLoadedEvent());
      } else {
        add(
          EmployeeListErrorEvent(
            'Failed to delete employee: ${res.errorMessage}',
          ),
        );
      }
    } catch (e) {
      add(EmployeeListErrorEvent('Failed to delete employee: $e'));
    }
  }

  // fetches employee items
  Future<void> onLoad() async {
    try {
      ApiResponse<List<Employee>> response = await employeeRepo
          .getAllEmployees();

      if (response.statusCode == 200 && response.data != null) {
        employees = response.data ?? [];
      } else {
        add(
          EmployeeListErrorEvent(
            'Failed to load employees: ${response.errorMessage}',
          ),
        );
      }

      add(EmployeeListLoadedEvent());
    } catch (e) {
      add(EmployeeListErrorEvent('Failed to load employees: $e'));
    }
  }

  // refreshes when list is pulled down
  void onRefresh(Emitter<EmployeeListState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(EmployeeListLoadedState(employees));
  }
}
