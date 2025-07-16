# 2c2t.dev - L'innovation par l'expérimentation informatique

## 🚀 Site vitrine moderne en Flutter Web

Site web moderne et performant pour présenter les projets 2c2t.dev avec un design sombre inspiré de l'univers terminal.

### ✨ Fonctionnalités

- **Navigation fluide** avec go_router et animations subtiles
- **Responsive** adapté desktop, tablette et mobile
- **Performances optimisées** pour un rendu fluide

### 🎯 Projets mis en avant

- **GetISO** - Site de téléchargement d'ISO haute vitesse
- **NetISO** - Service PXE pour installation d'OS via réseau
- **BootISO** - Logiciel multiplateforme de téléchargement et flash USB

### 🛠 Technologies utilisées

- **Flutter Web** - Framework UI multiplateforme
- **Riverpod** - Gestion d'état moderne
- **go_router** - Navigation déclarative
- **Google Fonts** - Typographie (JetBrains Mono)
- **Flutter Animate** - Animations fluides
- **Responsive Framework** - Design adaptatif

### 🏃‍♂️ Lancement rapide

```bash
# Installation des dépendances
flutter pub get

# Lancement en mode développement
flutter run -d chrome --web-port=8080

# Build de production
flutter build web --release
```

### 📁 Structure du projet

```
lib/
├── core/
│   ├── router/          # Configuration de navigation
│   └── theme/           # Thème et couleurs
├── features/
│   ├── home/            # Page d'accueil
│   ├── projects/        # Page des projets
│   ├── about/           # Page à propos
│   └── contact/         # Page de contact
└── shared/
    └── presentation/
        └── widgets/     # Composants réutilisables
```

---

**2c2t.dev** - Développé avec ❤️ et Flutter
