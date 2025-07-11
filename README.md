# 2c2t.dev - L'innovation par l'expérimentation informatique

## 🚀 Site vitrine moderne en Flutter Web

Site web moderne et performant pour présenter les projets 2c2t.dev avec un design sombre inspiré de l'univers terminal et Matrix.

### 🎨 Identité visuelle

- **Couleur principale** : `#081FF7` (Bleu électrique 2c2t - DA officielle)
- **Thème** : Dark Matrix avec effets subtils optimisés
- **Police** : JetBrains Mono (style terminal/code)

### ✨ Fonctionnalités

- **Design sombre et moderne** avec thème Matrix optimisé
- **Navigation fluide** avec go_router et animations subtiles
- **Responsive** adapté desktop, tablette et mobile
- **Performances optimisées** pour un rendu fluide
- **Typographie moderne** avec JetBrains Mono

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

### 🎨 Thème et couleurs

- **Couleur primaire** : `#00FF88` (Vert Matrix)
- **Couleur secondaire** : `#00DDFF` (Cyan)
- **Arrière-plan** : `#0A0A0A` (Noir profond)
- **Police** : JetBrains Mono (Monospace)

### ⚡ Optimisations performances

- Arrière-plan Matrix optimisé avec moins d'éléments animés
- Animations réduites et fluides
- TextPainter réutilisable pour les rendus
- Limitation du nombre de colonnes Matrix (max 15)
- Refresh rate optimisé (500ms vs 50ms original)

## ⚡ Configuration de l'arrière-plan Matrix

Le site propose deux versions d'arrière-plan optimisées pour la performance :

### Types disponibles

1. **Ultra-Light** (par défaut) - **0% CPU garanti**
   - Pattern Matrix statique précalculé
   - Aucune animation, dessiné une seule fois
   - Performance maximale, idéal pour tous les appareils

2. **Minimal** - **0% CPU**
   - Simple gradient sans effet Matrix
   - Performance absolue, style minimaliste

### Changer le type d'arrière-plan

Pour modifier le type d'arrière-plan, éditez le fichier :
```dart
// lib/shared/presentation/config/matrix_background_config.dart
static const MatrixBackgroundType currentType = MatrixBackgroundType.ultraLight;
```

Remplacez `ultraLight` par `minimal` pour la version sans Matrix.

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

### 🔧 Commandes utiles

```bash
# Analyse du code
flutter analyze

# Tests
flutter test

# Build optimisé pour production
flutter build web --release --web-renderer html

# Serveur local simple
cd build/web && python -m http.server 8080
```

---

**2c2t.dev** - Développé avec ❤️ et Flutter
