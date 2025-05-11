describe('Homepage content testing', () => {
  beforeEach(() => {
    cy.visit('/')
  })
  
  it('should show job title', () => {
    cy.contains('Cloud Platform Engineer')
  })
  
  it('should render an h2 element', () => {
    cy.get('h2').should('exist')
  })
  
  it('should contain LinkedIn QR link', () => {
    cy.get('a[href*="linkedin.com/in/andras-pal"]').should('exist')
  })
  
  it('QR link has correct href', () => {
    cy.get('a[href*="linkedin.com/in/andras-pal"]')
      .should('have.attr', 'href')
      .and('include', 'linkedin.com/in/andras-pal')
  })
})