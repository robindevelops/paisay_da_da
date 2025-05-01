import 'package:dartz/dartz.dart';
import 'package:paisay_da_da/data/api/api_path.dart';
import 'package:paisay_da_da/data/api/api_service.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/success.model.dart';
import 'package:paisay_da_da/domain/repository/expense.repository.dart';

class ExpenseServiceRepository implements ExpenseRepository {
  @override
  Future<Either<SuccessModel, FailtureModel>> addExpense(
      {required String title,
      required String price,
      required String payerEmail,
      String? groupId,
      required List<String> members}) async {
    try {
      var response = await ApiService.request(ApiPaths.addExpense,
          method: RequestMethod.post,
          data: {
            "title": title,
            "price": price,
            "payerEmail": payerEmail,
            "members": members,
            "groupid": groupId,
          });

      if (response != null) {
        if (response['status'] == true) {
          return left(SuccessModel.fromJson(response));
        } else {
          return right(FailtureModel.fromJson(response, String: null));
        }
      } else {
        return right(FailtureModel(message: 'An error occurred'));
      }
    } catch (e) {
      return right(
        FailtureModel(message: "Unexpected error: $e"),
      );
    }
  }
}
