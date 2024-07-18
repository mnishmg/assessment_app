import 'dart:convert'; // For JSON encoding and decoding.
import 'dart:developer'; // For logging.
import 'package:http/http.dart' as httpClient; // For making HTTP requests.
import 'api_exceptions.dart'; // For custom API exceptions.

// ApiHelper class to manage API calls.
class ApiHelper {
  // Base URL for the API.
  String baseUrl = 'https://opentdb.com/';

  // Function to make a GET request.
  Future<dynamic> get(
      {required String urlEndpoint, Map<String, String>? headers}) async {
    // Construct the full URL and make the GET request.
    var response = await httpClient.get(Uri.parse(baseUrl + urlEndpoint),
        headers: headers);
    // Check the response and handle it accordingly.
    return checkResponse(response);
  }

  // Function to check the response from the GET request.
  dynamic checkResponse(httpClient.Response response) {
    // Switch case to handle different status codes.
    switch (response.statusCode) {
      case 200: // If the request is successful.
        return json.decode(response.body); // Decode and return the JSON response.
      case 401: // If the request is unauthorized.
        throw UnauthorisedException(response.body); // Throw an UnauthorizedException.
      default: // For other status codes.
        throw Exception('Error: ${response.statusCode}'); // Throw a generic exception with the status code.
    }
  }
}
