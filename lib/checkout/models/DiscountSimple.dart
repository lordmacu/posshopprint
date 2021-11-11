class DiscountSimple{
  int _discount_id;
  int _totalDiscount;

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
}