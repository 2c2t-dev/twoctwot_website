import PropTypes from 'prop-types';
import './BentoCard.css';

const BentoCard = ({ children, className = '', highlight = false }) => {
  return (
    <div className={`bento-card ${highlight ? 'highlight' : ''} ${className}`}>
      {children}
    </div>
  );
};

BentoCard.propTypes = {
  children: PropTypes.node.isRequired,
  className: PropTypes.string,
  highlight: PropTypes.bool,
};

export default BentoCard;
