import 'package:flutter/material.dart';

void main() {
  runApp(const SpendMateApp());
}

// Application Colors
const Color primaryColor = Color(0xFF5145A5);
const Color backgroundColor = Color(0xFFF4F5FB);

// Main Application
class SpendMateApp extends StatelessWidget {
  const SpendMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpendMate',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Expense Model
class Expense {
  final String name;
  final String category;
  final double amount;
  final String description;
  final IconData icon;
  final Color color;

  const Expense({
    required this.name,
    required this.category,
    required this.amount,
    required this.description,
    required this.icon,
    required this.color,
  });
}

// SCREEN 01 - HOME SCREEN

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Predefined Expense Items
  final List<Expense> sampleExpenses = const [
    Expense(
      name: 'Bus Fare',
      category: 'Transport',
      amount: 150,
      description: 'Daily travelling expenses to university.',
      icon: Icons.directions_bus,
      color: Colors.blue,
    ),
    Expense(
      name: 'Notebook',
      category: 'Stationery',
      amount: 250,
      description: 'Notebook for lectures and study activities.',
      icon: Icons.menu_book,
      color: Colors.purple,
    ),
    Expense(
      name: 'Lunch',
      category: 'Food',
      amount: 500,
      description: 'Daily lunch expense.',
      icon: Icons.restaurant,
      color: Colors.orange,
    ),
    Expense(
      name: 'Tea',
      category: 'Beverages',
      amount: 100,
      description: 'Tea during university breaks.',
      icon: Icons.local_cafe,
      color: Colors.green,
    ),
    Expense(
      name: 'Printing',
      category: 'Education',
      amount: 200,
      description: 'Printing lecture notes and assignments.',
      icon: Icons.print,
      color: Colors.teal,
    ),
  ];

  // Recorded Expenses
  final List<Expense> recordedExpenses = [];

  // Calculate Total
  double get totalAmount {
    double total = 0;

    for (Expense expense in recordedExpenses) {
      total += expense.amount;
    }

    return total;
  }

  // Navigate to Expense Details
  Future<void> openDetails(Expense expense) async {
    final Expense? result = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailsScreen(expense: expense),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        recordedExpenses.add(result);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${result.name} added successfully!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Navigate to Summary Screen
  Future<void> openSummary() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(expenses: recordedExpenses),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_balance_wallet),
            SizedBox(width: 8),
            Text('SpendMate'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello, Student!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const Text(
                'Track your daily spending easily.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 18),

              // Total Spending Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Total Spending',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Rs. ${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      '${recordedExpenses.length} recorded expenses',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Quick Expenses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 4),

              const Text(
                'Select an expense to view its details.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),

              const SizedBox(height: 12),

              // Sample Expense List
              Expanded(
                child: ListView.builder(
                  itemCount: sampleExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = sampleExpenses[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: expense.color.withAlpha(30),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(expense.icon, color: expense.color),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  expense.category,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  expense.name,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  'Rs. ${expense.amount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          TextButton(
                            onPressed: () {
                              openDetails(expense);
                            },
                            child: const Text('Details'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: openSummary,
                  icon: const Icon(Icons.bar_chart),
                  label: const Text('View Summary'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// SCREEN 02 - EXPENSE DETAILS

class ExpenseDetailsScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailsScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Details')),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Expense Information Card
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: expense.color.withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(expense.icon, size: 45, color: expense.color),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      expense.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Rs. ${expense.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Detailed Information
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Expense Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    informationRow('Expense Name', expense.name),

                    const Divider(height: 25),

                    informationRow('Category', expense.category),

                    const Divider(height: 25),

                    informationRow(
                      'Amount',
                      'Rs. ${expense.amount.toStringAsFixed(2)}',
                    ),

                    const Divider(height: 25),

                    const Text(
                      'Description',
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      expense.description,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Add Expense Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, expense);
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Add Expense'),
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget informationRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),

        const SizedBox(width: 12),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

// SCREEN 03 - EXPENSE SUMMARY

class SummaryScreen extends StatefulWidget {
  final List<Expense> expenses;

  const SummaryScreen({super.key, required this.expenses});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  // Calculate Total Amount
  double get totalAmount {
    double total = 0;

    for (Expense expense in widget.expenses) {
      total += expense.amount;
    }

    return total;
  }

  // Calculate Category-wise Spending
  Map<String, double> get categoryTotals {
    Map<String, double> totals = {};

    for (Expense expense in widget.expenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0) + expense.amount;
    }

    return totals;
  }

  // Remove an Expense
  void removeExpense(int index) {
    final String expenseName = widget.expenses[index].name;

    setState(() {
      widget.expenses.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$expenseName removed successfully!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Summary')),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    // Total Amount Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white,
                            size: 32,
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            'Total Amount Spent',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Rs. ${totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            '${widget.expenses.length} recorded expenses',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Spending Breakdown
                    if (widget.expenses.isNotEmpty) ...[
                      const Text(
                        'Spending Breakdown',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: categoryTotals.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(entry.key),
                                      Text(
                                        'Rs. ${entry.value.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  LinearProgressIndicator(
                                    value: totalAmount == 0
                                        ? 0.0
                                        : entry.value / totalAmount,
                                    minHeight: 7,
                                    color: primaryColor,
                                    backgroundColor: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],

                    const Text(
                      'Recorded Expenses',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Empty State
                    if (widget.expenses.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(35),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 60,
                              color: Colors.grey,
                            ),

                            SizedBox(height: 12),

                            Text(
                              'No expenses recorded',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              'Add an expense from the Home screen.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    else
                      // Recorded Expense List
                      ...List.generate(widget.expenses.length, (index) {
                        final expense = widget.expenses[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: expense.color.withAlpha(30),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(expense.icon, color: expense.color),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      expense.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(
                                      expense.category,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    Text(
                                      'Rs. ${expense.amount.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                tooltip: 'Remove Expense',
                                onPressed: () {
                                  removeExpense(index);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.home_outlined),
                  label: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
