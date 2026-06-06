import './BentoCard.css';

const BentoCard = ({ children, className = '', highlight = false }) => {
  return (
    <div className={`bento-card ${highlight ? 'highlight' : ''} ${className}`}>
      {children}
    </div>
  );
};

export default BentoCard;
