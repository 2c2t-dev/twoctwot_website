import { useTranslation } from 'react-i18next';
import Seo from '../components/SEO';
import './CookiesPage.css';

const CookiesPage = () => {
  const { t } = useTranslation();

  return (
    <>
      <Seo 
        title={`${t('cookies_policy.title')} | 2c2t.dev`}
        description={t('cookies_policy.seo_desc')}
      />
      <div className="page-container cookies-page">
        <div className="container">
          <header className="page-header">
            <h1 className="page-title">{t('cookies_policy.title')}</h1>
            <p className="page-subtitle">{t('cookies_policy.desc')}</p>
          </header>

          <div className="cookies-content">
            <section className="cookies-section">
              <h2>Qu'est-ce qu'un cookie ?</h2>
              <p>Un cookie est un petit fichier texte déposé sur votre terminal (ordinateur, tablette, smartphone) lors de la visite d'un site web. Il permet au site de mémoriser vos actions et préférences (telles que la connexion, la langue, la taille de la police et d'autres préférences d'affichage) pendant une durée donnée.</p>
            </section>

            <section className="cookies-section">
              <h2>Comment utilisons-nous les cookies ?</h2>
              <p>Nous n'utilisons que des cookies strictement nécessaires au fonctionnement de notre site :</p>
              <ul>
                <li><strong>Préférences de thème :</strong> Pour mémoriser si vous préférez le mode clair ou le mode sombre.</li>
                <li><strong>Choix de langue :</strong> Pour mémoriser la langue d'affichage que vous avez sélectionnée (français ou anglais).</li>
                <li><strong>Consentement :</strong> Pour mémoriser votre choix concernant l'affichage de la bannière de cookies.</li>
              </ul>
              <p>Nous n'utilisons <strong>aucun cookie de ciblage publicitaire ni de traçage comportemental</strong>.</p>
            </section>

            <section className="cookies-section">
              <h2>Contrôler les cookies</h2>
              <p>Vous pouvez contrôler et/ou supprimer des cookies comme vous le souhaitez. Vous pouvez supprimer tous les cookies déjà stockés sur votre ordinateur et configurer la plupart des navigateurs pour qu'ils bloquent leur installation. Toutefois, si vous faites cela, vous devrez peut-être ajuster manuellement certaines préférences à chaque visite d'un site, et certains services et fonctionnalités pourraient ne pas fonctionner.</p>
            </section>
          </div>
        </div>
      </div>
    </>
  );
};

export default CookiesPage;
