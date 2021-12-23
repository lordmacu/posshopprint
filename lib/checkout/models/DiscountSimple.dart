class DiscountSimple{
  int _discount_id;
  int _totalDiscount;

  String _name;

  String _type;
  String _calculationType;

  int _discount;


  int get discount => _discount;

  set discount(int value) {
    _discount = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get discount_id => _discount_id;

  set discount_id(int value) {
    _discount_id = value;
  }

  int get totalDiscount => _totalDiscount;

  set totalDiscount(int value) {
    _totalDiscount = value;
  }

  DiscountSimple(this._discount_id, this._totalDiscount);

  @override
  String toString() {
    return 'DiscountSimple{_discount_id: $_discount_id, _totalDiscount: $_totalDiscount}';
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get calculationType => _calculationType;

  set calculationType(String value) {
    _calculationType = value;
  }
}