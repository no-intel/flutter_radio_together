import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:radio_together/model/my_position.dart';
import 'package:radio_together/model/radio_item_model.dart';
import 'package:xml/xml.dart';

class GetRadioItemsService {
  static const String RADIO_URL_BASE = "https://spectrummap.kr/openapi.do";
  static const String SEARCH_ID = "02";
  static const String JUSCODE = "1100000000";

  Future<List<RadioItemModel>> getRadioItems(MyPosition myPosition) async {
    List<RadioItemModel> radioItems = [];

    final String radioApiKey = dotenv.env['RADIO_API_KEY']!;

    Uri uri = Uri.parse(
      '$RADIO_URL_BASE?key=$radioApiKey&searchId=$SEARCH_ID&ltd=${myPosition.latitude}&lou=${myPosition.longitude}&jusocode=$JUSCODE',
    );
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load radio items');
    }

    final rawString = utf8.decode(response.bodyBytes).trim();

    final convert = HtmlUnescape().convert(rawString);

    final XmlDocument document = XmlDocument.parse(convert);
    final Iterable<XmlElement> items = document.findAllElements("row");

    items.forEach((item) {
      final broadArea = item.findElements("BROADAREA").first.innerText;
      final broadNm = item.findElements("BROAD_NM").first.innerText;
      final serviceNm = item.findElements("SERVICE_NM").first.innerText;
      final brodFreq = item.findElements("BROD_FREQ").first.innerText;

      radioItems.add(
        RadioItemModel(
          broadarea: broadArea,
          broadNm: broadNm,
          brodFreq: brodFreq,
          serviceNm: serviceNm,
        ),
      );
    });

    return radioItems;
  }
}
