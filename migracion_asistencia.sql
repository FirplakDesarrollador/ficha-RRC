-- Tabla para el registro de asistencia diaria
create table if not exists public.registro_asistencia (
  id uuid default gen_random_uuid() primary key,
  fecha date not null,
  responsable text not null,
  estado text not null,
  created_at timestamptz default now()
);

-- Asegurar que la combinación de fecha y responsable sea única
alter table public.registro_asistencia add constraint unique_fecha_responsable unique (fecha, responsable);

-- Habilitar RLS
alter table public.registro_asistencia enable row level security;

-- Políticas
create policy "Usuarios autenticados pueden ver la asistencia"
  on public.registro_asistencia for select
  to authenticated
  using (true);

create policy "Usuarios autenticados pueden insertar asistencia"
  on public.registro_asistencia for insert
  to authenticated
  with check (true);

create policy "Usuarios autenticados pueden actualizar asistencia"
  on public.registro_asistencia for update
  to authenticated
  using (true);
