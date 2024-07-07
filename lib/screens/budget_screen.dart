import 'package:flutter/material.dart';
import '../models/budget.dart';
import '../widgets/budget_form.dart';
import '../widgets/budget_list.dart';

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final List<Budget> _budgets = [];

  void _addNewBudget(String category, double amount) {
    final newBudget = Budget(category: category, amount: amount);

    setState(() {
      _budgets.add(newBudget);
    });
  }

  void _updateBudget(int index, String category, double amount) {
    setState(() {
      _budgets[index].category = category;
      _budgets[index].amount = amount;
    });
  }

  void _deleteBudget(int index) {
    setState(() {
      _budgets.removeAt(index);
    });
  }

  void _startAddNewBudget(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: BudgetForm(_addNewBudget),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _startEditBudget(BuildContext ctx, int index) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: BudgetForm(
            (category, amount) => _updateBudget(index, category, amount),
            existingBudget: _budgets[index],
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Management'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BudgetList(_budgets, _deleteBudget, _startEditBudget),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewBudget(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
