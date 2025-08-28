import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:paisay_da_da/data/api/api_path.dart';
import 'package:paisay_da_da/data/api/api_service.dart';
import 'package:paisay_da_da/domain/models/failture.model.dart';
import 'package:paisay_da_da/domain/models/success.model.dart';
import 'package:paisay_da_da/domain/repository/expense.repository.dart';

class ExpenseServiceRepository implements ExpenseRepository {
  @override
  Future<Either<FailtureModel, SuccessModel>> createExpense({
    required BuildContext context,
    required title,
    required amount,
    required category,
    required memeberEmail,
  }) async {
    try {
      var response = await ApiService.request(
          method: RequestMethod.post,
          path: ApiPaths.createExpense,
          context: context,
          data: {
            "title": title,
            "amount": amount,
            "category": category,
            "memeberEmail": memeberEmail,
          });
      if (response != null) {
        if (response['status'] == true) {
          return Right(SuccessModel.fromJson(response));
        }
        return Left(FailtureModel.fromJson(response));
      }
      return Left(FailtureModel(message: "No response from server"));
    } catch (error) {
      return Left(FailtureModel(message: "Sign-In failed: $error"));
    }
  }
}
