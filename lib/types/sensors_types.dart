enum SensorType {
  servo,
  color,
  distance,
}

extension GetDescription on SensorType {
  String getDescription() {
    switch (this) {
      case SensorType.servo:
        return "Сервопривод";
      case SensorType.color:
        return "Датчик цвета";
      case SensorType.distance:
        return "Датчик расстояния";
    }
  }
}

extension GetString on SensorType {
  String getString() {
    switch (this) {
      case SensorType.servo:
        return "servo";
      case SensorType.color:
        return "color";
      case SensorType.distance:
        return "distance";
    }
  }
}