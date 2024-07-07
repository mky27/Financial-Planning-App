import 'package:flutter/material.dart';
import '../models/budget.dart';

class BudgetList extends StatelessWidget {
  final List<Budget> budgets;
  final Function deleteBudget;
  final Function editBudget;

  BudgetList(this.budgets, this.deleteBudget, this.editBudget);

  @override
  Widget build(BuildContext context) {
    return budgets.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'No budgets added yet!',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('RM${budgets[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    budgets[index].category,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                      'Spent: RM${budgets[index].spent}, Remaining: RM${budgets[index].amount - budgets[index].spent}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () => editBudget(context, index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => deleteBudget(index),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: budgets.length,
          );
  }
}
