// Kontaktformular
document.getElementById('contact-form').addEventListener('submit', function (e) {
    e.preventDefault();
    const name = this.name.value.trim();
    const email = this.email.value.trim();
    const message = this.message.value.trim();

    if (!name || !email || !message) {
        alert('Bitte füllen Sie alle Felder aus.');
        return;
    }

    alert('Vielen Dank für Ihre Nachricht!');
    this.reset();
});

// Animationen für sichtbare Elemente
const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        if (entry.isIntersecting) {
            entry.target.classList.add('fade-in');
        }
    });
});
document.querySelectorAll('.fade-in, .slide-in, .zoom-in').forEach((el) => {
    observer.observe(el);
});

// Sprachumschaltung
const translations = {
    de: {
        home: "Home",
        features: "Features",
        community: "Community",
        contact: "Kontakt",
        welcome: "Willkommen bei OpenLab",
        description: "Ein kostenloses Open Source Projekt für dein Docker-basiertes Pentest Labor.",
        learnMore: "Erfahre mehr",
    },
    en: {
        home: "Home",
        features: "Features",
        community: "Community",
        contact: "Contact",
        welcome: "Welcome to OpenLab",
        description: "A free open-source project for your Docker-based pentest lab.",
        learnMore: "Learn more",
    },
};

function setLanguage(lang) {
    document.querySelectorAll("[data-key]").forEach((element) => {
        const key = element.getAttribute("data-key");
        element.textContent = translations[lang][key];
    });
}

document.getElementById("language-switcher").addEventListener("change", function () {
    const selectedLang = this.value;
    localStorage.setItem('language', selectedLang);
    setLanguage(selectedLang);
});

// Standardmäßig Sprache anwenden
const lang = localStorage.getItem('language') || 'de';
document.getElementById("language-switcher").value = lang;
setLanguage(lang);
