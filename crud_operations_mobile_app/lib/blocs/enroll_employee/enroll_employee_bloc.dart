import 'package:bloc/bloc.dart';
import 'enroll_employee_event.dart';
import 'enroll_employee_state.dart';
import '../../../repositories/employee_repository.dart';
import '../../../models/employee.dart';

class EnrollEmployeeBloc
    extends Bloc<EnrollEmployeeEvent, EnrollEmployeeState> {
  final employeeRepo = EmployeeRepository();
  // this parameter is initialized to make use of it in edit page
  Employee? currentEmployee;
  EnrollEmployeeBloc() : super(EnrollInitialState()) {
    on<EnrollEmployeeLoadEvent>((event, emit) async {
      if (event.employeeId != null) {
        // getting employee details if it is edit page and binding those results to the textformfields
        await fetchEmployeeDetails(event.employeeId ?? 0);
      }
      emit(EnrollEmployeeLoadState(currentEmployee));
    });
    on<SubmitEmployeeEvent>((event, emit) async {
      add(EnrollSubmittingEvent());
      if (currentEmployee !=
          null) // we are checking this condition because we have employee details stored in this variable while opening the edit page
      {
        onUpdateEmployee(event);
      } else {
        await _onSubmitEmployee(event);
      }
    });
    on<EnrollSubmittingEvent>((event, emit) async {
      emit(EnrollInitialState());
    });

    on<EnrollEmployeeLoadedEvent>((event, emit) async {
      emit(EnrollEmployeeLoadedState());
    });

    on<EnrollSuccessEvent>((event, emit) async {
      emit(EnrollSuccessState());
    });

    on<UpdateSuccessEvent>((event, emit) async {
      emit(UpdateSuccessState());
    });

    on<EnrollEmployeeLoadingEvent>((event, emit) async {
      emit(EnrollEmployeeLoadingState());
    });

    on<EnrollFailureEvent>((event, emit) async {
      emit(EnrollFailureState(event.error));
    });
    on<UpdateFailureEvent>((event, emit) async {
      emit(UpdateFailureState(event.error));
    });

    on<UpdateRoleEvent>((event, emit) {
      if (state is EnrollFormState) {
        final current = state as EnrollFormState;
        emit(EnrollFormState(role: event.role, dob: current.dob));
      }
    });

    on<UpdateDobEvent>((event, emit) {
      if (state is EnrollFormState) {
        final current = state as EnrollFormState;
        emit(EnrollFormState(role: current.role, dob: event.dob));
      }
    });
  }

  // gets employee details
  fetchEmployeeDetails(int employeeId) async {
    try {
      add(EnrollEmployeeLoadingEvent());
      final response = await employeeRepo.getEmployeeById(employeeId);
      if (response.statusCode == 200 && response.data != null) {
        currentEmployee = response.data;
      } else {
        add(EnrollFailureEvent('Failed to load employee details'));
      }
    } catch (e) {
      add(EnrollFailureEvent('Unexpected error: $e'));
    }
  }

  // submitting the details for creating an employee
  Future<void> _onSubmitEmployee(event) async {
    try {
      final newEmployee = Employee(
        dob: event.dob,
        firstName: event.firstName,
        lastName: event.lastName,
        role: event.role,
        roleDescription: event.roleDescription,
        email: event.email,
        phone: event.phone,
      );

      final response = await employeeRepo.addEmployee(newEmployee);
      if (response.statusCode == 200) {
        add(EnrollSuccessEvent());
      } else {
        add(EnrollFailureEvent(response.errorMessage ?? 'Unknown error'));
      }
    } catch (e) {
      add(EnrollFailureEvent('Failed to create employee: $e'));
    }
  }

  // submitting the details after modifications are made
  Future<void> onUpdateEmployee(event) async {
    try {
      final newEmployee = Employee(
        id: currentEmployee?.id,
        dob: event.dob,
        firstName: event.firstName,
        lastName: event.lastName,
        role: event.role,
        roleDescription: event.roleDescription,
        phone: event.phone,
        email: event.email,
      );

      final response = await employeeRepo.updateEmployee(newEmployee);
      if (response.statusCode == 200) {
        add(UpdateSuccessEvent());
      } else {
        add(EnrollFailureEvent(response.errorMessage ?? 'Unknown error'));
      }
    } catch (e) {
      add(EnrollFailureEvent('Failed to Update employee: $e'));
    }
  }
}
