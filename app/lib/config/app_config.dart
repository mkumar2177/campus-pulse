class AppConfig {
  const AppConfig._();
  static const serverUrl = String.fromEnvironment(
    'CAMPUS_PULSE_SERVER_URL',
    defaultValue: 'http://localhost:8080',
  );
}
