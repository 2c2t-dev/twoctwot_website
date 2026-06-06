import { useTranslation } from 'react-i18next';
import './Footer.css';

const Footer = () => {
  const { t } = useTranslation();
  const year = new Date().getFullYear();

  return (
    <footer className="site-footer">
      <div className="container footer-inner">
        <div className="footer-main">
          <div className="footer-brand">
            <div className="footer-logo-row">
              <img src="/assets/images/logo_2c2t.png" alt="2c2t logo" className="footer-logo" width="164" height="98" />
              <h3 className="footer-brand-name brand-font">2c2t.dev</h3>
            </div>
            <p className="footer-tagline">{t('footer.desc')}</p>
          </div>
          
          <div className="footer-nav">
            <h4 className="footer-heading">{t('footer.links')}</h4>
            <ul>
              <li><a href="https://status.2c2t.dev" target="_blank" rel="noopener noreferrer">Status</a></li>
              <li><a href="https://github.com/2c2t-dev" target="_blank" rel="noopener noreferrer">GitHub</a></li>
            </ul>
          </div>
          
          <div className="footer-contact">
            <h4 className="footer-heading">{t('footer.socials')}</h4>
            <ul>
              <li><a href="https://discord.2c2t.dev/" target="_blank" rel="noopener noreferrer">Discord</a></li>
            </ul>
          </div>
        </div>
        
        <div className="footer-bottom">
          <p>&copy; {year} 2c2t.dev. {t('footer.rights')}</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
