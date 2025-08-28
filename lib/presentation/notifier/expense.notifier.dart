import 'package:flutter/material.dart';
import 'package:paisay_da_da/domain/repository/expense.repository.dart';
import 'package:paisay_da_da/presentation/notifier/loader.notifier.dart';
import 'package:provider/provider.dart';

class ExpenseNotifier extends ChangeNotifier {
  ExpenseRepository expenseRepository;

  ExpenseNotifier({required this.expenseRepository});

  Future<void> createExpense(
    BuildContext context, {
    required title,
    required amount,
    required category,
    required memberEmail,
  }) async {
    final loaderNotifier = Provider.of<LoaderNotifier>(context, listen: false);

    try {
      loaderNotifier.setLoading(true);

      await Future.delayed(Duration(seconds: 1));
      var response = await expenseRepository.createExpense(
        context: context,
        title: title,
        amount: amount,
        category: category,
        memeberEmail: memberEmail,
      );
      response.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(failure.message.toString()),
            ),
          );
        },
        (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(success.message.toString()),
            ),
          );
          notifyListeners(); // 👈 update UI
        },
      );
    } finally {
      loaderNotifier.setLoading(false);
    }
  }
}
