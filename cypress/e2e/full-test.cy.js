describe('My First Test', () => {
    it('passes', () => {
      cy.visit('/')
      cy.contains(' Cloud Platform Engineer ')
      cy.get('h2').should('exist')
    })
  })