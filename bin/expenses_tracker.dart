import 'dart:io';

void main() {
  ExpenseTracker tracker = ExpenseTracker();
  tracker.run();
}

// Class to represent each expense entry
class Expense {
  String description;
  double amount;
  DateTime date;

  Expense(this.description, this.amount, this.date);

  @override
  String toString() {
    return 'Description: $description, Amount: \$${amount.toStringAsFixed(2)}, Date: ${date.toLocal()}';
  }
}

// Class to manage the expenses
class ExpenseTracker {
  List<Expense> expenses = [];

  // Main method to run the app
  void run() {
    bool continueApp = true;

    while (continueApp) {
      print('--- Expense Tracker ---');
      print('1. Add Expense');
      print('2. View Expenses');
      print('3. View Total Expenses');
      print('4. Delete Expense');
      print('5. Exit');
      stdout.write('Choose an option: ');

      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          addExpense();
          break;
        case '2':
          viewExpenses();
          break;
        case '3':
          viewTotalExpenses();
          break;
        case '4':
          deleteExpense();
          break;
        case '5':
          continueApp = false;
          print('Exiting the Expense Tracker...');
          break;
        default:
          print('Invalid choice, please try again.');
      }
    }
  }

  // Method to add a new expense
  void addExpense() {
    stdout.write('Enter expense description: ');
    String? description = stdin.readLineSync();

    stdout.write('Enter expense amount: ');
    double? amount = double.tryParse(stdin.readLineSync() ?? '');

    if (description != null && amount != null && amount > 0) {
      Expense newExpense = Expense(description, amount, DateTime.now());
      expenses.add(newExpense);
      print('Expense added successfully!\n');
    } else {
      print('Invalid input. Expense not added.\n');
    }
  }

  // Method to view all expenses
  void viewExpenses() {
    if (expenses.isEmpty) {
      print('No expenses to show.\n');
    } else {
      print('--- Your Expenses ---');
      for (var i = 0; i < expenses.length; i++) {
        print('${i + 1}. ${expenses[i]}');
      }
      print('');
    }
  }

  // Method to calculate and view total expenses
  void viewTotalExpenses() {
    double total = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
    print('Total Expenses: \$${total.toStringAsFixed(2)}\n');
  }

  // Method to delete an expense entry by index
  void deleteExpense() {
    if (expenses.isEmpty) {
      print('No expenses to delete.\n');
      return;
    }

    viewExpenses();
    stdout.write('Enter the number of the expense to delete: ');
    int? index = int.tryParse(stdin.readLineSync() ?? '');

    if (index != null && index > 0 && index <= expenses.length) {
      expenses.removeAt(index - 1);
      print('Expense deleted successfully!\n');
    } else {
      print('Invalid choice. No expense deleted.\n');
    }
  }
}
