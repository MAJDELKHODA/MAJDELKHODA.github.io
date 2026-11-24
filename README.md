# Majd Al-Khodari — Flutter Developer Portfolio

My personal portfolio website, built entirely with **Flutter Web** and deployed automatically to **GitHub Pages**.

**Live site:** https://majdelkhoda.github.io

## Features

- **Hero, About, Skills, Projects and Contact** sections in one smooth single page
- **Project showcase** with screenshots, tech tags, GitHub links and demo videos
- **Downloadable CV** (PDF)
- **Quick contact** via email, LinkedIn and WhatsApp
- **Lazy-loaded WebP images** for faster loading
- **Responsive design** that works on desktop and mobile

## Featured Projects

| Project | Description |
|---|---|
| **Mizani (ميزاني)** | Personal finance app: expenses, income and budgets |
| **Lahza (لحظة)** | Event and appointment booking app |
| **Lamha (لمحة)** | Multi-vendor delivery app with an AI assistant (team project) |
| **Beauty (بيوتي)** | Beauty and personal-care e-commerce app |
| **Rafiq (رفيق)** | Pet-care app for tracking a pet's health |
| **DearNotes** | Daily notes app with a timeline and sync |
| **Gold Jewelry Majd** | Jewelry store app |

## Built With

- **Flutter Web** / **Dart**
- [`google_fonts`](https://pub.dev/packages/google_fonts): typography
- [`url_launcher`](https://pub.dev/packages/url_launcher): external links (GitHub, LinkedIn, WhatsApp, CV)
- **GitHub Actions** + **GitHub Pages**: automatic build and deployment

## Project Structure

```
lib/
├─ main.dart
├─ data/
│  └─ portfolio_data.dart   → all site content (info, projects, skills) in one file
├─ pages/
│  └─ home_page.dart
├─ sections/                → hero, about, skills, projects, contact, marquee strip
├─ theme/
│  └─ app_colors.dart
├─ utils/
│  └─ links.dart
└─ widgets/                 → nav bar, lazy image, shared widgets
```

To update the site content (projects, skills, contact info), edit **`lib/data/portfolio_data.dart`** only.

## Run Locally

```bash
git clone https://github.com/MAJDELKHODA/MAJDELKHODA.github.io.git
cd MAJDELKHODA.github.io
flutter pub get
flutter run -d chrome
```

## Deployment

Every push to `main` triggers the GitHub Actions workflow in `.github/workflows/deploy.yml`, which:

1. Builds the site with `flutter build web --release`
2. Publishes `build/web` to GitHub Pages

## Contact

- **Email:** majdalkhodari1@gmail.com
- **LinkedIn:** [Majd Al-Khodari](https://www.linkedin.com/in/majd-kodary-74767944a)
- **GitHub:** [@MAJDELKHODA](https://github.com/MAJDELKHODA)

---

Made with Flutter in Gaza, Palestine.
