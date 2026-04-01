const target = `http://localhost:${process.env.BACKEND_PORT || 8080}`;

module.exports = {
  '/api': { target, secure: false, changeOrigin: true, logLevel: 'warn' },
  '/ws':  { target, secure: false, changeOrigin: true, ws: true, logLevel: 'warn' }
};
