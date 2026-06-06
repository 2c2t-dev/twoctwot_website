import { useTranslation } from 'react-i18next';
import BentoCard from '../components/BentoCard';
import Seo from '../components/SEO';
import './AboutPage.css';

const AboutPage = () => {
  const { t } = useTranslation();

  const schema = JSON.stringify({
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "AboutPage",
        "name": "2c2t.dev - " + t('about.title'),
        "url": "https://2c2t.dev/about",
        "description": t('about.seo_desc')
      },
      {
        "@type": "FAQPage",
        "mainEntity": [
          {
            "@type": "Question",
            "name": t('about.faq_q1', "Qu'est-ce que 2c2t.dev ?"),
            "acceptedAnswer": {
              "@type": "Answer",
              "text": t('about.faq_a1', "2c2t.dev est un collectif de passionnés d'infrastructure, de réseau et d'auto-hébergement créant des outils open-source.")
            }
          },
          {
            "@type": "Question",
            "name": t('about.faq_q2', "Comment puis-je contribuer ?"),
            "acceptedAnswer": {
              "@type": "Answer",
              "text": t('about.faq_a2', "Vous pouvez contribuer en rejoignant notre serveur Discord ou en proposant des Pull Requests sur nos dépôts GitHub.")
            }
          }
        ]
      }
    ]
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

        <div className="section-header animate-fade-in-up delay-3 mt-8">
          <h2 className="brand-font">{t('about.faq_title', 'Questions Fréquentes')}</h2>
        </div>
        <div className="faq-layout animate-fade-in-up delay-3">
          <BentoCard className="mb-4">
            <h3 className="brand-font">{t('about.faq_q1', "Qu'est-ce que 2c2t.dev ?")}</h3>
            <p>{t('about.faq_a1', "2c2t.dev est un collectif de passionnés d'infrastructure, de réseau et d'auto-hébergement créant des outils open-source.")}</p>
          </BentoCard>
          <BentoCard>
            <h3 className="brand-font">{t('about.faq_q2', "Comment puis-je contribuer ?")}</h3>
            <p>{t('about.faq_a2', "Vous pouvez contribuer en rejoignant notre serveur Discord ou en proposant des Pull Requests sur nos dépôts GitHub.")}</p>
          </BentoCard>
        </div>
      </div>
    </div>
  );
};

export default AboutPage;
