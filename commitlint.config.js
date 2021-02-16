const Configuration = {
  extends: ['@commitlint/config-conventional'],

  rules: {
    'scope-empty': [ 2, "never" ],
  },
};

module.exports = Configuration;