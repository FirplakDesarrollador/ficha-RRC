'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabaseClient';
import FirplakLogo from '@/components/FirplakLogo';
import Link from 'next/link';

// Correos autorizados para el módulo de administrador
const ADMIN_EMAILS = [
  'coordinacioncalidad@firplak.com', 
  'estiven.londono@firplak.com', 
  'estiven.londoño@firplak.com'
];

export default function LandingPage() {
  const router = useRouter();
  const [user, setUser] = useState<any>(null);
  const [isAdmin, setIsAdmin] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const checkUser = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) {
        router.push('/login');
      } else {
        setUser(session.user);
        // Verificamos si el usuario es administrador
        const userEmail = session.user.email?.toLowerCase() || '';
        const adminFound = ADMIN_EMAILS.some(email => email.toLowerCase() === userEmail);
        setIsAdmin(adminFound);
        setLoading(false);
      }
    };
    checkUser();
  }, [router]);

  if (loading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', background: 'var(--bg-gradient)' }}>
        <div className="spinner"></div>
      </div>
    );
  }

  return (
    <div className="home-container" style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', gap: '40px', padding: '40px 20px' }}>
      
      {/* Logo Firplak Estetizado */}
      <div style={{ 
        background: 'var(--header-bg)', 
        padding: '30px 60px', 
        borderRadius: '25px', 
        boxShadow: '0 15px 40px rgba(0,0,0,0.15)', 
        marginBottom: '20px',
        transition: 'transform 0.3s ease'
      }}>
        <FirplakLogo height="100px" />
      </div>
      
      <div style={{ 
        display: 'grid', 
        gridTemplateColumns: `repeat(auto-fit, minmax(280px, 1fr))`, 
        gap: '30px', 
        maxWidth: '1100px', 
        width: '100%' 
      }}>
        
        {/* Módulo 1: Nueva Ficha */}
        <Link href="/fichas/crear" style={{ textDecoration: 'none' }}>
           <div className="glass-panel" style={{ 
             padding: '40px', 
             textAlign: 'center', 
             cursor: 'pointer', 
             transition: 'all 0.3s ease', 
             display: 'flex', 
             flexDirection: 'column', 
             alignItems: 'center', 
             gap: '20px', 
             height: '100%',
             borderTop: '5px solid var(--primary)',
             boxShadow: '0 4px 15px rgba(0,0,0,0.05)'
           }}
           onMouseOver={e => {
             e.currentTarget.style.transform = 'translateY(-10px)';
             e.currentTarget.style.boxShadow = '0 15px 35px rgba(0,0,0,0.1)';
           }}
           onMouseOut={e => {
             e.currentTarget.style.transform = 'translateY(0)';
             e.currentTarget.style.boxShadow = '0 4px 15px rgba(0,0,0,0.05)';
           }}>
              <div style={{ background: 'var(--primary)', color: '#fff', width: '70px', height: '70px', borderRadius: '50%', display: 'flex', justifyContent: 'center', alignItems: 'center', fontSize: '36px', fontWeight: 'bold' }}>+</div>
              <h2 style={{ margin: 0, color: 'var(--primary)', fontSize: '24px' }}>Nueva Ficha de Alerta</h2>
              <p style={{ color: 'var(--text-muted)', fontSize: '15px', lineHeight: '1.5' }}>Registrar un nuevo hallazgo o defecto detectado en cualquiera de las plantas.</p>
           </div>
        </Link>

        {/* Módulo 2: Historial */}
        <Link href="/historial" style={{ textDecoration: 'none' }}>
           <div className="glass-panel" style={{ 
             padding: '40px', 
             textAlign: 'center', 
             cursor: 'pointer', 
             transition: 'all 0.3s ease', 
             display: 'flex', 
             flexDirection: 'column', 
             alignItems: 'center', 
             gap: '20px', 
             height: '100%',
             borderTop: '5px solid var(--header-bg)',
             boxShadow: '0 4px 15px rgba(0,0,0,0.05)'
           }}
           onMouseOver={e => {
             e.currentTarget.style.transform = 'translateY(-10px)';
             e.currentTarget.style.boxShadow = '0 15px 35px rgba(0,0,0,0.1)';
           }}
           onMouseOut={e => {
             e.currentTarget.style.transform = 'translateY(0)';
             e.currentTarget.style.boxShadow = '0 4px 15px rgba(0,0,0,0.05)';
           }}>
              <div style={{ background: 'var(--header-bg)', color: '#fff', width: '70px', height: '70px', borderRadius: '50%', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                <svg viewBox="0 0 24 24" width="40" height="40" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
              </div>
              <h2 style={{ margin: 0, color: 'var(--primary)', fontSize: '24px' }}>Historial de Fichas</h2>
              <p style={{ color: 'var(--text-muted)', fontSize: '15px', lineHeight: '1.5' }}>Consulta y seguimiento de todas las fichas generadas anteriormente.</p>
           </div>
        </Link>

        {/* Módulo 3: Administrador (Solo Admins) */}
        {isAdmin && (
          <Link href="/admin" style={{ textDecoration: 'none' }}>
            <div className="glass-panel" style={{ 
              padding: '40px', 
              textAlign: 'center', 
              cursor: 'pointer', 
              transition: 'all 0.3s ease', 
              display: 'flex', 
              flexDirection: 'column', 
              alignItems: 'center', 
              gap: '20px', 
              height: '100%',
              borderTop: '5px solid #333',
              boxShadow: '0 4px 15px rgba(0,0,0,0.05)'
            }}
            onMouseOver={e => {
              e.currentTarget.style.transform = 'translateY(-10px)';
              e.currentTarget.style.boxShadow = '0 15px 35px rgba(0,0,0,0.1)';
            }}
            onMouseOut={e => {
              e.currentTarget.style.transform = 'translateY(0)';
              e.currentTarget.style.boxShadow = '0 4px 15px rgba(0,0,0,0.05)';
            }}>
                <div style={{ background: '#333', color: '#fff', width: '70px', height: '70px', borderRadius: '50%', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                  <svg viewBox="0 0 24 24" width="40" height="40" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                </div>
                <h2 style={{ margin: 0, color: 'var(--primary)', fontSize: '24px' }}>Administrador</h2>
                <p style={{ color: 'var(--text-muted)', fontSize: '15px', lineHeight: '1.5' }}>Gestionar catálogos de defectos y configuraciones del sistema.</p>
            </div>
          </Link>
        )}
      </div>

      <button 
        onClick={async () => { await supabase.auth.signOut(); router.push('/login'); }} 
        className="btn-secondary" 
        style={{ marginTop: '30px', padding: '12px 24px' }}>
        Cerrar Sesión
      </button>
    </div>
  );
}
