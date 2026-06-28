import { useTranslation } from 'react-i18next';
import Seo from '../components/SEO';
import './LegalPage.css';

const LegalPage = () => {
  const { t } = useTranslation();

  return (
    <>
      <Seo 
        title={`${t('legal.title')} | 2c2t.dev`}
        description={t('legal.seo_desc')}
      />
      <div className="page-container legal-page">
        <div className="container">
          <header className="page-header">
            <h1 className="page-title">{t('legal.title')}</h1>
            <p className="page-subtitle">{t('legal.desc')}</p>
          </header>

          <div className="legal-content">
            <section className="legal-section">
              <h2>1. Éditeur du site</h2>
              <p>Le site 2c2t.dev est édité par le collectif 2c2t.</p>
              <p>Contact : contact@2c2t.dev</p>
            </section>

            <section className="legal-section">
              <h2>2. Hébergement</h2>
              <p>Ce site est hébergé par Cloudflare Pages (Cloudflare, Inc.)</p>
              <p>Adresse : 101 Townsend St, San Francisco, CA 94107, États-Unis</p>
            </section>

            <section className="legal-section">
              <h2>3. Propriété intellectuelle</h2>
              <p>L'ensemble de ce site relève de la législation sur le droit d'auteur et la propriété intellectuelle. Tous les droits de reproduction sont réservés, y compris pour les documents téléchargeables et les représentations iconographiques et photographiques.</p>
            </section>

            <section className="legal-section">
              <h2>4. Données personnelles</h2>
              <p>Conformément à la réglementation applicable en matière de protection des données personnelles, vous disposez d'un droit d'accès, de rectification et de suppression des données vous concernant. Pour exercer ce droit, vous pouvez nous contacter via l'adresse mentionnée ci-dessus.</p>
            </section>
          </div>
        </div>
      </div>
    </>
  );
};

export default LegalPage;
