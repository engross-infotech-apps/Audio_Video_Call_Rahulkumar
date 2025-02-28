import 'dart:convert';

import 'decodable.dart';

///A function that creates an object of type [T]

typedef Create<T> = T Function();

///Construct to get object from generic class

abstract class GenericObject<T> {
  Create<Decodable> create;

  GenericObject({required this.create});

  T genericObject(dynamic data) {
    final item = create();
    return item.decode(data);
  }
}

///Construct to wrap response from API.
///
///Used it as return object of APIController to handle any kind of response.

class ResponseWrapper<T> extends GenericObject<T> {
  T? response;

  ResponseWrapper({required Create<Decodable> create}) : super(create: create);

  factory ResponseWrapper.init(
      {required Create<Decodable> create, required dynamic data}) {
    final wrapper = ResponseWrapper<T>(create: create);
    wrapper.response = wrapper.genericObject(data);
    return wrapper;
  }
}

class APIResponse<T> extends GenericObject<T>
    implements Decodable<APIResponse<T>> {
  int? statusCode;
  String? message;
  T? data;

  APIResponse({required Create<Decodable> create}) : super(create: create);

  @override
  APIResponse<T> decode(dynamic jsonData) {
    var json = jsonDecode(jsonData);
    statusCode = json['statusCode'];
    message = json['message'];

    if (json['data'] != null) {
      data = genericObject(json['data']);
    }
    return this;
  }
}

class APIListResponse<T> extends GenericObject<T>
    implements Decodable<APIListResponse<T>> {
  int? statusCode;
  String? message;
  List<T>? data;

  APIListResponse({required Create<Decodable> create}) : super(create: create);

  @override
  APIListResponse<T> decode(dynamic jsonData) {
    var json = jsonDecode(jsonData);
    statusCode = json['statusCode'];
    message = json['message'];
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((item) {
        data?.add(genericObject(item));
      });
    }
    return this;
  }
}

class ErrorResponse implements Exception {
  String? message;

  ErrorResponse({this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(message: json['message'] ?? 'Something went wrong.');
  }

  @override
  String toString() {
    return message ?? 'Failed to convert message to string.';
  }
}
