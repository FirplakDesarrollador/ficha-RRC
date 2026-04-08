-- 1. Crear tabla de Responsables
CREATE TABLE IF NOT EXISTS public.cat_responsables (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Habilitar RLS
ALTER TABLE public.cat_responsables ENABLE ROW LEVEL SECURITY;

-- 3. Políticas de acceso para cat_responsables
-- Lectura pública para usuarios autenticados
CREATE POLICY "Lectura pública cat_responsables" ON public.cat_responsables
    FOR SELECT TO authenticated USING (true);

-- Edición/Borrado solo para administradores
CREATE POLICY "Admin CRUD cat_responsables" ON public.cat_responsables
    FOR ALL TO authenticated
    USING (
        auth.jwt() ->> 'email' IN ('coordinacioncalidad@firplak.com', 'estiven.londono@firplak.com', 'estiven.londoño@firplak.com')
    );

-- 4. Insertar los 18 responsables actuales (Alphabetical)
INSERT INTO public.cat_responsables (nombre) VALUES
('Andres Saldarriaga'),
('Alejadro Vegas'),
('Carolina Escobar M.'),
('Dimer Vergara'),
('Edison Hernandez'),
('Elias Molina'),
('Estiven Londoño'),
('Jair Alvarez'),
('Jakeline Chaverra'),
('Juan David Montoya'),
('Juan David Ramirez'),
('Juliana Ramirez'),
('Maria Isabel Escobar'),
('Osnar Mejía'),
('Roberto Aguilar'),
('Sara Aguilar'),
('Solangie Baquero'),
('Yury Mar Aguas')
ON CONFLICT (nombre) DO NOTHING;
