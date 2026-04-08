'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabaseClient';
import FirplakLogo from '@/components/FirplakLogo';

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const handleAuth = async (isSignUp: boolean) => {
    try {
      setLoading(true);
      setError(null);
      
      const { data, error: authError } = isSignUp 
        ? await supabase.auth.signUp({ email, password })
        : await supabase.auth.signInWithPassword({ email, password });
      
      if (authError) throw authError;

      if (data?.user) {
        // Successful authentication
        router.push('/');
        router.refresh();
      } else if (isSignUp) {
        setError('Check your email for the confirmation link.');
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred during authentication.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="auth-container">
      <div className="glass-panel auth-card" style={{ borderTop: '6px solid var(--header-bg)' }}>
        <div style={{ textAlign: 'center', marginBottom: '32px', background: 'var(--header-bg)', padding: '24px', borderRadius: '15px' }}>
          <FirplakLogo height="60px" style={{ margin: '0 auto' }} />
        </div>
        <h1 className="auth-title" style={{ color: 'var(--header-bg)', textAlign: 'center' }}>Ficha RRC</h1>
        <p className="auth-subtitle" style={{ textAlign: 'center' }}>Ingresa a la plataforma digital de alertas</p>

        {error && (
          <div className="auth-error">
            <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round">
              <circle cx="12" cy="12" r="10"></circle>
              <line x1="12" y1="8" x2="12" y2="12"></line>
              <line x1="12" y1="16" x2="12.01" y2="16"></line>
            </svg>
            {error}
          </div>
        )}

        <form onSubmit={(e) => { e.preventDefault(); handleAuth(false); }}>
          <input
            type="email"
            placeholder="Correo electrónico"
            className="input-field"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            autoComplete="email"
          />
          <input
            type="password"
            placeholder="Contraseña"
            className="input-field"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            minLength={6}
            autoComplete="current-password"
          />
          
          <button type="submit" className="btn-primary" disabled={loading} style={{ marginBottom: '16px' }}>
            {loading ? <div className="spinner"></div> : 'INGRESAR'}
          </button>
          
          <button 
            type="button" 
            className="btn-secondary" 
            style={{ width: '100%', padding: '14px 24px', borderRadius: '25px', textTransform: 'uppercase', fontSize: '14px' }}
            onClick={() => handleAuth(true)}
            disabled={loading}
          >
            Crear Cuenta
          </button>
        </form>
      </div>
    </div>
  );
}
