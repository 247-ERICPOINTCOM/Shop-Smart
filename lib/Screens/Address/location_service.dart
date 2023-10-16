import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService{
  final String key='AIzaSyC-aX21mLD5H-Xa0lFOmYp8h_C-9_yzUd8';

  Future<String> getPlaceId(String input) async {
    final String url=
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var pleacId = json['candidates'][0]['place_id'] as String ;


    return pleacId;

  }
  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);
    final String url=
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results =json['result'] as Map<String, dynamic>;
    print(results);
    return results;
  }


}