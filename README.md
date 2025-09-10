# RecreApp

RecreApp es una app móvil **Flutter** que acerca actividades recreativas y educativas a niños y niñas.  
Esta versión incorpora **backend en Supabase (PostgreSQL + Auth)** para registro/login, perfiles **estudiante / docente**, registro de **feedback** por actividad y **reportes PDF** (general y por alumno).

---

## Tabla de contenidos

1. [Características](#características)  
2. [Tecnologías y dependencias](#tecnologías-y-dependencias)  
3. [Requisitos](#requisitos)  
4. [Instalación](#instalación)  
5. [Configuración de Supabase](#configuración-de-supabase)  
6. [Uso](#uso)  
7. [Estructura del proyecto](#estructura-del-proyecto)  
8. [Scripts SQL (tablas & RLS)](#scripts-sql-tablas--rls)  
9. [Guía de solución de problemas](#guía-de-solución-de-problemas)  
10. [Contribuir](#contribuir)  
11. [Licencia](#licencia)

---

## Características

- **Catálogo de actividades** por áreas: **Letras**, **Números**, **Experimentos**, **Cocina** y **Manualidades**.
- **Autenticación con Supabase** (email/contraseña). La **sesión se mantiene** hasta que el usuario cierre sesión manualmente.
- **Perfiles**:
  - **Estudiante**: categorías → lista de actividades → detalle → registro de **feedback** (👍 / 👎).
  - **Docente**: **Panel Docente** con:
    - Resumen general (conteo positivos/negativos).
    - Tarjetas de **alumnos** (nombre, email, total de feedbacks).
    - **Detalle por alumno** (historial y conteo).
    - **Exportación a PDF** del reporte general y por alumno.
- **Feedback persistente** en PostgreSQL (`feedback`): título, categoría, si gustó, fecha y usuario.
- **UI accesible** con **tema morado** y textos legibles sobre fondos oscuros.
- **Multiplataforma**: Android (principal). iOS/Web opcional.

---

## Tecnologías y dependencias

- **Flutter** ≥ 3.22 (Dart 3)
- **Supabase** (Auth + PostgreSQL + RLS)
- Paquetes Flutter principales:
  - `supabase_flutter`
  - `pdf` y `printing` (generación/imprimir PDF)
  - `share_plus`
  - `cupertino_icons`

---

## Requisitos

- **Flutter SDK** ≥ 3.0.0  
- **Android Studio** o **VS Code** con plugins de Flutter/Dart  
- **Emulador o dispositivo Android** (API ≥ 23)  
- **Cuenta Supabase** (plan Free) y un **proyecto** creado

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

## Configuración de Supabase

1. **Crear proyecto**  
- Entra a https://supabase.com
 → New project. Copia Project URL y anon key desde Project Settings → API.

2. **Llaves en el código**  
- Crea lib/supabase_keys.dart:
   ```bash
    // lib/supabase_keys.dart
class SupabaseKeys {
  static const String supabaseUrl = 'https://TU-PROJECT-REF.supabase.co';
  static const String supabaseAnonKey = 'TU-ANON-KEY';
}

3. **Inicialización (ya incluida en main.dart)**  
- El proyecto usa Supabase.initialize(...) con las llaves definidas arriba.
- Ejecuta:
   ```bash
    flutter pub get

4. **Tablas y RLS**  
- Abre SQL Editor de tu proyecto y ejecuta los scripts SQL.

5. **Inicialización (ya incluida en main.dart)**  
- El proyecto usa Supabase.initialize(...) con las llaves definidas arriba.

---

## Uso

1. **Ejecutar en emulador o dispositivo físico**
     ```bash
    flutter run
2. **Flujos principales**
- Inicio → botón Comencemos → Login/Registro.
- Estudiante:
  - Categorías → Actividades → Detalle → Feedback (botones con 👍 / 👎).
- Docente:
  - Resumen general (positivos/negativos).
  - Lista de alumnos (nombre, email, total de feedbacks).
  - Tap en alumno → detalle + botón para exportar PDF.
  - AppBar → ícono PDF para reporte general.

---

## Estructura del Proyecto

     ```bash
     recreapp/
     ├─ android/  ios/  web/  windows/
     ├─ lib/
     │  ├─ main.dart
     │  ├─ theme.dart
     │  ├─ supabase_keys.dart
     │  ├─ models/
     │  │  └─ actividad.dart
     │  ├─ data/
     │  │  └─ actividades_data.dart
     │  ├─ services/
     │  │  └─ auth_service.dart
     │  ├─ screens/
     │  │  ├─ welcome_screen.dart
     │  │  ├─ login_screen.dart
     │  │  ├─ register_screen.dart
     │  │  ├─ categories_screen.dart
     │  │  ├─ activity_screen.dart
     │  │  ├─ actividad_screen.dart
     │  │  └─ teacher_dashboard_screen.dart
     │  └─ widgets/
     │     └─ feedback_dialog.dart
     ├─ assets/
     │  └─ images/
     ├─ docs/
     │  └─ registro-exitoso/index.html    (opcional)
     ├─ pubspec.yaml
     └─ README.md        

---

## Scripts SQL (tablas & RLS)

1. **Tabla users**
     ```bash
    create table if not exists public.users (
     id uuid primary key default auth.uid(),
     email text unique not null,
     full_name text,
     role text check (role in ('student','teacher')) not null default 'student',
     date_of_birth date,
     created_at timestamp with time zone default now(
     );

     alter table public.users enable row level security;

     -- Ver todos los usuarios si estás autenticado (necesario para panel docente).
     create policy if not exists "users_select_authenticated"
     on public.users for select
     to authenticated
     using (true);

     -- Insertar solo tu propio registro vinculado a tu uid.
     create policy if not exists "users_insert_self"
     on public.users for insert
     to authenticated
     with check (id = auth.uid());

     -- Actualizar solo tu propio registro.
     create policy if not exists "users_update_self"
     on public.users for update
     to authenticated
     using (id = auth.uid());

2. **Tabla feedback**
     ```bash
     create table if not exists public.feedback (
     id uuid primary key default gen_random_uuid(),
     user_id uuid not null references public.users(id) on delete cascade,
     activity_title text not null,
     category text not null,
     is_positive boolean not null,
     created_at timestamp with time zone default now()
     );

     alter table public.feedback enable row level security;

     -- Insertar feedback propio
     create policy if not exists "feedback_insert_own"
     on public.feedback for insert
     to authenticated
     with check (user_id = auth.uid());

     -- Ver tu propio feedback...
     create policy if not exists "feedback_select_own"
     on public.feedback for select
     to authenticated
     using (user_id = auth.uid());

     -- ...y si eres docente ver todos
     create policy if not exists "feedback_select_teacher"
     on public.feedback for select
     to authenticated

     using (
     exists (
     select 1 from public.users u
     where u.id = auth.uid() and u.role = 'teacher'
     )
     );
 
---

## Guía de solución de problemas

**No se listan alumnos en Panel Docente**
1. Verifica que existan filas en feedback con user_id válidos.
2. Asegúrate de que la RLS de users permite select a authenticated.
3. Comprueba que el usuario logueado tenga role = 'teacher' en users.
- Error de permisos al consultar feedback
  - Revisa las políticas RLS. Para ver todo como docente, debe existir feedback_select_teacher.`
- No se guarda feedback
  - El insert exige user_id = auth.uid(). Inicia sesión y envía el user_id correcto desde la app.
- Sesión no persiste
  - Revisa que Supabase.initialize use tus llaves y no se esté limpiando el storage local en tu flujo.
- Android/Gradle warnings
  - Usa la versión de Flutter recomendada y prueba flutter pub upgrade. Si migras de proyecto, corre flutter clean && flutter pub get.

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
   Este repositorio es **privado**. El código y los recursos de **RecreApp** están protegidos por una **licencia propietaria**.  
   No se permite su uso, copia, modificación, publicación ni distribución sin autorización previa y por escrito del titular.
   
   Para permisos o dudas, escribe a **yerkojesus@outlook.com**.

