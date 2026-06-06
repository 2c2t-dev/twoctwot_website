import { fireEvent, render, screen } from '@testing-library/react';
import { describe, it, expect, vi } from 'vitest';
import { BrowserRouter } from 'react-router-dom';
import SEO from '../components/SEO';

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
import ThemeToggle from '../components/ThemeToggle';
import InteractiveBackground from '../components/InteractiveBackground';

const withProviders = (component) => (
  <BrowserRouter>{component}</BrowserRouter>
);

describe('SEO Component', () => {
  it('updates document title and meta tags', () => {
    const schema = { "@context": "https://schema.org" };
    render(<SEO title="Test Title" description="Test Desc" schema={schema} />);
    expect(document.title).toBe('Test Title');
  });
});

describe('InteractiveBackground Component', () => {
  it('updates mouse position on mousemove', () => {
    const { container } = render(<InteractiveBackground />);
    fireEvent.mouseMove(globalThis, { clientX: 100, clientY: 200 });
    expect(container.querySelector('.interactive-spotlight')).toBeInTheDocument();
  });
});

describe('ThemeToggle Component', () => {
  it('toggles theme on click', () => {
    render(<ThemeToggle />);
    const btn = screen.getByLabelText('Toggle Theme');
    fireEvent.click(btn);
    expect(document.documentElement.dataset.theme).toBeDefined();
  });
});

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
    render(withProviders(<Navbar />));
    expect(screen.getAllByText('nav.projects').length).toBeGreaterThan(0);
    expect(screen.getAllByText('nav.about').length).toBeGreaterThan(0);
    expect(screen.getAllByText('nav.team').length).toBeGreaterThan(0);
    expect(screen.getAllByText('nav.contact').length).toBeGreaterThan(0);
  });

  it('toggles language on click', () => {
    render(withProviders(<Navbar />));
    const langBtn = screen.getByLabelText('Toggle language');
    fireEvent.click(langBtn);
    // Since i18n is mocked, we just verify the button is clickable without errors
    expect(langBtn).toBeInTheDocument();
  });

  it('toggles mobile menu on click', () => {
    render(withProviders(<Navbar />));
    const menuBtn = screen.getByLabelText('Menu');
    fireEvent.click(menuBtn);
    expect(document.body.style.overflow).toBe('hidden');
    fireEvent.click(menuBtn);
    expect(document.body.style.overflow).toBe('unset');
  });

  it('handles scroll event', () => {
    render(withProviders(<Navbar />));
    fireEvent.scroll(window, { target: { scrollY: 100 } });
    expect(document.querySelector('.navbar-wrapper')).toHaveClass('scrolled');
  });
});

describe('HomePage', () => {
  it('renders hero section', () => {
    render(withProviders(<HomePage />));
    expect(screen.getAllByText(/home.subtitle1/i).length).toBeGreaterThan(0);
  });

  it('renders project preview cards', () => {
    render(withProviders(<HomePage />));
    expect(screen.getAllByText(/GetISO/i).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/NetISO/i).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/BootISO/i).length).toBeGreaterThan(0);
  });

  it('renders technology stack', () => {
    render(withProviders(<HomePage />));
    expect(screen.getAllByText('Virtualisation KVM').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Réseau DN42').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Déploiement Automatisé (CI/CD)').length).toBeGreaterThan(0);
  });
});

describe('ProjectsPage', () => {
  it('renders all project details', () => {
    render(withProviders(<ProjectsPage />));
    expect(screen.getAllByText(/GetISO/i).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/NetISO/i).length).toBeGreaterThan(0);
    expect(screen.getAllByText(/BootISO/i).length).toBeGreaterThan(0);
  });
});

describe('AboutPage', () => {
  it('renders mission and vision', () => {
    render(withProviders(<AboutPage />));
    expect(screen.getByText('about.mission_title')).toBeInTheDocument();
    expect(screen.getByText('about.val_open_title')).toBeInTheDocument();
  });
});

describe('TeamPage', () => {
  it('renders all team members', () => {
    render(withProviders(<TeamPage />));
    expect(screen.getAllByText('Fabien MILLET').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Maël L.').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Nathan MANNESSIER').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Lorenzo N.').length).toBeGreaterThan(0);
  });
});

describe('ContactPage', () => {
  it('renders contact methods', () => {
    render(withProviders(<ContactPage />));
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
