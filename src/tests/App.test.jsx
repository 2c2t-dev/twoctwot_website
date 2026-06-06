import { render, screen } from '@testing-library/react';
import { describe, it, expect, vi } from 'vitest';
import { BrowserRouter } from 'react-router-dom';

// Mock react-i18next
vi.mock('react-i18next', () => ({
  useTranslation: () => ({
    t: (key) => key,
    i18n: {
      changeLanguage: () => new Promise(() => {}),
      language: 'fr',
    },
  }),
}));

import App from '../App';
import HomePage from '../pages/HomePage';
import ProjectsPage from '../pages/ProjectsPage';
import AboutPage from '../pages/AboutPage';
import TeamPage from '../pages/TeamPage';
import ContactPage from '../pages/ContactPage';
import BentoCard from '../components/BentoCard';
import Navbar from '../components/Navbar';

const withRouter = (component) => <BrowserRouter>{component}</BrowserRouter>;

describe('BentoCard Component', () => {
  it('renders with children', () => {
    render(
      <BentoCard>
        <p>Inner content</p>
      </BentoCard>
    );
    expect(screen.getByText('Inner content')).toBeInTheDocument();
  });

  it('applies highlight class', () => {
    const { container } = render(
      <BentoCard highlight={true}><p>content</p></BentoCard>
    );
    expect(container.firstChild).toHaveClass('highlight');
  });
});

describe('Navbar Component', () => {
  it('renders brand and navigation links', () => {
    render(withRouter(<Navbar />));
    expect(screen.getAllByText('nav.projects').length).toBeGreaterThan(0);
    expect(screen.getAllByText('nav.about').length).toBeGreaterThan(0);
    expect(screen.getAllByText('nav.team').length).toBeGreaterThan(0);
    expect(screen.getAllByText('nav.contact').length).toBeGreaterThan(0);
  });
});

describe('HomePage', () => {
  it('renders hero section', () => {
    render(withRouter(<HomePage />));
    expect(screen.getAllByText(/home.subtitle1/i).length).toBeGreaterThan(0);
  });

  it('renders project preview cards', () => {
    render(withRouter(<HomePage />));
    expect(screen.getAllByText(/GetISO/i).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/NetISO/i).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/BootISO/i).length).toBeGreaterThan(0);
  });

  it('renders technology stack', () => {
    render(withRouter(<HomePage />));
    expect(screen.getAllByText('Virtualisation KVM').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Réseau DN42').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Déploiement Automatisé (CI/CD)').length).toBeGreaterThan(0);
  });
});

describe('ProjectsPage', () => {
  it('renders all project details', () => {
    render(withRouter(<ProjectsPage />));
    expect(screen.getAllByText(/GetISO/i).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/NetISO/i).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/BootISO/i).length).toBeGreaterThan(0);
  });
});

describe('AboutPage', () => {
  it('renders mission and vision', () => {
    render(withRouter(<AboutPage />));
    expect(screen.getByText('about.mission_title')).toBeInTheDocument();
    expect(screen.getByText('about.val_open_title')).toBeInTheDocument();
  });
});

describe('TeamPage', () => {
  it('renders all team members', () => {
    render(withRouter(<TeamPage />));
    expect(screen.getAllByText('Fabien MILLET').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Maël L.').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Nathan MANNESSIER').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Lorenzo N.').length).toBeGreaterThan(0);
  });
});

describe('ContactPage', () => {
  it('renders contact methods', () => {
    render(withRouter(<ContactPage />));
    expect(screen.getAllByText('Email').length).toBeGreaterThan(0);
    expect(screen.getAllByText('GitHub').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Discord').length).toBeGreaterThan(0);
  });
});

describe('Full App', () => {
  it('renders without crashing', () => {
    render(<App />);
    expect(screen.getAllByText(/2c2t/).length).toBeGreaterThan(0);
  });
});
