List <String> flightCompany = [
  'Jambojet',
  'Skyward',
  'Fly540',
  'Safarilink',
  'RenegadeAir',
  '748 Air',   
];

class Flights{
  Flights(this.flightCompany, this.flightnumber, this.fromWhere, this.toWhere, this.depTime, this.price);
  String flightCompany;
  String flightnumber;
  String fromWhere;
  String toWhere;
  String depTime;
  int price;
}