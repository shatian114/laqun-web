module.exports = {

  baseUrl: '/dist/',

  lintOnSave: false,
  devServer: {
    port: 8088,
    proxy: {
      '/api': {
        target: 'http://localhost:8081',
        ws: true,
        changeOrigin: true,
        pathRewrite: {
          '^/api': '/api/'
        }
      }
    }
  }
}