# Drivo-Flutter

MVP académico móvil (iOS y Android) de Drivo, marketplace salvadoreño de alquiler de autos entre particulares.

Antes de cualquier cambio, lee `docs/CONTEXTO.md`: objetivo, reglas de negocio, esquema, RLS, arquitectura, módulos, alcance y la lista de tareas por fase (sección 13).

- Backend: Supabase `drivo-db-dummy`. Nunca usar el proyecto del repo oficial.
- Pagos: siempre simulados. Nunca guardar datos de tarjeta.
- Los montos de una reserva los calcula el servidor (`quote_booking`, `create_booking`); la app no envía precios.
- Si cambias una regla, una tabla o una política RLS, actualiza `docs/CONTEXTO.md` en el mismo cambio.
