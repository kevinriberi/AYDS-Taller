document.addEventListener("DOMContentLoaded", function() {
  const progressBars = document.querySelectorAll('.progress');
  
  
  progressBars.forEach(progressText => {
    const percentage = progressText.dataset.progress;
    updateProgressBar(progressText, percentage);
  });
  
  // Función para actualizar la barra de progreso
  function updateProgressBar(progressText, percentage) {
    const percentageAsNumber = parseInt(percentage, 10);
    progressText.textContent = `${percentage}%`;
    progressText.style.setProperty('--percentage', `${percentageAsNumber}%`);
    progressText.classList.remove("animate-progress");
    void progressText.offsetWidth; // Truco para reiniciar la animación
    progressText.classList.add("animate-progress");
    console.log("percentage Parceado: ", percentageAsNumber);
  }
});