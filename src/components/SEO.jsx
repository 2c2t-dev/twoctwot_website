import { useEffect } from 'react';
import PropTypes from 'prop-types';

const SEO = ({ title, description, schema }) => {
  useEffect(() => {
    if (title) {
      document.title = title;
      const ogTitle = document.querySelector('meta[property="og:title"]');
      if (ogTitle) ogTitle.content = title;
      const twitterTitle = document.querySelector('meta[name="twitter:title"]');
      if (twitterTitle) twitterTitle.content = title;
    }
    
    if (description) {
      const metaDesc = document.querySelector('meta[name="description"]');
      if (metaDesc) metaDesc.content = description;
      const ogDesc = document.querySelector('meta[property="og:description"]');
      if (ogDesc) ogDesc.content = description;
      const twitterDesc = document.querySelector('meta[name="twitter:description"]');
      if (twitterDesc) twitterDesc.content = description;
    }

    let script = null;
    if (schema) {
      script = document.createElement('script');
      script.type = 'application/ld+json';
      // If schema is passed as string, use it directly, otherwise stringify
      script.text = typeof schema === 'string' ? schema : JSON.stringify(schema);
      document.head.appendChild(script);
    }

    return () => {
      if (script && document.head.contains(script)) {
        script.remove();
      }
    };
  }, [title, description, schema]);

  return null;
};

SEO.propTypes = {
  title: PropTypes.string,
  description: PropTypes.string,
  schema: PropTypes.oneOfType([PropTypes.object, PropTypes.string])
};

export default SEO;
