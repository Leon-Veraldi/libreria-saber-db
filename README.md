# Sistema de Gestión de Librería "El Saber"

Este proyecto consiste en el diseño e implementación de un sistema de base de datos relacional para la gestión integral de la librería **"El Saber"**. Desarrollado como parte de la materia **Bases de Datos** para la **Escuela Técnica N°21 de 10 "Fragata Libertad"** (5to 1ra - Computación T.M.).

## Descripción del Proyecto
El sistema permite administrar de forma eficiente el catálogo de libros, autores, editoriales, clientes y el flujo completo del registro de ventas de la librería.

### Alcance del Sistema
* **Gestión de Catálogo:** Control de libros con información detallada de editoriales y autores.
* **Clientes:** Registro y control del historial de compras.
* **Stock:** Administración en tiempo real del inventario de libros.
* **Reportes:** Generación de reportes de ventas optimizados mediante Stored Procedures.
* **Trazabilidad:** Seguimiento completo de cada transacción a través de tablas de detalle[cite: 1].

---

## Modelo de Datos & Esquema Físico
La base de datos está implementada sobre el motor **MySQL 8.x** utilizando la codificación `utf8mb4` para garantizar soporte completo de caracteres[cite: 1].

### Entidades y Relaciones Principales (DER)
* `EDITORIAL` (1) ── *publica* ── (N) `LIBRO`[cite: 1]
* `AUTOR` (N) ── *escribe* ── (N) `LIBRO` *(A través de la tabla intermedia `libro_autor`)*[cite: 1]
* `CLIENTE` (1) ── *realiza* ── (N) `VENTA`[cite: 1]
* `VENTA` (1) ── *contiene* ── (N) `DETALLE_VENTA`[cite: 1]
* `LIBRO` (1) ── *aparece en* ── (N) `DETALLE_VENTA`[cite: 1]

> El diagrama Entidad-Relación visual se encuentra disponible en la carpeta `/diagrama`[cite: 1].

---

## Estructura del Repositorio
El proyecto está organizado de la siguiente manera:

```text
├── diagrama/
│   └── MER_Libreria.drawio.png      # Diagrama Entidad-Relación visual
├── doc/
│   └── Proyecto_Final_BD.docx       # Documentación final del proyecto
├── sql/
│   ├── 01_crear_base.sql            # Inicialización y codificación de la BD
│   ├── 02_crear_tablas.sql          # Estructura física y restricciones (PK/FK)
│   ├── 03_insertar_datos.sql        # Datos de prueba para simulación
│   ├── 04_stored_procedure.sql      # Lógica de reportes optimizada
│   └── Modelo_Fisico.jpeg           # Captura técnica del modelo físico
└── README.md                        # Presentación del proyecto
