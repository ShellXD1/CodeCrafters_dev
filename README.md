# Guía de Operaciones para Intellichef

## Instalación de Flutter

1. **Descargar Flutter:**
   - Visita la [página de descargas de Flutter](https://flutter.dev/docs/get-started/install) y descarga el SDK de Flutter para tu sistema operativo.

2. **Extraer el SDK:**
   - Extrae el archivo descargado y guarda el contenido en una ubicación deseada.

3. **Actualizar la variable de entorno `PATH`:**
   - Añade la ruta del directorio `flutter/bin` a tu variable de entorno `PATH`.

4. **Verificar la instalación:**
   - Abre una terminal y ejecuta:
     ```sh
     flutter doctor
     ```
   - Sigue las instrucciones para completar cualquier instalación faltante.

## Instalación de Android Studio

1. **Descargar e instalar Android Studio:**
   - Visita la [página de descargas de Android Studio](https://developer.android.com/studio) y descarga el instalador para tu sistema operativo.
   - Instala Android Studio siguiendo las instrucciones del instalador.

2. **Configurar Android Studio:**
   - Abre Android Studio y sigue el asistente de configuración.
   - Instala el SDK de Android, el emulador de Android y otros componentes necesarios.

3. **Configurar las variables de entorno:**
   - Asegúrate de que las rutas al SDK de Android estén configuradas en las variables de entorno:
     ```sh
     export ANDROID_HOME=$HOME/Android/Sdk
     export PATH=$PATH:$ANDROID_HOME/emulator
     export PATH=$PATH:$ANDROID_HOME/tools
     export PATH=$PATH:$ANDROID_HOME/tools/bin
     export PATH=$PATH:$ANDROID_HOME/platform-tools
     ```

## Instalación de Visual Studio Code

1. **Descargar e instalar VS Code:**
   - Visita la [página de descargas de VS Code](https://code.visualstudio.com/Download) y descarga el instalador para tu sistema operativo.
   - Instala VS Code siguiendo las instrucciones del instalador.

2. **Instalar extensiones necesarias:**
   - Abre VS Code y ve a la pestaña de extensiones (icono de cuadrado en la barra lateral izquierda).
   - Busca e instala las siguientes extensiones:
     - **Flutter** (también instalará Dart automáticamente).

## Descargar el proyecto
   - Con ssh
   ```sh
   git clone git@github.com:ShellXD1/CodeCrafters_dev.git
   ```

## Abrir en Proyecto Flutter

1. **Abrir el proyecto en VS Code:**
   - En VS Code, abre la carpeta del proyecto:
     ```sh
     code .
     ```

## Ejecutar la Aplicación en un Emulador o Dispositivo Físico

1. **Iniciar un emulador de Android:**
   - Abre Android Studio, ve a "AVD Manager" y crea un nuevo dispositivo virtual (emulador).
   - Inicia el emulador.

2. **Conectar un dispositivo físico:**
   - Habilita la depuración USB en tu dispositivo Android.
   - Conecta tu dispositivo a tu computadora mediante un cable USB.

3. **Ejecutar la aplicación:**
   - En VS Code, abre la paleta de comandos (Ctrl+Shift+P) y selecciona `Flutter: Select Device` para elegir el emulador o dispositivo conectado.
   - Ejecuta la aplicación presionando `F5` o seleccionando `Run` > `Start Debugging` en el menú.

## Edición y Desarrollo

1. **Abrir y editar archivos:**
   - En VS Code, navega a los archivos `.dart` en la carpeta `lib` para comenzar a editar tu aplicación Flutter.

2. **Recargar en caliente:**
   - Mientras la aplicación se ejecuta, guarda los cambios y utiliza la función de recarga en caliente (`Hot Reload`) para ver los cambios instantáneamente sin reiniciar la aplicación. Presiona `r` en la terminal donde se está ejecutando `flutter run` o utiliza el botón de recarga en caliente en VS Code.

## Finalizar el Desarrollo

1. **Parar la aplicación:**
   - Presiona `Shift+F5` en VS Code o cierra la terminal donde se está ejecutando `flutter run`.

2. **Apagar el emulador:**
   - Cierra el emulador desde Android Studio o desde la ventana del emulador.

3. **Desconectar el dispositivo físico:**
   - Desconecta el cable USB.

> **Nota:** Asegúrate de tener todas las herramientas actualizadas a sus versiones más recientes para evitar problemas de compatibilidad.
