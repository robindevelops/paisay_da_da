import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/constants/base_helper.dart';
import 'package:paisay_da_da/domain/repository/expense.repository.dart';

class ExpenseNotifier extends ChangeNotifier {
  ExpenseRepository expenseRepository;

  ExpenseNotifier({required this.expenseRepository});

  Future<void> addExpenese({
    required String title,
    required String price,
    required String payerEmail,
    String? groupId,
    required List<String> members,
    required BuildContext context,
  }) async {
    var response = await expenseRepository.addExpense(
      title: title,
      price: price,
      payerEmail: payerEmail,
      members: members,
      groupId: groupId,
    );

    response.fold(
      (success) {
        // BaseHelper.showSnackBar(
        //   context,
        //   success.message.toString(),
        //   Colors.green,
        // );
      },
      (failture) {},
    );
  }

  Future<void> clearExpenese({
    required String expenseId,
    required BuildContext context,
  }) async {
    var response = await expenseRepository.clearExpense(
      expenseId: expenseId,
    );

    response.fold(
      (success) {
        BaseHelper.showSnackBar(
          context,
          success.message.toString(),
          Colors.green,
        );
      },
      (failture) {},
    );
  }
}
