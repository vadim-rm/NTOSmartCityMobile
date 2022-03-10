enum TrashType { glass, plastic, paper }

extension GetDescription on TrashType {
  String getDescription() {
    switch (this) {
      case TrashType.glass:
        return "Стекло";
      case TrashType.plastic:
        return "Пластик";
      case TrashType.paper:
        return "Бумага";
    }
  }
}

extension GetString on TrashType {
  String getString() {
    switch (this) {
      case TrashType.glass:
        return "glass";
      case TrashType.plastic:
        return "plastic";
      case TrashType.paper:
        return "paper";
    }
  }
}