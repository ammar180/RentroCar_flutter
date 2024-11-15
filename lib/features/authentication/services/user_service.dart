import 'package:rentro_car/core/api/api_consumer.dart';
import 'package:rentro_car/core/api/end_points.dart';
import 'package:dartz/dartz.dart';
import 'package:rentro_car/core/cache/cache_helper.dart';
import 'package:rentro_car/core/errors/exceptions.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rentro_car/features/authentication/models/login_model.dart';
import 'package:rentro_car/features/authentication/models/signup_model.dart';
import 'package:rentro_car/features/authentication/models/user_model.dart';

class UserService {
  final ApiConsumer api;
  UserService({required this.api});

  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        EndPoints.login,
        data: {
          ApiKeys.email: email,
          ApiKeys.password: password,
        },
        isFromData: true,
      );
      final user = LoginModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token);
      CacheHelper().saveData(key: ApiKeys.token, value: user.token);
      CacheHelper().saveData(key: ApiKeys.id, value: decodedToken[ApiKeys.id]);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, SignupModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    // required XFile profilePic,
  }) async {
    try {
      final response = await api.post(
        EndPoints.signUp,
        isFromData: true,
        data: {
          ApiKeys.name: name,
          ApiKeys.email: email,
          ApiKeys.password: password,
          ApiKeys.confirmPassword: confirmPassword,
        },
      );
      final signUPModel = SignupModel.fromJson(response);
      return Right(signUPModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(
        EndPoints.getUserDataEndPoint(
          CacheHelper().getData(key: ApiKeys.id),
        ),
      );
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }
}
