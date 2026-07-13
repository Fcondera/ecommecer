{{flutter_js}}
{{flutter_build_config}}

const serviceWorkerUrl = 'pwa-service-worker.js';

window.addEventListener('load', () => {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register(serviceWorkerUrl).catch((error) => {
      console.warn('Service worker registration failed:', error);
    });
  }
});

_flutter.loader.load();
