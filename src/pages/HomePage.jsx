import { NavLink } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import BentoCard from '../components/BentoCard';
import Seo from '../components/SEO';
import InteractiveBackground from '../components/InteractiveBackground';
import './HomePage.css';

const HomePage = () => {
  const { t } = useTranslation();

  const projectCards = [
    {
      title: 'GetISO',
      desc: t('project_getiso.desc'),
      tags: ['Web', 'Haute Vitesse'],
      highlight: true,
    },
    {
      title: 'NetISO',
      desc: t('project_netiso.desc'),
      tags: ['PXE', 'Réseau'],
      highlight: false,
    },
    {
      title: 'BootISO',
      desc: t('project_bootiso.desc'),
      tags: ['Desktop', 'USB'],
      highlight: false,
    },
  ];

  const techStack = [
    'Virtualisation KVM', 
    'Conteneurisation (LXC / Docker)', 
    'Boot Réseau (PXE / iPXE)', 
    'Routage Avancé (MikroTik)', 
    'Déploiement Automatisé (CI/CD)', 
    'Linux (Debian / Alpine)', 
    'Réseau DN42'
  ];

  const schema = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "WebSite",
    "name": "2c2t.dev",
    "url": "https://2c2t.dev/"
  });

  return (
    <>
      <InteractiveBackground />
      <div className="page-content">
        <Seo 
          title="2c2t.dev - L'innovation par l'expérimentation"
          description={t('home.seo_desc')}
          schema={schema}
        />
      {/* Hero */}
      <section className="hero container" id="hero">
        <div className="hero-inner">
          <img 
            src="/assets/images/logo_2c2t.png" 
            alt="2c2t.dev logo" 
            width="100"
            height="56"
            className="animate-fade-in-up" 
            style={{ height: '56px', width: 'auto', objectFit: 'contain', marginBottom: '1.5rem' }} 
          />
          <h1 className="hero-title animate-fade-in-up delay-1">
            2c2t.dev
          </h1>
          <p className="hero-subtitle animate-fade-in-up delay-2" style={{ fontSize: '1.5rem', color: 'var(--accent-primary)', fontWeight: 600 }}>
            {t('home.subtitle1')}
          </p>
          <p className="hero-subtitle animate-fade-in-up delay-3" style={{ marginTop: '-1.5rem' }}>
            {t('home.subtitle2')}
          </p>
          <div className="hero-actions animate-fade-in-up delay-3">
            <NavLink to="/projects" className="btn btn-primary">
              {t('home.btn_explore')}
            </NavLink>
            <NavLink to="/about" className="btn btn-outline">
              {t('home.btn_about')}
            </NavLink>
          </div>
        </div>
      </section>

      {/* Projects Bento */}
      <section className="section container" id="projects-preview">
        <div className="section-header animate-fade-in-up">
          <h2 className="brand-font">{t('home.projects_title')}</h2>
          <p>{t('home.projects_desc')}</p>
        </div>

        <div className="bento-grid-projects">
          {projectCards.map((project, i) => (
            <div key={project.title} className={`animate-fade-in-up delay-${i + 2}`}>
              <BentoCard highlight={project.highlight}>
                <div className="bento-project-inner">
                  <h3 className="brand-font">{project.title}</h3>
                  <p>{project.desc}</p>
                  <div className="project-tags">
                    {project.tags.map(tag => <span key={tag} className="tag">{tag}</span>)}
                  </div>
                </div>
              </BentoCard>
            </div>
          ))}
        </div>
      </section>

      {/* Tech Stack */}
      <section className="section container" id="tech-stack">
        <div className="tech-stack-container animate-fade-in-up delay-3">
          <h3 className="brand-font">{t('home.tech_title')}</h3>
          <div className="tech-tags">
            {techStack.map((tech) => (
              <span key={tech} className="tech-chip">{tech}</span>
            ))}
          </div>
        </div>
      </section>

      {/* Community */}
      <section className="section container" id="community">
        <div className="section-header animate-fade-in-up">
          <h2 className="brand-font">{t('home.community_title')}</h2>
          <p>{t('home.community_desc')}</p>
        </div>

        <div className="community-grid">
          <div className="animate-fade-in-up delay-2">
            <BentoCard className="community-card discord-card">
              <div className="community-icon">💬</div>
              <h3 className="brand-font">{t('home.discord_title')}</h3>
              <p>{t('home.discord_desc')}</p>
              <a href="https://discord.2c2t.dev/" target="_blank" rel="noopener noreferrer" className="btn btn-primary mt-auto">
                {t('home.btn_discord')}
              </a>
            </BentoCard>
          </div>

          <div className="animate-fade-in-up delay-3">
            <BentoCard className="community-card github-card">
              <div className="community-icon">🐙</div>
              <h3 className="brand-font">{t('home.github_title')}</h3>
              <p>{t('home.github_desc')}</p>
              <a href="https://github.com/2c2t-dev" target="_blank" rel="noopener noreferrer" className="btn btn-outline mt-auto">
                {t('home.btn_github')}
              </a>
            </BentoCard>
          </div>
        </div>
      </section>
    </div>
    </>
  );
};

export default HomePage;
