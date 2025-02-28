// ignore: one_member_abstracts
abstract class Decodable<T> {
  T decode(dynamic data);
}

class TypeDecodable<T> implements Decodable<TypeDecodable<T>> {
  T value;
  TypeDecodable({required this.value});

  @override
  TypeDecodable<T> decode(dynamic data) {
    value = data;
    return this;
  }
}

class StringDecodable implements Decodable<String> {
  @override
  String decode(dynamic data) {
    if (data is String) {
      return data;
    }
    throw FormatException("Expected a String, got ${data.runtimeType}");
  }
}
