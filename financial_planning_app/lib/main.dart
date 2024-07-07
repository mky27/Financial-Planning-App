import 'package:flutter/material.dart';
import 'screens/budget_screen.dart';

void main() {
  runApp(FinancialPlannerApp());
}

class FinancialPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BudgetScreen(),
    );
  }
}
