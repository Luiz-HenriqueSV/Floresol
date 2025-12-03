document.getElementById('contactForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const message = document.getElementById('message').value;
    const formMessage = document.getElementById('form-message');

    if (name === '' || email === '' || message === '') {
        formMessage.textContent = 'Por favor, preencha todos os campos.';
        formMessage.style.color = 'red';
    } else {
        formMessage.textContent = 'Mensagem enviada com sucesso! Em breve entraremos em contato.';
        formMessage.style.color = 'green';
        document.getElementById('contactForm').reset();
    }
});