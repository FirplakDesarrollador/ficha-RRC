import React from 'react';

interface FirplakLogoProps {
  height?: string;
  width?: string;
  light?: boolean;
}

const FirplakLogo: React.FC<FirplakLogoProps> = ({ 
  height = '60px', 
  width = 'auto',
  light = true 
}) => {
  const logoSrc = light ? '/logo-firplak-white.png' : '/logo-firplak.png';
  
  return (
    <div style={{ display: 'flex', alignItems: 'center' }}>
      <img 
        src={logoSrc} 
        alt="FIRPLAK" 
        style={{ 
          height: height, 
          width: width, 
          objectFit: 'contain',
          display: 'block' 
        }} 
      />
    </div>
  );
};

export default FirplakLogo;
