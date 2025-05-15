import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/success.model.dart';

abstract class ExpenseRepository {
  Future<Either<SuccessModel, FailtureModel>> addExpense({
    required String title,
    required String price,
    required String payerEmail,
    String? groupId,
    required List<String> members,
  });

  Future<Either<SuccessModel, FailtureModel>> clearExpense({
    required String expenseId,
  });
}
