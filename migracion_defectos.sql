-- ==========================================
-- MIGRACIÓN: CATÁLOGO CON ORDEN NUMÉRICO
-- ==========================================

-- 1. Eliminar tabla si ya existe para recrearla con el campo 'posicion'
drop table if exists public.cat_defectos;

create table public.cat_defectos (
  id uuid default gen_random_uuid() primary key,
  planta text not null,
  nombre_defecto text not null,
  posicion integer not null, -- Campo para mantener el orden exacto
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. Habilitar RLS
alter table public.cat_defectos enable row level security;

-- 3. Políticas
create policy "Lectura pública de defectos" on public.cat_defectos for select to authenticated using (true);
create policy "Admins pueden gestionar defectos" on public.cat_defectos for all to authenticated using (auth.jwt() ->> 'email' IN ('coordinacioncalidad@firplak.com', 'estiven.londono@firplak.com'));

-- 4. Inserción con POSICIÓN (Mármol Sintético)
insert into public.cat_defectos (planta, nombre_defecto, posicion) values
('Mármol Sintético', 'Opaco', 1),
('Mármol Sintético', 'Rayas en proceso', 2),
('Mármol Sintético', '1 Gelcoat Rajado', 3),
('Mármol Sintético', '2 Rajada al Desmoldar', 4),
('Mármol Sintético', '3 Ojo de Pez', 5),
('Mármol Sintético', '4 Pintura Sucia', 6),
('Mármol Sintético', '5 Rajado por materia prima Defectuosa', 7),
('Mármol Sintético', '6 Rajado por no aflojar la Flauta', 8),
('Mármol Sintético', '7 Masa en gelcoat', 9),
('Mármol Sintético', '8 Desagüe Rajado', 10),
('Mármol Sintético', '9 Pieza mal ruteada', 11),
('Mármol Sintético', '10 Pieza dañada al Perfora', 12),
('Mármol Sintético', '12 Acumulación de Cera', 13),
('Mármol Sintético', '13 Despique por Ruteadora', 14),
('Mármol Sintético', '14 Despique por mala manipualción', 15),
('Mármol Sintético', '15 Despique en esquina por brida de rute', 16),
('Mármol Sintético', '16 Moldes con poros', 17),
('Mármol Sintético', '19 Rajada por operario', 18),
('Mármol Sintético', '20 Gotera de catalizado', 19),
('Mármol Sintético', '21 Pobre de pintura', 20),
('Mármol Sintético', '22 Pintura contaminada por otra pintura', 21),
('Mármol Sintético', '23 Pintura contaminada', 22),
('Mármol Sintético', '24 Masa gelada por partes', 23),
('Mármol Sintético', '25 Burbuja por cera', 24),
('Mármol Sintético', '26 Cera glass', 25),
('Mármol Sintético', '27 Vaciada con gelcoat fresco', 26),
('Mármol Sintético', '28 Hendidura en el desagüe', 27),
('Mármol Sintético', '29 Pintura jaspeada', 28),
('Mármol Sintético', '31 Gelcoat desmoldado', 29),
('Mármol Sintético', '35 Flauta obstruida', 30),
('Mármol Sintético', '38 Pintura chorreada', 31),
('Mármol Sintético', '39 Pintura con exceso de catalizador', 32),
('Mármol Sintético', '41 Pintura sin catalizador', 33),
('Mármol Sintético', '43 Falta de mezcla por detrás', 34),
('Mármol Sintético', '44 Fuga en la flauta', 35),
('Mármol Sintético', '66 Burbuja de aire en el acabado', 36),
('Mármol Sintético', '67 Molde Rayado', 37),
('Mármol Sintético', '68 Molde fisurado', 38),
('Mármol Sintético', '71 Tallada por manipulación', 39),
('Mármol Sintético', '72 Corrugada', 40),
('Mármol Sintético', '73 Poros en la pieza', 41),
('Mármol Sintético', '74 Piel de naranja', 42),
('Mármol Sintético', '76 Pieza pelada en acabado', 43),
('Mármol Sintético', '77 Hendidura en el bowl', 44),
('Mármol Sintético', '86 Molde despicado', 45),
('Mármol Sintético', '88 Burbuja por detrás de la pieza', 46),
('Mármol Sintético', '90 Desagüe deslaminado', 47),
('Mármol Sintético', '91 Gelcoat rajado por falta de mezcla', 48),
('Mármol Sintético', '92 Rajada por burbuja por detrás', 49),
('Mármol Sintético', '93 Corte de la pieza por disco de ruteador', 50),
('Mármol Sintético', '94 Rajada por gel por partes', 51),
('Mármol Sintético', '95 Gelcoat deslaminado al quitar rebaba', 52),
('Mármol Sintético', '96 Pieza rajada al pegarse al molde', 53),
('Mármol Sintético', '117 Desagüe desnivelado', 54),
('Mármol Sintético', '118 Desagüe grueso', 55),
('Mármol Sintético', '119 Desagüe delgado', 56),
('Mármol Sintético', '120 Despicada por broca copa', 57),
('Mármol Sintético', '121 Despicada por falta de mezcla', 58),
('Mármol Sintético', '122 Despique en flauta', 59),
('Mármol Sintético', '123 Rajada por geometría de molde', 60),
('Mármol Sintético', '124 Rajada al quitar el contramolde', 61),
('Mármol Sintético', '126 Rajada por golpe en el proceso', 62),
('Mármol Sintético', '127 Rajada en el proceso', 63),
('Mármol Sintético', '128 Flauta torcida', 64),
('Mármol Sintético', '129 Despique en la línea', 65),
('Mármol Sintético', '131 Despique al quitar rebaba', 66),
('Mármol Sintético', '132 Falta de mezcla por detrás', 67),
('Mármol Sintético', '133 Pestaña deslaminada', 68);

-- 5. Inserción con POSICIÓN (Muebles)
insert into public.cat_defectos (planta, nombre_defecto, posicion) values
('Muebles', '1 DESPIQUE EN CORTE', 1), ('Muebles', '2 RAYAS', 2), ('Muebles', '3 TALLONES', 3), ('Muebles', '4 CANTO DESPEGADO', 4), ('Muebles', '5 CANTO RAYADO', 5), ('Muebles', '6 CANTO TALLADO', 6), ('Muebles', '7 SIN CANTO', 7), ('Muebles', '8 PERFORACIÓN DESFASADA', 8), ('Muebles', '9 PERFORACIÓN DESPICADA', 9), ('Muebles', '10 SIN PERFORACIÓN', 10), ('Muebles', '11 ESCALA EN CORTE', 11), ('Muebles', '12 ESCALA AL ENSAMBLAR', 12), ('Muebles', '13 DESPIQUE POR MANIPULACION', 13), ('Muebles', '14 DIMENSIONES INCORRECTAS', 14), ('Muebles', '15 HERRAJE INCOMPLETO', 15), ('Muebles', '16 MUEBLE INCOMPLETO', 16), ('Muebles', '17 DESPIQUE EN ENCHAPE', 17), ('Muebles', '18 CANTO DESPLAZADO', 18), ('Muebles', '19 CANTO CORTO', 19), ('Muebles', '20 CANTO LARGO', 20), ('Muebles', '21 CONTAMINACIÓN EN LAMINA', 21), ('Muebles', '22 EXCESO DE PEGA', 22), ('Muebles', '23 CANTO CURVO DESPAGADO', 23), ('Muebles', '24 PERFORACION DESPICADA POR MINIFIX', 24), ('Muebles', '25 RISADO', 25), ('Muebles', '26 MELAMINA REVENTADA', 26), ('Muebles', '27 PERFORACIONES INCORRECTAS', 27), ('Muebles', '28 SOBREPRENSADO', 28), ('Muebles', '29 DOBLE CANTO', 29), ('Muebles', '30 CANTO DESPICADO', 30), ('Muebles', '31 CANTO ANCHO', 31), ('Muebles', '32 MELAMINA ROTA', 32), ('Muebles', '33 SIN RANURA', 33), ('Muebles', '34 SIN PERFORACION PASANTE', 34), ('Muebles', '35 LAGUNA DE RESINA', 35), ('Muebles', '36 MELAMINA PELADA', 36), ('Muebles', '37 TALLADA AL PERFORAR', 37), ('Muebles', '38 RANURA DESPICADA', 38), ('Muebles', '39 HERRAJE INCORRECTO', 39), ('Muebles', '40 TALLON POR ENCHAPADORA', 40), ('Muebles', '41 PIEZA SUCIO O ENGRASADA', 41), ('Muebles', '42 LUZ EN CANTO', 42);

-- 6. Inserción con POSICIÓN (Cefi)
insert into public.cat_defectos (planta, nombre_defecto, posicion) values
('Cefi', '1 DESPIQUE EN CORTE', 1), ('Cefi', '2 RAYAS', 2), ('Cefi', '3 TALLONES', 3), ('Cefi', '4 CANTO DESPEGADO', 4), ('Cefi', '5 CANTO RAYADO', 5), ('Cefi', '6 CANTO TALLADO', 6), ('Cefi', '7 SIN CANTO', 7), ('Cefi', '8 PERFORACIÓN DESFASADA', 8), ('Cefi', '9 PERFORACIÓN DESPICADA', 9), ('Cefi', '10 SIN PERFORACIÓN', 10), ('Cefi', '11 ESCALA EN CORTE', 11), ('Cefi', '12 ESCALA AL ENSAMBLAR', 12), ('Cefi', '13 DESPIQUE POR MANIPULACION', 13), ('Cefi', '14 DIMENSIONES INCORRECTAS', 14), ('Cefi', '15 HERRAJE INCOMPLETO', 15), ('Cefi', '16 MUEBLE INCOMPLETO', 16), ('Cefi', '17 DESPIQUE EN ENCHAPE', 17), ('Cefi', '18 CANTO DESPLAZADO', 18), ('Cefi', '19 CANTO CORTO', 19), ('Cefi', '20 CANTO LARGO', 20), ('Cefi', '21 CONTAMINACIÓN EN LAMINA', 21), ('Cefi', '22 EXCESO DE PEGA', 22), ('Cefi', '23 CANTO CURVO DESPAGADO', 23), ('Cefi', '24 PERFORACION DESPICADA POR MINIFIX', 24), ('Cefi', '25 RISADO', 25), ('Cefi', '26 MELAMINA REVENTADA', 26), ('Cefi', '27 PERFORACIONES INCORRECTAS', 27), ('Cefi', '28 SOBREPRENSADO', 28), ('Cefi', '29 DOBLE CANTO', 29), ('Cefi', '30 CANTO DESPICADO', 30), ('Cefi', '31 CANTO ANCHO', 31), ('Cefi', '32 MELAMINA ROTA', 32), ('Cefi', '33 SIN RANURA', 33), ('Cefi', '34 SIN PERFORACION PASANTE', 34), ('Cefi', '35 LAGUNA DE RESINA', 35), ('Cefi', '36 MELAMINA PELADA', 36), ('Cefi', '37 TALLADA AL PERFORAR', 37), ('Cefi', '38 RANURA DESPICADA', 38), ('Cefi', '39 HERRAJE INCORRECTO', 39), ('Cefi', '40 TALLON POR ENCHAPADORA', 40), ('Cefi', '41 PIEZA SUCIO O ENGRASADA', 41), ('Cefi', '42 LUZ EN CANTO', 42);

-- 7. Inserción con POSICIÓN (Fibra de vidrio)
insert into public.cat_defectos (planta, nombre_defecto, posicion) values
('Fibra de vidrio', '1 REVENTADA POR PESTAÑA DELGADA', 1), ('Fibra de vidrio', '2 RAYAS PROFUNDAS', 2), ('Fibra de vidrio', '3 TALLONES', 3), ('Fibra de vidrio', '4 RAYAS DE ORBITA', 4), ('Fibra de vidrio', '5 ACUMULACIÓN DE ESTIRENO', 5), ('Fibra de vidrio', '7 PINTURA SUCIA', 6), ('Fibra de vidrio', '9 MAL RUTEADA', 7), ('Fibra de vidrio', '10 DAÑADA AL PERFORAR', 8), ('Fibra de vidrio', '11 MOLDE CON HUECOS', 9), ('Fibra de vidrio', '12 MOLDE CON POROS', 10), ('Fibra de vidrio', '13 PIEZA DESPICADA', 11), ('Fibra de vidrio', '21 POBRE DE PINTURA', 12), ('Fibra de vidrio', '23 PINTURA CONTAMINADA', 13), ('Fibra de vidrio', '26 CERA EN LA PIEZA', 14), ('Fibra de vidrio', '29 PINTURA JASPEADA', 15), ('Fibra de vidrio', '31 GELCOAT DESMOLDADO', 16), ('Fibra de vidrio', '38 PINTURA CHORREADA', 17), ('Fibra de vidrio', '40 REVENTADA AL DESMOLDAR', 18), ('Fibra de vidrio', '68 FISURADA POR MOLDE', 19), ('Fibra de vidrio', '73 POROS', 20), ('Fibra de vidrio', '74 PIEL DE NARANJA', 21), ('Fibra de vidrio', '75 BURBUJA POR ASENTAMIENTO', 22), ('Fibra de vidrio', '116 MARCACIÓN DE FIBRA', 23), ('Fibra de vidrio', '119 FALDÓN REVENTADO', 24), ('Fibra de vidrio', '120 MARCACIÓN DE REPARACION DLE MOLDE', 25), ('Fibra de vidrio', '126 REVENTADA POR GOLPE O MALA MANIPULACIÓN EN EL PROCESo', 26);

-- ==========================================
-- POLÍTICAS ADICIONALES PARA FICHAS DE ALERTA
-- ==========================================

create policy "Admins pueden eliminar cualquier ficha"
  on public.fichas_alerta for delete
  to authenticated
  using (
    auth.jwt() ->> 'email' IN ('coordinacioncalidad@firplak.com', 'estiven.londono@firplak.com')
  );

create policy "Admins pueden editar cualquier ficha"
  on public.fichas_alerta for update
  to authenticated
  using (
    auth.jwt() ->> 'email' IN ('coordinacioncalidad@firplak.com', 'estiven.londono@firplak.com')
  );
