const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    baseUrl: 'https://www.andras-challenge.co.uk',
    viewportWidth: 1280,
    viewportHeight: 720,
    specPattern: "cypress/e2e/**/*.cy.{js,jsx,ts,tsx}",
    pageLoadTimeout: 5000,
    retries: {
      runMode: 2,
      openMode: 1,
    },
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});