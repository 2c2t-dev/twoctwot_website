import { useEffect, useRef } from 'react';
import './InteractiveBackground.css';

const InteractiveBackground = () => {
  const spotlightRef = useRef(null);

  useEffect(() => {
    const handleMouseMove = (e) => {
      if (spotlightRef.current) {
        spotlightRef.current.style.setProperty('--mouse-x', `${e.clientX}px`);
        spotlightRef.current.style.setProperty('--mouse-y', `${e.clientY}px`);
      }
    };

    globalThis.addEventListener('mousemove', handleMouseMove);

    return () => {
      globalThis.removeEventListener('mousemove', handleMouseMove);
    };
  }, []);

  return (
    <div className="interactive-bg-container">
      {/* The dots pattern */}
      <div className="interactive-dots"></div>
      
      {/* The spotlight that follows the mouse */}
      <div 
        ref={spotlightRef}
        className="interactive-spotlight"
      ></div>
    </div>
  );
};

export default InteractiveBackground;
