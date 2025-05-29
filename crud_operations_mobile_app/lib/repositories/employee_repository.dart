import '../database/employee_database_helper.dart';
import '../models/api_response.dart';
import '../models/employee.dart';

// I have created this to make the api calls to like used in real time applications. we can also directly call the api methods from the database.
class EmployeeRepository {
  final db = EmployeeDatabaseHelper();

  // GET ALL EMPLOYEES
  Future<ApiResponse<List<Employee>>> getAllEmployees() async {
    try {
      final employees = await db.getEmployees();
      return ApiResponse.success(employees);
    } catch (e) {
      return ApiResponse.error('Failed to fetch employees: $e');
    }
  }

  // GET EMPLOYEE BY ID
  Future<ApiResponse<Employee>> getEmployeeById(int id) async {
    try {
      final employees = await db.getEmployees();
      final emp = employees.any((e) => e.id == id)
          ? employees.firstWhere((e) => e.id == id)
          : null;
      if (emp?.id != null) {
        return ApiResponse.success(emp);
      } else {
        return ApiResponse.error('Employee not found');
      }
    } catch (e) {
      return ApiResponse.error('Error retrieving employee: $e');
    }
  }

  // CREATE EMPLOYEE
  Future<ApiResponse<void>> addEmployee(Employee emp) async {
    try {
      await db.insertEmployee(emp);
      return ApiResponse.success(null);
    } catch (e) {
      return ApiResponse.error('Failed to insert: $e');
    }
  }

  // UPDATE EMPLOYEE
  Future<ApiResponse<void>> updateEmployee(Employee emp) async {
    try {
      final rows = await db.updateEmployee(emp);
      if (rows > 0) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Employee not found for update');
      }
    } catch (e) {
      return ApiResponse.error('Update failed: $e');
    }
  }

  // DELETE EMPLOYEE BY ID
  Future<ApiResponse<void>> deleteEmployee(int id) async {
    try {
      final rows = await db.deleteEmployee(id);
      if (rows > 0) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error('Employee not found for deletion');
      }
    } catch (e) {
      return ApiResponse.error('Deletion failed: $e');
    }
  }
}
