// Base class for API related exceptions.
class ApiExceptions implements Exception {
  String? heading, msg;

  // Constructor to initialize heading and message.
  ApiExceptions({this.heading, this.msg});

  // Override toString() method to provide a formatted error message.
  @override
  String toString() {
    return '$heading: $msg';
  }
}

// Specific exception class for unauthorized access.
class UnauthorisedException extends ApiExceptions {
  // Constructor calls super to initialize heading and message.
  UnauthorisedException(String msg)
      : super(heading: 'Unauthorised Exception', msg: msg);
}
