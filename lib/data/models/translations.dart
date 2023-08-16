class Translations {
  final Map<String, dynamic> _localizedValues;

  Translations(this._localizedValues);

  // Función para obtener una traducción
  String getCopy(String page, String key) {
    return _localizedValues['pages'][page][key] ??
        ''; // Devuelve un string vacío si no encuentra la traducción
  }
}
