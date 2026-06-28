import { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { Link } from 'react-router-dom';
import './SiteNotice.css';

const SiteNotice = () => {
  const { t } = useTranslation();
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    const consent = localStorage.getItem('2c2t_cookie_consent');
    if (!consent) {
      setIsVisible(true);
    }
  }, []);

  const handleAccept = () => {
    localStorage.setItem('2c2t_cookie_consent', 'accepted');
    setIsVisible(false);
  };

  const handleDecline = () => {
    localStorage.setItem('2c2t_cookie_consent', 'declined');
    setIsVisible(false);
  };

  if (!isVisible) return null;

  return (
    <div className="cookie-consent-overlay">
      <div className="cookie-consent-box">
        <div className="cookie-content">
          <p>{t('cookie_consent.text')}</p>
        </div>
        <div className="cookie-actions">
          <Link to="/cookies" className="cookie-link" onClick={() => setIsVisible(false)}>
            {t('cookie_consent.learn_more')}
          </Link>
          <div className="cookie-btn-group">
            <button className="btn btn-outline" onClick={handleDecline}>
              {t('cookie_consent.decline')}
            </button>
            <button className="btn btn-primary" onClick={handleAccept}>
              {t('cookie_consent.accept')}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SiteNotice;
