import { useTranslation } from 'react-i18next';
import BentoCard from '../components/BentoCard';
import Seo from '../components/SEO';
import './ContactPage.css';

const contactMethods = [
  { label: 'Email', value: 'contact@2c2t.dev', url: 'mailto:contact@2c2t.dev' },
  { label: 'GitHub', value: 'github.com/2c2t-dev', url: 'https://github.com/2c2t-dev' },
  { label: 'Discord', value: 'discord.2c2t.dev', url: 'https://discord.2c2t.dev/' },
  { label: 'WhatsApp', value: '+33 9 72 11 49 49', url: 'https://wa.me/33972114949' },
];

const ContactPage = () => {
  const { t } = useTranslation();

  const schema = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "ContactPage",
    "name": "2c2t.dev - " + t('contact.title'),
    "url": "https://2c2t.dev/contact",
    "description": t('contact.seo_desc')
  });

  return (
    <div className="page-content">
      <Seo 
        title={`${t('contact.title')} - 2c2t.dev`}
        description={t('contact.seo_desc')}
        schema={schema}
      />
      <div className="container">
        <div className="section-header animate-fade-in-up">
          <h1 className="brand-font">{t('contact.title')}</h1>
          <p>{t('contact.desc')}</p>
        </div>

        <div className="contact-layout">
          <div className="contact-side animate-fade-in-up delay-1">
            <h2 className="brand-font mb-4">{t('contact.methods_title')}</h2>
            <div className="contact-methods">
              {contactMethods.map((method) => (
                <a key={method.label} href={method.url} target="_blank" rel="noopener noreferrer" className="contact-link-wrapper">
                  <div className="contact-card">
                    <div className="contact-card-info">
                      <span className="contact-label brand-font">{method.label}</span>
                      <span className="contact-value">{method.value}</span>
                    </div>
                    <span className="contact-arrow">→</span>
                  </div>
                </a>
              ))}
            </div>
          </div>
          
          <div className="contact-side animate-fade-in-up delay-2">
            <BentoCard className="h-full">
              <h2 className="brand-font mb-4">{t('contact.info_title')}</h2>
              <div className="info-list">
                <div className="info-item">
                  <div className="info-icon">📍</div>
                  <div>
                    <h4 className="brand-font">{t('contact.info_location_title')}</h4>
                    <p>{t('contact.info_location_desc')}</p>
                  </div>
                </div>
                <div className="info-item">
                  <div className="info-icon">🤝</div>
                  <div>
                    <h4 className="brand-font">{t('contact.info_contrib_title')}</h4>
                    <p>{t('contact.info_contrib_desc')}</p>
                  </div>
                </div>
              </div>
            </BentoCard>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ContactPage;
