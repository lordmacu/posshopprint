class Category{

  int _id;
  int _idOrg;
  String _name;

  @override
  String toString() {
    return 'Category{_id: $_id, _idOrg: $_idOrg, _name: $_name, _color: $_color}';
  }

  Category(this._id, this._idOrg, this._name, this._color);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String _color;

  int get idOrg => _idOrg;

  set idOrg(int value) {
    _idOrg = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get color => _color;

  set color(String value) {
    _color = value;
  }
}