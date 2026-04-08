export type Accion = {
  accion: string;
  responsable: string;
  firma: string | null;
  fecha: string;
  cumplimiento: string;
};

export type PlantaEnum = 'Mármol Sintético' | 'Fibra de vidrio' | 'Muebles' | 'Cefi';
export type OrigenEnum = 'Saldos' | 'Destrucciones' | 'IFI' | 'Rechazos';

export interface FichaAlerta {
  id: string;
  created_at: string;
  user_id: string;
  numero_ficha: number;
  planta: PlantaEnum;
  responsable: string;
  problema: string;
  origen: OrigenEnum;
  fecha: string;
  seguimiento_entrada: string;
  seguimiento_d1: string;
  seguimiento_d2: string;
  seguimiento_d3: string;
  foto_piezas_ok: string | null;
  foto_piezas_nok: string | null;
  contingencias: Accion[];
  erradicaciones: Accion[];
}
