class EnumHelper {

  static String getStringValue(dynamic enumValue) {
    return enumValue.toString().split('.')[1];
  }

}