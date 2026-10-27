# Drivo SV

Demo Flutter para Android y web de las seis pantallas del recorrido de alquiler: inicio, exploración, detalle, pago, confirmación y chat.

## Abrir en Android Studio

1. Abre esta carpeta como proyecto Flutter.
2. Inicia un emulador Android o conecta un teléfono con depuración USB.
3. Ejecuta `flutter pub get` y `flutter run`.

Para presentarlo en Chrome desde PowerShell:

```powershell
cd "C:\Users\gmoli\Documents\Android Tests\Drivo App Mobil"
C:\Flutter\bin\flutter.bat run -d chrome
```

También puedes instalar el APK de depuración generado en `build/app/outputs/flutter-apk/app-debug.apk`.
Las capturas verificadas en el emulador Pixel 8 están en `previews/`.

## Alcance

La navegación, selección de rol, ubicación, método de pago, condiciones y mensajes funcionan de forma local. Los datos, fechas, mapa, reserva y comprobante son ejemplos basados en el documento entregado. La app no inicia sesión, procesa pagos, contacta al anfitrión ni guarda mensajes en un servidor. No introduzcas datos de tarjeta reales.

Las fotografías se muestran desde las capturas incluidas en el documento de referencia. No se necesita una clave de Stitch para compilar o ejecutar la app.
