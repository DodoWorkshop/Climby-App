import 'dart:convert';

import 'package:climby/client/api_client.dart';
import 'package:climby/model/place.dart';
import 'package:climby/repository/repository.dart';

class PlaceRepository extends HttpRepository<ApiClient> {
  static const String baseUri = "/places";

  PlaceRepository(super.client);

  Future<Set<Place>> getAllPlaces() async {
    final uri = Uri.parse(baseUri);
    final response = await client.get(uri);

    final List<dynamic> list = jsonDecode(response.body);

    return list.map((json) => Place.fromJson(json)).toSet();
  }
}
