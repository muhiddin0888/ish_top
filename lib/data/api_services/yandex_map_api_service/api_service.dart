import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ish_top/data/api_services/yandex_map_api_service/api_client.dart';
import 'package:ish_top/data/models/geocoding/geocoding.dart';
import 'package:ish_top/utils/constants.dart';

class MapApiService {
  MapApiService({required this.mapApiClient});
  MapApiClient mapApiClient;
  Future<String> getLocationName(String geoCodeText) async {
    try {
      late Response response;
      Map<String, String> qParams = {
        'apikey': mapApiKey,
        'geocode': geoCodeText,
        'lang': 'uz_UZ',
        'format': 'json',
        'kind': 'locality',
        'rspn': '1',
        'results': '1',
      };
      debugPrint("QueryParams>>>>>>>>>>$qParams");
      response = await mapApiClient.dio.get(
        mapApiClient.dio.options.baseUrl,
        queryParameters: qParams,
      );
      String text = '';
      if (response.statusCode! == HttpStatus.ok) {
        Geocoding geocoding = Geocoding.fromJson(response.data);

        if (geocoding.response.geoObjectCollection.featureMember.isNotEmpty) {
          text = geocoding.response.geoObjectCollection.featureMember[0].geoObject
              .metaDataProperty.geocoderMetaData.text;
          debugPrint("text>>>>>>>>>>>> $text");
        } else {
          text = 'Aniqlanmagan hudud';
        }
        return text;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
