import 'package:crm_android/constants/variables.dart';
import 'package:crm_android/models/response/customer_response_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class CustomerRepository {
  Future<CustomersResponseModel> getCustomers() async {
    try {
      final response = await Dio().get(
        Variables.rapidApiUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      print(response);
      return CustomersResponseModel.fromListJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
