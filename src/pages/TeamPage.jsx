import { useTranslation } from 'react-i18next';
import BentoCard from '../components/BentoCard';
import Seo from '../components/SEO';
import './TeamPage.css';

const teamMembers = [
  {
    name: 'Fabien MILLET',
    username: '@zipname',
    roleKey: 'team.role_admin',
    avatar: '/assets/profile/fabien.jpg',
    links: { GitHub: 'https://github.com/fabienmillet', Portfolio: 'https://fabien-millet.fr/' },
  },
  {
    name: 'Maël L.',
    username: '@lexdrane',
    roleKey: 'team.role_admin',
    avatar: '/assets/profile/mael.png',
    links: { Portfolio: 'https://lexdrane.fr/' },
  },
  {
    name: 'Nathan MANNESSIER',
    username: '@hulkhogan6262',
    roleKey: 'team.role_admin',
    avatar: '/assets/profile/nathan.png',
    links: { GitHub: 'https://github.com/HulkHogan6262', Portfolio: 'https://nathan-mannessier.fr/' },
  },
  {
    name: 'Lorenzo N.',
    username: '@lorelix.fr',
    roleKey: 'team.role_admin',
    avatar: '/assets/profile/lorenzo.png',
    links: { Portfolio: 'https://lorelix.fr/' },
  },
];

const TeamPage = () => {
  const { t } = useTranslation();

  const schema = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "ItemList",
    "itemListElement": teamMembers.map((member, index) => ({
      "@type": "ListItem",
      "position": index + 1,
      "item": {
        "@type": "Person",
        "name": member.name,
        "jobTitle": t(member.roleKey)
      }
    }))
  });

  return (
    <div className="page-content">
      <Seo 
        title={`${t('team.title')} - 2c2t.dev`}
        description={t('team.seo_desc')}
        schema={schema}
      />
      <div className="container">
        <div className="section-header animate-fade-in-up">
          <h1 className="brand-font">{t('team.title')}</h1>
          <p>{t('team.desc')}</p>
        </div>

        <div className="team-bento-grid">
          {teamMembers.map((member, index) => (
            <div key={member.username} className={`animate-fade-in-up delay-${index + 1}`}>
              <BentoCard className="member-bento h-full">
                <div className="member-avatar-container">
                  <img src={member.avatar} alt={member.name} className="member-image" width="100" height="100" loading="lazy" />
                </div>
                <h3 className="brand-font">{member.name}</h3>
                <p className="member-username">{member.username}</p>
                <p className="member-role">{t(member.roleKey)}</p>
                
                <div className="member-links mt-auto">
                  {Object.entries(member.links).map(([platform, url]) => (
                    <a key={platform} href={url} target="_blank" rel="noopener noreferrer" className="member-link">
                      {platform}
                    </a>
                  ))}
                </div>
              </BentoCard>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default TeamPage;
