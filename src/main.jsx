import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import '@fontsource/inter/300.css';
import '@fontsource/inter/400.css';
import '@fontsource/inter/500.css';
import '@fontsource/inter/600.css';
import '@fontsource/inter/700.css';
import '@fontsource/museomoderno/300.css';
import '@fontsource/museomoderno/400.css';
import '@fontsource/museomoderno/600.css';
import '@fontsource/museomoderno/800.css';
import '@fontsource/museomoderno/900.css';
import './index.css'
import i18n from './i18n'
import { I18nextProvider } from 'react-i18next'
import App from './App.jsx'

import { HelmetProvider } from 'react-helmet-async';

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <HelmetProvider>
      <I18nextProvider i18n={i18n}>
        <App />
      </I18nextProvider>
    </HelmetProvider>
  </StrictMode>,
)
