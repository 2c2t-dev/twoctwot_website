import PropTypes from 'prop-types';
import { Helmet } from 'react-helmet-async';
import { useLocation } from 'react-router-dom';

const SEO = ({ title, description, schema }) => {
  const location = useLocation();
  const pathParts = location.pathname.split('/').filter(Boolean);

  // Generate BreadcrumbList
  const breadcrumbItems = [
    {
      "@type": "ListItem",
      "position": 1,
      "name": "Home",
      "item": "https://2c2t.dev/"
    }
  ];

  let currentPath = "https://2c2t.dev";
  pathParts.forEach((part, index) => {
    currentPath += `/${part}`;
    breadcrumbItems.push({
      "@type": "ListItem",
      "position": index + 2,
      "name": part.charAt(0).toUpperCase() + part.slice(1),
      "item": currentPath
    });
  });

  const breadcrumbSchema = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": breadcrumbItems
  };

  return (
    <Helmet>
      {title && <title>{title}</title>}
      {title && <meta property="og:title" content={title} />}
      {title && <meta name="twitter:title" content={title} />}
      
      {description && <meta name="description" content={description} />}
      {description && <meta property="og:description" content={description} />}
      {description && <meta name="twitter:description" content={description} />}
      
      {schema && (
        <script type="application/ld+json">
          {typeof schema === 'string' ? schema : JSON.stringify(schema)}
        </script>
      )}
      <script type="application/ld+json">
        {JSON.stringify(breadcrumbSchema)}
      </script>
    </Helmet>
  );
};

SEO.propTypes = {
  title: PropTypes.string,
  description: PropTypes.string,
  schema: PropTypes.oneOfType([PropTypes.object, PropTypes.string])
};

export default SEO;
