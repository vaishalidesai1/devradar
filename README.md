# 🚀 DevRadar

> Explorador de tendencias tech con predicción IA — Flutter App  
> **CMP 3104 · Programación Avanzada de Apps · USFQ 2025**

---

## ✨ ¿Qué hace?

DevRadar consume datos reales de GitHub y Dev.to para mostrar qué tecnologías están en tendencia, y usa OpenAI para predecir cuál va a explotar la próxima semana. Todo con un diseño cálido y amigable, sin la estética robótica de siempre.

| Pantalla | Qué hace |
|---|---|
| 🔥 **Trending** | Repos más populares de GitHub + artículos de Dev.to en tiempo real |
| 📊 **Dashboard** | Gráficos interactivos de evolución por lenguaje con fl_chart |
| 🤖 **IA Predictor** | OpenAI analiza tendencias y predice qué tech va a crecer esta semana |
| 🔖 **Guardados** | Repos favoritos guardados localmente (Firebase opcional) |

---

## 🛠️ Stack

- **Flutter + Dart** — UI multiplataforma
- **Provider** — manejo de estado
- **GitHub API + Dev.to API** — datos reales de trending
- **OpenAI API (gpt-4o-mini)** — predicción semanal con razonamiento
- **Firebase Firestore** — persistencia (configuración opcional)
- **fl_chart** — gráficos interactivos
- **Clean Architecture** — capas data / domain / presentation

---

## 📁 Estructura

```
lib/
├── core/           # Constantes y errores
├── data/           # APIs, Firebase, modelos (Daniel)
│   ├── datasources/
│   ├── models/
│   └── repositories/
└── presentation/   # UI, providers, pantallas (Vai)
    ├── providers/
    ├── screens/
    ├── theme/
    └── widgets/
```

---

## 🚀 Cómo correr

### Local (Flutter)

```bash
# 1. Clonar
git clone https://github.com/tu-usuario/devradar.git
cd devradar

# 2. Crear .env en la raíz
echo "GITHUB_TOKEN=tu_token_aqui" > .env
echo "OPENAI_API_KEY=tu_key_aqui" >> .env

# 3. Instalar dependencias
flutter pub get

# 4. Correr
flutter run
```

### Docker (web)

```bash
# Construir y correr
docker-compose up --build

# La app estará en http://localhost:8080
```

> ⚠️ Asegúrate de que el archivo `.env` esté en la raíz antes de correr Docker.

---

## 🔑 Variables de entorno

Crea un archivo `.env` en la raíz del proyecto:

```env
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxx
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxx
```

| Variable | Dónde obtenerla | Requerida |
|---|---|---|
| `GITHUB_TOKEN` | [github.com/settings/tokens](https://github.com/settings/tokens) | Recomendada (evita rate limit) |
| `OPENAI_API_KEY` | [platform.openai.com](https://platform.openai.com/api-keys) | Sí (para predicciones IA) |

> ⚠️ **Nunca subas `.env` a GitHub** — ya está en `.gitignore`

---

## 🔥 Firebase (opcional)

Para activar persistencia de favoritos en la nube:

1. Crea un proyecto en [Firebase Console](https://console.firebase.google.com)
2. Agrega una app Android/iOS/Web
3. Descarga `google-services.json` → ponlo en `android/app/`
4. En `lib/main.dart`, descomenta las líneas de Firebase
5. En `lib/presentation/providers/favorites_provider.dart`, conecta con `FavoritesRepositoryImpl`

---

## 👥 Equipo

| Persona | Rol | Capa |
|---|---|---|
| **Vai** | UI / Frontend | `presentation/` (providers, pantallas, widgets, tema) |
| **Daniel** | Backend / Data | `data/` (APIs, Firebase, modelos, repositorios) |

---

## 📄 Licencia

MIT — Universidad San Francisco de Quito · 2025
