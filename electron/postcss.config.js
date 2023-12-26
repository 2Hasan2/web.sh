module.exports = {
  plugins: {
    'postcss-import': {},
    tailwindcss: {},
    autoprefixer: {},
    'cssnano': {
      discardComments: {
        removeAll: true
      }
    }
  },
};