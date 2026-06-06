// Apply theme early to prevent flash of wrong theme
(function() {
  try {
    const storedTheme = localStorage.getItem('theme');
    if (storedTheme) {
      document.documentElement.dataset.theme = storedTheme;
    } else {
      const prefersDark = globalThis.matchMedia('(prefers-color-scheme: dark)').matches;
      document.documentElement.dataset.theme = prefersDark ? 'dark' : 'light';
    }
  } catch (e) {
    console.error(e);
  }
})();
