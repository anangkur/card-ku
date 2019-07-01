
class Card_prices {

  String cardmarket_price;
  String tcgplayer_price;
  String ebay_price;
  String amazon_price;

	Card_prices.fromJsonMap(Map<String, dynamic> map): 
		cardmarket_price = map["cardmarket_price"],
		tcgplayer_price = map["tcgplayer_price"],
		ebay_price = map["ebay_price"],
		amazon_price = map["amazon_price"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['cardmarket_price'] = cardmarket_price;
		data['tcgplayer_price'] = tcgplayer_price;
		data['ebay_price'] = ebay_price;
		data['amazon_price'] = amazon_price;
		return data;
	}
}
