import { useTranslation } from 'react-i18next';
import BentoCard from '../components/BentoCard';
import Seo from '../components/SEO';
import './ProjectsPage.css';

const ProjectsPage = () => {
  const { t } = useTranslation();

  const projects = [
    {
      title: 'GetISO',
      tagline: t('project_getiso.tagline'),
      description: t('project_getiso.desc'),
      tags: ['Web', 'Direct'],
      status: t('status.active'),
      githubUrl: 'https://github.com/2c2t-dev',
      demoUrl: 'https://getiso.2c2t.dev',
      highlight: true,
    },
    {
      title: 'NetISO',
      tagline: t('project_netiso.tagline'),
      description: t('project_netiso.desc'),
      tags: ['PXE', 'iPXE', 'Réseau'],
      status: t('status.upcoming'),
      githubUrl: 'https://github.com/2c2t-dev',
      highlight: false,
    },
    {
      title: 'BootISO',
      tagline: t('project_bootiso.tagline'),
      description: t('project_bootiso.desc'),
      tags: ['Desktop', 'USB', 'Cross-Platform'],
      status: t('status.indev'),
      highlight: false,
    },
  ];

  const schema = JSON.stringify({
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "CollectionPage",
        "name": "2c2t.dev - " + t('projects.title'),
        "url": "https://2c2t.dev/projects",
        "description": t('projects.seo_desc')
      },
      ...projects.map(project => ({
        "@type": "SoftwareApplication",
        "name": project.title,
        "description": project.description,
        "applicationCategory": "DeveloperApplication",
        "operatingSystem": project.title === 'BootISO' ? "Windows, macOS, Linux" : "Linux, Web",
        "offers": {
          "@type": "Offer",
          "price": "0",
          "priceCurrency": "EUR"
        }
      }))
    ]
  });

  return (
    <div className="page-content">
      <Seo 
        title={`${t('projects.title')} - 2c2t.dev`}
        description={t('projects.seo_desc')}
        schema={schema}
      />
      <div className="container">
        <div className="section-header animate-fade-in-up">
          <h1 className="brand-font">{t('projects.title')}</h1>
          <p>{t('projects.desc')}</p>
        </div>

        <div className="projects-layout">
          {projects.map((project, i) => (
            <div key={project.title} className={`animate-fade-in-up delay-${i + 2}`}>
              <BentoCard highlight={project.highlight}>
                <div className="project-detail">
                  <div className="project-header">
                    <div>
                      <h2 className="brand-font">{project.title}</h2>
                      <span className="project-tagline">{project.tagline}</span>
                    </div>
                    <div className="project-status">
                      <span className="status-dot"></span>
                      {project.status}
                    </div>
                  </div>
                  
                  <p className="project-desc">{project.description}</p>
                  
                  <div className="project-footer">
                    <div className="project-tags">
                      {project.tags.map(tag => <span key={tag} className="tag">{tag}</span>)}
                    </div>
                    
                    <div className="project-links">
                      {project.githubUrl && (
                        <a href={project.githubUrl} target="_blank" rel="noopener noreferrer" className="btn btn-outline">
                          {t('projects.btn_source')}
                        </a>
                      )}
                      {project.demoUrl && (
                        <a href={project.demoUrl} target="_blank" rel="noopener noreferrer" className="btn btn-primary">
                          {t('projects.btn_access')}
                        </a>
                      )}
                    </div>
                  </div>
                </div>
              </BentoCard>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default ProjectsPage;
