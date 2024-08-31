import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

getDateFormat(DateTime dateTime) {
  return DateFormat('yyyy/MM/dd').format(dateTime);
}

Future<void> launchInWebView(String url) async {
  Uri parsedUrl = Uri.parse(url);
  if (!await launchUrl(parsedUrl)) {
    throw Exception('Could not launch $parsedUrl');
  }
}
