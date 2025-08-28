import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:paisay_da_da/domain/models/failture.model.dart';
import 'package:paisay_da_da/domain/models/success.model.dart';

abstract class ExpenseRepository {
  Future<Either<FailtureModel, SuccessModel>> createExpense({
    required BuildContext context,
    required title,
    required amount,
    required category,
    required memeberEmail,
  });
}
