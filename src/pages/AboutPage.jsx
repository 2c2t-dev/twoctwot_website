import { useTranslation } from 'react-i18next';
import BentoCard from '../components/BentoCard';
import Seo from '../components/SEO';
import './AboutPage.css';

const AboutPage = () => {
  const { t } = useTranslation();

  const schema = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "AboutPage",
    "name": "2c2t.dev - " + t('about.title'),
    "url": "https://2c2t.dev/about",
    "description": t('about.seo_desc')
  });

  return (
    <div className="page-content">
      <Seo 
        title={`${t('about.title')} - 2c2t.dev`}
        description={t('about.seo_desc')}
        schema={schema}
      />
      <div className="container">
        <div className="section-header animate-fade-in-up">
          <h1 className="brand-font">{t('about.title')}</h1>
          <p>{t('about.desc')}</p>
        </div>

        <div className="about-layout">
          <div className="about-main animate-fade-in-up delay-1">
            <BentoCard highlight={true} className="h-full">
              <h2 className="brand-font">{t('about.mission_title')}</h2>
              <p>{t('about.mission_desc')}</p>
              
              <h3 className="brand-font mt-4">{t('about.values_title')}</h3>
              <ul className="values-list">
                <li><strong>{t('about.val_open_title')}</strong>: {t('about.val_open_desc')}</li>
                <li><strong>{t('about.val_perf_title')}</strong>: {t('about.val_perf_desc')}</li>
                <li><strong>{t('about.val_exp_title')}</strong>: {t('about.val_exp_desc')}</li>
              </ul>
            </BentoCard>
          </div>

          <div className="about-side animate-fade-in-up delay-2">
            <BentoCard className="mb-4">
              <h3 className="brand-font">{t('about.dna_title')}</h3>
              <div className="dna-items">
                <div className="dna-item">
                  <div className="dna-icon">🖥️</div>
                  <div>
                    <h4>{t('about.dna_bm_title')}</h4>
                    <p>{t('about.dna_bm_desc')}</p>
                  </div>
                </div>
                <div className="dna-item">
                  <div className="dna-icon">🌐</div>
                  <div>
                    <h4>{t('about.dna_net_title')}</h4>
                    <p>{t('about.dna_net_desc')}</p>
                  </div>
                </div>
              </div>
            </BentoCard>

            <div className="stats-row">
              <BentoCard className="stat-bento">
                <div className="stat-value brand-font">3</div>
                <div className="stat-label">{t('about.stat_projects')}</div>
              </BentoCard>
              <BentoCard className="stat-bento">
                <div className="stat-value brand-font">4</div>
                <div className="stat-label">{t('about.stat_members')}</div>
              </BentoCard>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AboutPage;
