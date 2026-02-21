import { defineConfig, loadEnv } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig(({ mode }) => {
  // Charge les variables d'env du dossier actuel
  // Le 3ème argument '' permet de charger TOUTES les variables (pas seulement celles commençant par VITE_)
  const env = loadEnv(mode, process.cwd(), '');
 
  return {
    server: {
      host: true, // Pour que dockcer expose le port
      watch: {
        // Indispensable pour docker 
        usePolling: true,
        interval: 100, // Vérification toutes les 100ms
      },
      port: 3000,

      allowedHosts: env.VITE_TUNNEL_URL ? [env.VITE_TUNNEL_URL] : true, 
       
      // Optionel : Configuration du WebSocket pour le HMR (Hot Module Replacement)
      hmr: {
        clientPort: 443, // Force le HMR à passer par le port HTTPS de ngrok
        host: env.VITE_TUNNEL_URL
      }
    },

    plugins: [
      react(),
    ],
  }
})
