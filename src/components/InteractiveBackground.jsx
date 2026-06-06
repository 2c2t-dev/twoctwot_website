import { useEffect, useState } from 'react';
import './InteractiveBackground.css';

const InteractiveBackground = () => {
  const [mousePosition, setMousePosition] = useState({ x: 0, y: 0 });

  useEffect(() => {
    const handleMouseMove = (e) => {
      setMousePosition({
        x: e.clientX,
        y: e.clientY,
      });
    };

    window.addEventListener('mousemove', handleMouseMove);

    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
    };
  }, []);

  return (
    <div className="interactive-bg-container">
      {/* The dots pattern */}
      <div className="interactive-dots"></div>
      
      {/* The spotlight that follows the mouse */}
      <div 
        className="interactive-spotlight"
        style={{
          background: `radial-gradient(100px circle at ${mousePosition.x}px ${mousePosition.y}px, var(--accent-glow, rgba(0, 82, 255, 0.08)), transparent 80%)`
        }}
      ></div>
    </div>
  );
};

export default InteractiveBackground;
