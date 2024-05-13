String MACHINE_CODE = "";

const String BASE_URL = "https://maker-sync-django.vercel.app/api/v2/machines";
String USER_URL = "";
String SENSOR_URL = "";
String NOTIFICATION_URL = "";



void updateMachineCode(String code) {
  MACHINE_CODE = code;
  print("Machine Code: $MACHINE_CODE");

  USER_URL = "$BASE_URL/$MACHINE_CODE/users/";
  SENSOR_URL = "$BASE_URL/$MACHINE_CODE/sensors/";
  NOTIFICATION_URL = "$BASE_URL/$MACHINE_CODE/notifications";
}
