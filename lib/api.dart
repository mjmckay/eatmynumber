import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class API{
  String _baseURL = "https://burn451.herokuapp.com/";
  final storage = new FlutterSecureStorage();

  void register () async {
    String _url = _baseURL + "register";
    var response = await http.post(_url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    await storage.write(key: "userData", value: jsonDecode(response.body)["token"]);
  }

  void initLease() async {
    var token = await storage.read(key: "userData");
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    //POST (check out a number), input {"user_number": "..."}, return {"lease_id": "...", "leased_number": "...", "ttl": ###}
    var response = await http.post(_baseURL + 'lease',
        headers: headers,
        body: {'user_number': '+19706900961'});

    print('Response status: ${response.statusCode}');
    Map<String, dynamic> jsonData = json.decode(response.body);

    print('Response body: ${jsonData["lease_id"]}');
    print('Response body: ${jsonData['leased_number']}');
    print('Response body: ${jsonData['ttl']}');
  }

  void extendLease(){

  }

  void endLease(){

  }

  void checkFunds(){

  }

  void addFunds() {

  }
}