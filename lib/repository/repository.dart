import 'package:ikechukwu_israel/models/filter.dart';
import 'package:ikechukwu_israel/networks/api_endpoint.dart';
import 'package:ikechukwu_israel/networks/api_service.dart';

class Repository {
  Future<List<Filter>> getFilters() async {
    final response = await ApiService().fetchData(ApiEndpoint.filter);

    return filterFromJson(response);
  }
}
