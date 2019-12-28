import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart' as Constants;


// Future<Map<String, dynamic>> fetchUserData(id) async {
//   print('calling fetchUserData with id $id');
//   http.Response res = await http.get('${Constants.DUMMY_BACKEND_URL}/users/$id');
//   print('res');
//   print(res);
//   return jsonDecode(res.body)['result'];
// }

Future<Map> fetchUserData(id) async {
  Map userData = null;
  http.get('${Constants.DUMMY_BACKEND_URL}/users/$id').then((res) {
    print('AAAAAAAAAAAAAAAAA');
    dynamic test = jsonDecode(res.body)['result'];
    print(test);
    print('above me');
    userData = test;
  }, onError: (e) => print("OH NO"));
  print("RETURNING ${userData}");
  return userData;
}
