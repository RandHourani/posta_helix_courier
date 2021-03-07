class ActivationCodeModel {
  String message = "";
  String data = "";
  Providers errors;

  ActivationCodeModel({this.message, this.errors, this.data});

  factory ActivationCodeModel.fromJson(Map<String, dynamic> json) {
    return ActivationCodeModel(
      message: json['message'] as String,
      data: json['data'],
    );
  }
}

class Providers {
  List<String> provider = List();

  Providers({this.provider});

  factory Providers.fromJson(Map<String, dynamic> json) {
    return Providers(
        provider: (json['provider'] as List).map((map) => ("$map")).toList());
  }
}
