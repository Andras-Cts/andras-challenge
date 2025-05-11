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
  
  it('QR link working', () => {
    cy.get('a[href*="linkedin.com/in/andras-pal"]')
    .invoke('attr', 'href')
    .then((url) => {
      cy.request({
        url,
        followRedirect: true,
      }).its('status').should('eq', 200)
    })
  })
}) 