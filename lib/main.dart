
import 'dart:io';

class Employee {
  String id;
  String fullName;
  DateTime birthday;
  String address;
  String phoneNumber;

  Employee({
    required this.id,
    required this.fullName,
    required this.birthday,
    required this.address,
    required this.phoneNumber,
  });

  @override
  String toString() {
    return 'Employee{ID: $id, Name: $fullName, Birthday: ${birthday.day}/${birthday.month}/${birthday.year}, Address: $address, Phone: $phoneNumber}';
  }

  static Employee fromInput() {
    print('Enter Employee Details:');

    stdout.write('ID: ');
    String id = stdin.readLineSync() ?? '';

    stdout.write('Full Name: ');
    String fullName = stdin.readLineSync() ?? '';

    stdout.write('Birthday (DD/MM/YYYY): ');
    String birthdayInput = stdin.readLineSync() ?? '';
    DateTime birthday = _parseBirthday(birthdayInput);

    stdout.write('Address: ');
    String address = stdin.readLineSync() ?? '';

    stdout.write('Phone Number: ');
    String phoneNumber = stdin.readLineSync() ?? '';

    return Employee(
      id: id,
      fullName: fullName,
      birthday: birthday,
      address: address,
      phoneNumber: phoneNumber,
    );
  }

  static DateTime _parseBirthday(String birthdayStr) {
    try {
      List<String> parts = birthdayStr.split('/');
      if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      print('Invalid date format. Using current date.');
    }
    return DateTime.now();
  }
}

class EmployeeManagementSystem {
  List<Employee> _employees = [];

  void addNewEmployee(Employee employee) {
    bool idExists = _employees.any((emp) => emp.id == employee.id);

    if (idExists) {
      print('Error: Employee with ID ${employee.id} already exists!');
      return;
    }

    _employees.add(employee);
    print('Employee ${employee.fullName} added successfully!');
  }

  List<Employee> getAllEmployee() {
    return List.from(_employees);
  }

  void updateEmployee(String employeeId) {
    int index = _employees.indexWhere((emp) => emp.id == employeeId);

    if (index == -1) {
      print('Error: Employee with ID $employeeId not found!');
      return;
    }

    Employee currentEmployee = _employees[index];
    print('Current Employee Information:');
    print(currentEmployee);
    print('\nEnter new information (press Enter to keep current value):');

    stdout.write('Full Name [${currentEmployee.fullName}]: ');
    String? newFullName = stdin.readLineSync();
    if (newFullName != null && newFullName.isNotEmpty) {
      currentEmployee.fullName = newFullName;
    }

    stdout.write('Birthday (DD/MM/YYYY) [${currentEmployee.birthday.day}/${currentEmployee.birthday.month}/${currentEmployee.birthday.year}]: ');
    String? newBirthdayStr = stdin.readLineSync();
    if (newBirthdayStr != null && newBirthdayStr.isNotEmpty) {
      currentEmployee.birthday = Employee._parseBirthday(newBirthdayStr);
    }

    stdout.write('Address [${currentEmployee.address}]: ');
    String? newAddress = stdin.readLineSync();
    if (newAddress != null && newAddress.isNotEmpty) {
      currentEmployee.address = newAddress;
    }

    stdout.write('Phone Number [${currentEmployee.phoneNumber}]: ');
    String? newPhoneNumber = stdin.readLineSync();
    if (newPhoneNumber != null && newPhoneNumber.isNotEmpty) {
      currentEmployee.phoneNumber = newPhoneNumber;
    }

    print('Employee information updated successfully!');
  }

  void showAllEmployee() {
    if (_employees.isEmpty) {
      print('No employees found in the system.');
      return;
    }

    print('\n=== All Employees in TASC Company ===');
    print('Total Employees: ${_employees.length}');
    print('-' * 60);

    for (int i = 0; i < _employees.length; i++) {
      print('${i + 1}. ${_employees[i]}');
    }
    print('-' * 60);
  }

  int getEmployeeCount() {
    return _employees.length;
  }

  Employee? findEmployeeById(String id) {
    try {
      return _employees.firstWhere((emp) => emp.id == id);
    } catch (e) {
      return null;
    }
  }
}

void main() {
  EmployeeManagementSystem ems = EmployeeManagementSystem();

  print('Welcome to TASC Employee Management System');
  print('==========================================');

  while (true) {
    print('\nSelect an option:');
    print('1. Add New Employee');
    print('2. Show All Employees');
    print('3. Update Employee');
    print('4. Get Employee Count');
    print('5. Find Employee by ID');
    print('6. Exit');
    stdout.write('Choice: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        Employee newEmployee = Employee.fromInput();
        ems.addNewEmployee(newEmployee);
        break;

      case '2':
        ems.showAllEmployee();
        break;

      case '3':
        stdout.write('Enter Employee ID to update: ');
        String? updateId = stdin.readLineSync();
        if (updateId != null && updateId.isNotEmpty) {
          ems.updateEmployee(updateId);
        }
        break;

      case '4':
        print('Total employees: ${ems.getEmployeeCount()}');
        break;

      case '5':
        stdout.write('Enter Employee ID: ');
        String? searchId = stdin.readLineSync();
        if (searchId != null && searchId.isNotEmpty) {
          Employee? found = ems.findEmployeeById(searchId);
          if (found != null) {
            print('Employee found: $found');
          } else {
            print('Employee with ID $searchId not found.');
          }
        }
        break;

      case '6':
        print('Thank you for using Employee Management System!');
        return;

      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void demonstrateSystem() {
  print('\n=== System Demonstration ===');

  EmployeeManagementSystem ems = EmployeeManagementSystem();

  // Create sample employees
  Employee emp1 = Employee(
    id: 'EMP001',
    fullName: 'Hieu Le',
    birthday: DateTime(1990, 5, 15),
    address: '123 Dao, Han',
    phoneNumber: '+1234567890',
  );

  Employee emp2 = Employee(
    id: 'EMP002',
    fullName: 'Lam Nguyen',
    birthday: DateTime(2003, 8, 22),
    address: '456 Lang, Han',
    phoneNumber: '+0987654321',
  );

  // Add employees
  ems.addNewEmployee(emp1);
  ems.addNewEmployee(emp2);

  // Show all employees
  ems.showAllEmployee();

  // Get all employees (demonstrate getAllEmployee function)
  List<Employee> allEmployees = ems.getAllEmployee();
  print('\nUsing getAllEmployee(): Found ${allEmployees.length} employees');
}