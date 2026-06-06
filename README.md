# 2c2t.dev - L'innovation par l'expérimentation

<div align="center">
  <img src="./public/assets/images/logo_squared.png" alt="2c2t.dev Logo" width="120" />
</div>

<br />

Bienvenue sur le dépôt officiel du site web **2c2t.dev**. Ce site sert de vitrine pour notre collectif open-tech dédié à l'infrastructure, au déploiement de systèmes et à l'auto-hébergement.

## 🚀 À propos

2c2t.dev est avant tout un lieu d'échange et d'expérimentation technique. Nos projets phares incluent des solutions optimisées pour l'installation d'OS, telles que GetISO, NetISO et BootISO.

Ce site présente notre écosystème, nos membres, ainsi que les différentes technologies que nous maîtrisons et implémentons au quotidien.

## 🛠 Stack Technique

- **Framework :** [React](https://react.dev/) 19 + [Vite](https://vitejs.dev/)
- **Routing :** [React Router](https://reactrouter.com/) (avec Lazy Loading / Code Splitting natif via `Suspense`)
- **Styling :** CSS Vanilla orienté "Premium Flat Design" (Glassmorphism, CSS Variables, Light/Dark mode adaptatif)
- **Déploiement :** Optimisé pour [Cloudflare Pages](https://pages.cloudflare.com/) (fichiers `_headers` et `_redirects` natifs)
- **Tests :** [Vitest](https://vitest.dev/) + React Testing Library

## 💻 Installation & Développement

Assurez-vous d'avoir [Node.js](https://nodejs.org/) installé sur votre machine.

```bash
# 1. Cloner le dépôt
git clone https://github.com/2c2t-dev/twoctwot_website.git
cd twoctwot_website

# 2. Installer les dépendances
npm install

# 3. Lancer le serveur de développement local
npm run dev
```

Le site sera accessible à l'adresse `http://localhost:5173`.

## 🏗 Scripts Disponibles

- `npm run dev` : Lance le serveur de développement avec rechargement à chaud (HMR).
- `npm run build` : Compile et optimise l'application pour la production dans le dossier `dist/`.
- `npm run test` : Exécute la suite de tests unitaires via Vitest.
- `npm run lint` : Vérifie la propreté du code avec ESLint.

## 🛡 Sécurité & Performances

L'application a été structurée pour satisfaire les plus hauts standards techniques :
- **Sécurité (Note A+ sur Mozilla Observatory)** : Content-Security-Policy stricte, HSTS, X-Frame-Options implémentés.
- **Performance (PageSpeed 99+)** : Prévention du Cumulative Layout Shift (CLS), Code Splitting JavaScript, Lazy Loading asynchrone des médias sous la ligne de flottaison.

## 🤝 Contribuer

Les contributions, issues et pull requests sont les bienvenues ! N'hésitez pas à nous rejoindre sur notre Discord ou à interagir avec nos dépôts.

## 📄 Licence

Ce projet est distribué sous licence Open Source (GPL).
