import 'package:dio/dio.dart';
import 'dio_config.dart';
import 'api_constants.dart';
import '../models/category_model.dart';

// service class responsible for api calls
class ApiService {
  // dio instance configured from dio config
  final Dio dio = DioConfig.getDio();

  // fetch categories from api and convert them to category model list
  Future<List<CategoryModel>> getCategories() async {
    // send get request to categories endpoint
    final response = await dio.get(ApiConstants.categories);

    // extract categories list from response json
    List categoriesJson = response.data;

    // convert json list to category model objects
    return categoriesJson.map((json) => CategoryModel.fromJson(json)).toList();
  }
}