let submittedAnswer = false; // Variable para rastrear si se envió la respuesta

const finalTime = new Date().getTime() + 60 * 1000;

const interval = setInterval(function () {
  const now = new Date().getTime();
  const timeLeft = finalTime - now;

  if (!submittedAnswer) {
    const seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);
    const tenths = Math.floor((timeLeft % 1000) / 100);

    const counterElement = document.getElementById('counter');

    if (seconds < 10) {
      counterElement.style.color = 'red';
      counterElement.innerHTML = `<p>Tiempo Bonus: ${seconds}.${tenths}</p>`;
      document.getElementById("time").value = seconds;
    } else {
      counterElement.innerHTML = `<p>Tiempo Bonus: ${seconds}.${tenths}</p>`;
      document.getElementById("time").value = seconds;
    }

    if (seconds < 0) {
      clearInterval(interval);
      counterElement.style.fontSize = '24px';
      counterElement.innerHTML = 'Tiempo Bonus: 0.0';
      document.getElementById("time").value = 0;
    }
  }
}, 100); // Actualizar cada centésima de segundo

function validateForm() {
  var selectedOption = document.querySelector('input[id^="option_"]:checked');
  if (!selectedOption) {
    alert("Por favor, selecciona una opción antes de enviar.");
    return false; // Evita que el formulario se envíe
  }
  clearInterval(interval); // Detener el contador cuando se envía la respuesta
  return true; // Permite que el formulario se envíe
}
