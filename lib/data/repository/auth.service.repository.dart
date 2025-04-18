import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:paisay_da_da/data/api/api_exception.dart';
import 'package:paisay_da_da/data/api/api_path.dart';
import 'package:paisay_da_da/data/api/api_service.dart';
import 'package:paisay_da_da/domain/models/generalmodel/failture.model.dart';
import 'package:paisay_da_da/domain/models/generalmodel/authentication.model.dart';
import 'package:paisay_da_da/domain/repository/auth.repository.dart';

class AuthServriceRepository extends AuthRepository {
  @override
  Future<Either<AuthenticationModel, FailtureModel>> signup(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var response = await ApiService.request(
        ApiPaths.signup,
        method: RequestMethod.post,
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );
      if (response != null) {
        if (response['success'] == true) {
          return left(AuthenticationModel.fromJson(response));
        } else {
          return right(FailtureModel.fromJson(response, String: null));
        }
      } else {
        return right(FailtureModel(message: 'An error occurred'));
      }
    } on DioException catch (e) {
      return right(
        FailtureModel(
          message: CustomDioException.fromDioError(e).toString(),
        ),
      );
    } catch (e) {
      return right(FailtureModel(message: "Unexpected error: $e"));
    }
  }

  @override
  Future<Either<AuthenticationModel, FailtureModel>> signin(
      {required String email, required String password}) async {
    try {
      var response = await ApiService.request(
        ApiPaths.signin,
        method: RequestMethod.post,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response != null) {
        if (response['success'] == true) {
          return left(AuthenticationModel.fromJson(response));
        } else {
          return right(FailtureModel.fromJson(response, String: null));
        }
      } else {
        return right(FailtureModel(message: 'An error occurred'));
      }
    } on DioException catch (e) {
      return right(
        FailtureModel(
          message: CustomDioException.fromDioError(e).toString(),
        ),
      );
    } catch (e) {
      return right(FailtureModel(message: "Unexpected error: $e"));
    }
  }
}
