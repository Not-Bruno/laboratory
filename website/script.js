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
        developmentNote: "🚧 Dieses Projekt befindet sich aktuell in der Entwicklung 🚧",
        home: "Home",
        features: "Features",
        community: "Community",
        contact: "Kontakt",
        contactText: "Hast du Feedback, Fragen oder Vorschläge? Wir würden uns freuen, von dir zu hören!",
        submitText: "Nachricht senden",
        welcome: "Willkommen bei Cyberbear Lab",
        shortdescription: "Ein kostenloses Open Source Projekt für dein Docker-basiertes Pentest Labor.",
        learnMore: " Entdecke mehr",
        titelFeature: "Projekt Features",
        featurecardTitel01: "Docker-basiertes Labor",
        featurecardText01: "Erstelle und verwalte deine Pentest-Umgebung modular mit Docker-Containern.",
        featurecardTitel02: "Vorkonfigurierte Container",
        featurecardText02: "Nutze Container wie Metasploit, OWASP Juice Shop, DVWA oder Windows-Systeme für deine Tests.",
        featurecardTitel03: "Terminal-Interface",
        featurecardText03: "Aktiviere oder deaktiviere Container direkt über unser intuitives Terminalinterface.",
        featurecardTitel04: "Anpassbare Umgebung",
        featurecardText04: "Füge eigene docker-compose-Container hinzu und erweitere dein Labor individuell.",
        supportedSystems: "Unterstützte Systeme",
        projectAbout: "Mehr zum Project",
        projecDescription: "Cyberbear Lab ist mehr als nur ein Tool – es ist eine Plattform für Lernende, Profis und Enthusiasten, um gemeinsam Hacking-Skills zu trainieren und neue Exploits zu testen. Aktuell befindet sich das Projekt in der Beta-Phase und wird aktiv weiterentwickelt. Wir laden dich ein, Teil der Reise zu werden.",
        toTheProjectButton: "Zum Projekt",
    },
    en: {
        developmentNote: "🚧 This project is currently under development 🚧",
        home: "Home",
        features: "Features",
        community: "Community",
        contact: "Contact",
        contactText: "Do you have any feedback, questions or suggestions? We would love to hear from you!",
        submitText: "Send message",
        welcome: "Welcome to Cyberbear Lab",
        shortdescription: "A free open-source project for your Docker-based pentest lab.",
        learnMore: "Learn more",
        titelFeature: "Project Features",
        featurecardTitel01: "Docker-based Labor",
        featurecardText01: "Create and manage your pentest environment modularly with Docker containers.",
        featurecardTitel02: "Preconfigured containers",
        featurecardText02: "Use containers such as Metasploit, OWASP Juice Shop, DVWA or Windows systems for your tests.",
        featurecardTitel03: "Terminal-Interface",
        featurecardText03: "Activate or deactivate containers directly via our intuitive terminal interface.",
        featurecardTitel04: "Easy expandable",
        featurecardText04: "Add your own docker-compose containers and expand your lab individually.",
        supportedSystems: "Supported Systems",
        projectAbout: "About the Project",
        projecDescription: "Cyberbear Lab is more than just a tool - it is a platform for learners, professionals and enthusiasts to train hacking skills and test new exploits together. The project is currently in the beta phase and is being actively developed. We invite you to become part of the journey.",
        toTheProjectButton: "To the Project",
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
const lang = localStorage.getItem('language') || 'en';
document.getElementById("language-switcher").value = lang;
setLanguage(lang);

// Schneeflocken erzeugen
function createSnowflake() {
    const snowflake = document.createElement('div');
    snowflake.classList.add('snowflake');
    const symbols = ["❄", "✨", "🎄", "⛄"];
    snowflake.textContent = symbols[Math.floor(Math.random() * symbols.length)];
    // snowflake.textContent = '❄'; // Du kannst hier andere Symbole verwenden, z.B. ★
    snowflake.style.left = Math.random() * 100 + 'vw'; // Zufällige horizontale Position
    snowflake.style.animationDuration = Math.random() * 3 + 2 + 's'; // Unterschiedliche Fallgeschwindigkeit
    snowflake.style.opacity = Math.random(); // Unterschiedliche Transparenz
    document.body.appendChild(snowflake);

    // Entferne die Schneeflocke nach der Animation
    setTimeout(() => {
        snowflake.remove();
    }, 5000);
}

// Alle 200ms eine neue Schneeflocke hinzufügen
setInterval(createSnowflake, 200);

