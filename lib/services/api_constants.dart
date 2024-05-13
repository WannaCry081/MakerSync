String MACHINE_CODE = "";


const String BASE_URL = "https://maker-sync-django.vercel.app/api/v2/machines";

String USER_URL = "$BASE_URL/$MACHINE_CODE/users/";
String SENSOR_URL = "$BASE_URL/$MACHINE_CODE/sensors/";
String NOTIFICATION_URL = "$BASE_URL/$MACHINE_CODE/notifications";


void updateMachineCode(String code) {
  MACHINE_CODE = code;
}
