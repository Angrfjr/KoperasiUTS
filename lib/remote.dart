import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:koperasi/model.dart';

class RemoteData {
  var client = http.Client();
  var remoteUrl = '_baseUrl/api/koperasis';

  Future<dynamic> get() async {
    var response =
        await client.get(Uri.parse('$remoteUrl?populate=Image,tags'));
  }

  Future<dynamic> getByName({required String keyword}) async {
    var response = await client.get(Uri.parse(
        '$remoteUrl?populate=Image,tags&filters[Nama][\$contains]=$keyword'));

    return response;
  }
}
