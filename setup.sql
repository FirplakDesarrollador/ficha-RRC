-- 1. Crear la tabla de fichas de alerta
create table if not exists public.fichas_alerta (
  id uuid default gen_random_uuid() primary key,
  created_at timestamptz default now(),
  user_id uuid references auth.users not null,
  numero_ficha int8 generated always as identity,
  planta text not null,
  responsable text not null,
  origen text not null,
  fecha date not null,
  problema text not null,
  seguimiento_entrada text,
  seguimiento_d1 text,
  seguimiento_d2 text,
  seguimiento_d3 text,
  foto_piezas_ok text,
  foto_piezas_nok text,
  contingencias jsonb default '[]'::jsonb,
  erradicaciones jsonb default '[]'::jsonb
);

-- 2. Habilita RLS (Row Level Security)
alter table public.fichas_alerta enable row level security;

-- 3. Crear políticas para que los usuarios autenticados puedan interactuar con la tabla
create policy "Usuarios autenticados pueden ver todas las fichas"
  on public.fichas_alerta for select
  to authenticated
  using (true);

create policy "Usuarios pueden insertar sus propias fichas"
  on public.fichas_alerta for insert
  to authenticated
  with check (auth.uid() = user_id);

-- 4. Asegurarse de que el bucket de storage exista y sea público
-- Nota: Esto se hace desde la interfaz de Supabase (Storage), 
-- pero aquí dejamos las políticas para el bucket 'fichas-media'
-- (asumiendo que crearás el bucket llamado 'fichas-media')

-- Política para permitir subir archivos al bucket 'fichas-media'
create policy "Permitir subida de imágenes a usuarios autenticados"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'fichas-media');

create policy "Permitir acceso público a las imágenes"
  on storage.objects for select
  to public
  using (bucket_id = 'fichas-media');
