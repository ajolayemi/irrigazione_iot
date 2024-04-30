/// A representation of the keys used to interact with the company table in the database
class CompanyDatabaseKeys {
  const CompanyDatabaseKeys._();

  static const String table = 'companies';
  
  static const String id = 'id';
  static const String mqttTopicName = 'mqtt_topic_name';
  static const String name = 'name';
  static const String email = 'email';
  static const String phoneNumber = 'phone_number';
  static const String registeredOfficeAddress = 'registered_office_address';
  static const String cf = 'cf';
  static const String piva = 'piva';
  static const String imageUrl = 'image_url';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
}
