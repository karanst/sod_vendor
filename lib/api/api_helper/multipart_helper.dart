import 'package:http/http.dart' as http;

class MultipartHelper {
  static requestOneImg(
    requestBody, {
    required url,
    img,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(requestBody);
    if (img != null) {
      request.files
          .add(await http.MultipartFile.fromPath('profile_image', img));
    }

    http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
    var newdata = await response.stream.bytesToString();
    return newdata;
  }
}
