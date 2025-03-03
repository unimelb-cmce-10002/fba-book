// In solution.js
window.addEventListener("load", function() {
  // Wait for Quarto to finish rendering
  setTimeout(function() {
    // Get all solution headers
    const solutionHeaders = document.querySelectorAll('.solution-header');
    
    // Add click event to each header
    solutionHeaders.forEach(header => {
      // Start with solutions collapsed
      header.classList.add('collapsed');
      const content = header.nextElementSibling;
      content.classList.add('hidden');
      
      // Toggle visibility on click
      header.addEventListener('click', () => {
        header.classList.toggle('collapsed');
        content.classList.toggle('hidden');
      });
    });
  }, 100); // Short delay to ensure DOM is fully ready
});