const idKey = 'id';

extension JsonMapUtils on Map<String, dynamic> {
  Map<String, dynamic> withId(String id) => this..[idKey] = id;
}
