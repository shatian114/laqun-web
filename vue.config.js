module.exports = {

  baseUrl: '/dist/',

  lintOnSave: false,
  devServer: {
    port: 8088,
    proxy: {
      '/api': {
        // target: 'http://193.112.207.237:33799',
        target: 'http://localhost:8080',
        ws: true,
        changeOrigin: true,
        pathRewrite: {
          '^/api': '/api/'
        }
      }
    }
  }
}