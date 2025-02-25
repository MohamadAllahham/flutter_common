import 'package:flutter_common/logging.dart';
import 'package:url_launcher/url_launcher.dart';

enum PhoneNumberLaunchMode {
  tel(scheme: 'tel'),
  sms(scheme: 'sms');

  final String scheme;

  const PhoneNumberLaunchMode({required this.scheme});
}

class BrowserService {
  static final logger = createLogger(BrowserService);

  Future<bool> tryLaunchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      return true;
    } else {
      // TODO: Show snackbar
      logger.w('Could not launch url $url');
      return false;
    }
  }

  Future<bool> tryLaunchUrlString(String? url) async {
    if (url == null) return false;

    final urlWithProtocol =
        (url.startsWith('https://') || url.startsWith('http://'))
            ? url
            : 'https://$url';

    return await tryLaunchUrl(Uri.parse(urlWithProtocol));
  }

  Future<bool> tryLaunchEmail(
    String emailAddress, {
    String? subject,
  }) async {
    // manually encode subject, because queryParameters wrongly encodes subject with mailto:
    // https://github.com/dart-lang/sdk/issues/43838
    return await tryLaunchUrl(
      Uri(
        scheme: 'mailto',
        path: emailAddress,
        query:
            subject == null ? null : 'subject=${Uri.encodeComponent(subject)}',
      ),
    );
  }

  Future<bool> tryLaunchPhoneNumber(
    String phoneNumber, {
    PhoneNumberLaunchMode phoneNumberLaunchMode = PhoneNumberLaunchMode.tel,
  }) async {
    return await tryLaunchUrl(
      Uri(
        scheme: phoneNumberLaunchMode.scheme,
        path: phoneNumber,
      ),
    );
  }
}
