import 'package:flutter/material.dart';
import '../models/budget.dart';

class BudgetForm extends StatefulWidget {
  final Function addOrUpdateBudget;
  final Budget? existingBudget;

  BudgetForm(this.addOrUpdateBudget, {this.existingBudget});

  @override
  _BudgetFormState createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  final _amountController = TextEditingController();
  String _selectedCategory = 'Food';

  final List<String> _categories = ['Food', 'Entertainment', 'Transport', 'Bills', 'Other'];

  @override
  void initState() {
    if (widget.existingBudget != null) {
      _selectedCategory = widget.existingBudget!.category;
      _amountController.text = widget.existingBudget!.amount.toString();
    }
    super.initState();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredAmount == null || enteredAmount <= 0) {
      return;
    }

    widget.addOrUpdateBudget(
      _selectedCategory,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: _categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextButton(
                  child: Text(widget.existingBudget == null ? 'Add Budget' : 'Update Budget'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: _submitData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
