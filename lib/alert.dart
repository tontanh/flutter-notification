import 'package:http/http.dart' as http;
import 'dart:convert';


//  getData() async {
//   var url = Uri.parse("https://api.tonserver.cf/public/api/read/lastid.php");
//   var req = await http.get(url);
//   var infos = json.decode(req.body);

// }

getData() async {
  var url = Uri.parse("https://api.tonserver.cf/public/api/read/lastid.php");
  final response = await http.get(url);
  //  final infos = json.decode(req.body);
  final responseJson = json.decode(response.body);
  if (response.statusCode == 200) {
    print(responseJson);
    print(responseJson['id']);
  } else {
    print(responseJson);
  }
}
// Future<List<TestModelApi>> fetchUsers() async {
//   try {
//     final url = Uri.http('api.tonserver.cf', '/public/api/read/');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       return testModelApiFromJson(response.body);
//     } else {
//       throw Exception("Failed to load data");
//     }
//   } catch (e) {}
// }
