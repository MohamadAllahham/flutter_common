// equal regex are used in the api
const _containedUrlPattern = r'\w\S*\.\S+';
const _urlPattern = '^$_containedUrlPattern\$';
const _emailPattern = r'^[\w\._+-]+@[\w\._+-]+\.[\w\._+-]+$';
const _phonePattern = r'^[\+\-\\\/\(\)\s\d]+$';

bool isValidUrl(String value) {
  return RegExp(_urlPattern).hasMatch(value);
}

String replaceUrls(String data, String Function(String url) replace) {
  return data.replaceAllMapped(
    RegExp(_containedUrlPattern),
    (Match m) => replace(m[0]!),
  );
}

bool isValidEmail(String value) {
  return RegExp(_emailPattern).hasMatch(value);
}

bool isValidPhoneNumber(String value) {
  return RegExp(_phonePattern).hasMatch(value);
}
