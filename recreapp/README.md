# RecreApp

RecreApp es una aplicación móvil multiplataforma desarrollada en Flutter que facilita el acceso de niños en contextos de vulnerabilidad social a actividades recreativas, educativas y saludables. Funciona completamente offline, está adaptada a dispositivos de baja gama y ofrece un catálogo de actividades clasificadas por área temática y validadas pedagógicamente.

## Tabla de contenidos

1. [Características principales](#caracter%C3%ADsticas-principales)  
2. [Requisitos](#requisitos)  
3. [Instalación](#instalaci%C3%B3n)  
4. [Configuración](#configuraci%C3%B3n)  
5. [Uso](#uso)  
6. [Estructura del proyecto](#estructura-del-proyecto)  
7. [Contribuir](#contribuir)  
8. [Licencia](#licencia)  

---

## Características principales

- **Catálogo de actividades**  
  Actividades lúdico-educativas clasificados en áreas: Lenguaje, Matemáticas, Ciencias, Cocina y Pasatiempos.

- **Modo offline total**  
  Todo el contenido se descarga una vez y permanece disponible sin conexión a Internet.

- **Interfaz accesible**  
  Íconos grandes, navegación guiada, texto breve y apoyo auditivo para niños de 5–10 años.

- **Feedback integrado**  
  Al cerrar cada actividad, el usuario puede elegir “😊” o “☹️” para registrar su satisfacción.

- **Multiplataforma**  
  Base de código única con Flutter, compatible con Android (gama media/baja) y iOS (en futuras versiones).

- **Gestión de proyecto**  
  Desarrollo ágil con SCRUM + PMBOK + Design Thinking.

---

## Requisitos

- **Flutter SDK** ≥ 3.0.0  
- **Dart SDK** incluido en Flutter  
- **Android Studio** o **Visual Studio Code** con los plugins de Flutter y Dart  
- **Dispositivo o emulador Android** con API ≥ 23  

---

## Instalación

1. **Clonar el repositorio**  
   ```bash
   git clone https://github.com/tuusuario/recreapp.git
   cd recreapp

2. **Instalar dependencias**  
   ```bash
    flutter pub get

3. **Preparar assets**  
- Asegúrate de que en pubspec.yaml estén listadas las imágenes en assets/images/
- Ejecuta:
   ```bash
    flutter pub get

---

## Configuración

   **No hay variables de entorno para esta versión offline.**
- Crear un archivo lib/config.dart con:
     ```bash
    const String API_BASE_URL = 'https://api.tudominio.com';
- Ajustar en main.dart la inicialización del cliente HTTP.

---

## Uso

1. **Ejecutar en emulador o dispositivo físico**
     ```bash
    flutter run
2. **Navegar**
- Pantalla de bienvenida → Botón “Comencemos”
- Selección de categoría → Icono de área temática
- Lista de actividades → Pulsar título de actividad
- Feedback → Elegir “😊” o “☹️”

---

## Estructura del Proyecto

     ```bash
     recreapp/
    ├── android/          
    ├── ios/              
    ├── lib/
    │   ├── main.dart            # Punto de entrada
    │   ├── theme.dart           # Paleta de colores y tipografía
    │   ├── screens/
    │   │   ├── welcome_screen.dart
    │   │   ├── categories_screen.dart
    │   │   └── activity_screen.dart
    │   ├── widgets/
    │   │   └── feedback_dialog.dart
    │   ├── models/
    │   │   └── actividad.dart
    │   ├── data/
    │   │   └── actividades_data.dart
    │   └── config.dart?          # (futuro)
    ├── assets/
    │   └── images/
    │       ├── lenguaje.png
    │       ├── matematicas.png
    │       └── ...  
    ├── pubspec.yaml         
    └── README.md           

---

## Contribuir

**¡Tu aporte es bienvenido!**
1. **Haz fork de este repositorio.**
2. **Crea una rama de feature:**
     ```bash
      git checkout -b feature/nombre-de-tu-feature
3. **Realiza tus cambios y commitea:**
     ```bash
      git commit -m "Añade nueva funcionalidad X"
3. **Haz push y abre un Pull Request.**

---

## Licencia
   **Este proyecto está bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.**

  ```bash
    ::contentReference[oaicite:0]{index=0}
