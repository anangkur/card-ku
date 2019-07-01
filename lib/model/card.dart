import 'package:flutter_eudeka_finaltask/model/card_sets.dart';
import 'package:flutter_eudeka_finaltask/model/card_images.dart';
import 'package:flutter_eudeka_finaltask/model/card_prices.dart';

class YugiohCard {

  String id;
  String name;
  String type;
  String desc;
  String race;
  String archetype;
//  List<Card_sets> card_sets;
  List<Card_images> card_images;
  Card_prices card_prices;

	YugiohCard.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		type = map["type"],
		desc = map["desc"],
		race = map["race"],
		archetype = map["archetype"],
//		card_sets = List<Card_sets>.from(map["card_sets"].map((it) => Card_sets.fromJsonMap(it))),
		card_images = List<Card_images>.from(map["card_images"].map((it) => Card_images.fromJsonMap(it))),
		card_prices = Card_prices.fromJsonMap(map["card_prices"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['type'] = type;
		data['desc'] = desc;
		data['race'] = race;
		data['archetype'] = archetype;
//		data['card_sets'] = card_sets != null ?
//			this.card_sets.map((v) => v.toJson()).toList()
//			: null;
		data['card_images'] = card_images != null ? 
			this.card_images.map((v) => v.toJson()).toList()
			: null;
		data['card_prices'] = card_prices == null ? null : card_prices.toJson();
		return data;
	}
}
