import 'package:posshop_app/model/entity/BaseEntity.dart';

class SelectedItem<T extends BaseEntity> {
  late Map<String, Item> entities = Map<String, Item>();

  // addItem(T entity) {
  //   if (entities.containsKey(entity.uniqueCloudKey())) {
  //     entities.update(entity.uniqueCloudKey(), (value) => Item(selected: value.selected, entity: entity));
  //   } else {
  //     entities[entity.uniqueCloudKey()] = Item(selected: false, entity: entity);
  //   }
  // }

  load(List<T> items) {
    Map<String, Item> newEntities = Map<String, Item>();
    items.forEach((entity) {
      bool selected = false;
      if (this.entities.containsKey(entity.uniqueCloudKey())) {
        selected = this.entities[entity.uniqueCloudKey()]!.selected;
      }
      newEntities[entity.uniqueCloudKey()] = Item(selected: selected, entity: entity);
    });
    this.entities = newEntities;
  }

  changeSelected(T entity) {
    if (entities.containsKey(entity.uniqueCloudKey())) {
      this.entities[entity.uniqueCloudKey()]!.selected = !this.entities[entity.uniqueCloudKey()]!.selected;
    }
  }

  reset() {
    entities.forEach((key, value) {
      value.selected = false;
    });
  }

  bool isSelected(T entity) {
    if (entities.containsKey(entity.uniqueCloudKey())) {
      return this.entities[entity.uniqueCloudKey()]!.selected;
    }
    return false;
  }

  int totalSelected() {
    int total = 0;
    entities.forEach((key, value) {
      if (value.selected) {
        total++;
      }
    });
    return total;
  }

  //TODO no pude retornar T, con dynamic paso
  List<dynamic> getSelectedItems() {
    return entities.entries.where((element) => element.value.selected).map((e) => e.value.entity).toList();
  }
}

class Item<T extends BaseEntity> {
  bool selected = false;
  T entity;

  Item({
    required this.selected,
    required this.entity,
  });
}
