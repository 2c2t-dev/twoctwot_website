import { useState, useEffect } from 'react';
import { NavLink, useLocation } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import ThemeToggle from './ThemeToggle';
import './Navbar.css';

const Navbar = () => {
  const [isScrolled, setIsScrolled] = useState(false);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const location = useLocation();
  const { t, i18n } = useTranslation();

  // Handle scroll effect
  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 20);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  // Close mobile menu on route change
  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setMobileMenuOpen(false);
  }, [location.pathname]);

  // Prevent scroll when mobile menu is open
  useEffect(() => {
    if (mobileMenuOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = 'unset';
    }
    return () => {
      document.body.style.overflow = 'unset';
    };
  }, [mobileMenuOpen]);

  const toggleLanguage = () => {
    const nextLang = i18n.language.startsWith('fr') ? 'en' : 'fr';
    i18n.changeLanguage(nextLang);
  };

  const navLinks = [
    { name: t('nav.projects'), path: '/projects' },
    { name: t('nav.about'), path: '/about' },
    { name: t('nav.team'), path: '/team' },
    { name: t('nav.contact'), path: '/contact' },
  ];

  return (
    <div className={`navbar-wrapper ${isScrolled ? 'scrolled' : ''}`}>
      <nav className="navbar container">
        <NavLink to="/" className="navbar-brand" aria-label="Accueil">
          <img src="/assets/images/logo_2c2t.png" alt="2c2t logo" className="navbar-logo" />
          <div className="brand-font">
            <span className="logo-text">2c2t.dev</span>
            <span className="logo-dot"></span>
          </div>
        </NavLink>

        <div className={`navbar-links ${mobileMenuOpen ? 'mobile-open' : ''}`}>
          {navLinks.map((link) => (
            <NavLink 
              key={link.path} 
              to={link.path} 
              className={({ isActive }) => `nav-link ${isActive ? 'active' : ''}`}
            >
              {link.name}
            </NavLink>
          ))}
          {/* On mobile, we might want to show the language switcher in the menu too, 
              but since it's in navbar-actions, it stays fixed. That's fine. */}
        </div>

        <div className="navbar-actions">
          <button 
            onClick={toggleLanguage} 
            className="lang-toggle-btn"
            aria-label="Toggle language"
            title={i18n.language.startsWith('fr') ? 'Switch to English' : 'Passer en Français'}
          >
            {i18n.language.startsWith('fr') ? 'FR' : 'EN'}
          </button>
          
          <ThemeToggle />
          
          <button 
            className={`navbar-toggle ${mobileMenuOpen ? 'open' : ''}`} 
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            aria-label="Menu"
          >
            <span></span>
            <span></span>
            <span></span>
          </button>
        </div>
      </nav>
    </div>
  );
};

export default Navbar;
