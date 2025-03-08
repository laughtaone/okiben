import 'package:url_launcher/url_launcher.dart';


Future funcOpenUrl(url) async {
  launchUrl(Uri.parse(url));
}