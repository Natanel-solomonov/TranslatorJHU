# TranslatorJHU

Real-time translation system for video meetings with natural voice synthesis. Translate speech in real-time during Zoom, Google Meet, and Microsoft Teams calls with AI-powered contextual translation and ultra-realistic voice output.

## 🚀 Overview

TranslatorJHU consists of two main components:

- **Frontend**: Chrome Extension with React + TypeScript
- **Backend**: Node.js server with Google Cloud STT, Gemini AI translation, and multi-provider TTS

## ✨ Key Features

- **🎯 Real-time Translation**: Live speech-to-text and translation during meetings
- **🤖 AI-Powered**: Google Gemini 1.5 for contextual, nuanced translations
- **🎵 Natural Voices**: ElevenLabs, Azure Neural TTS, and other premium providers
- **🌐 Multi-Platform**: Works with Zoom, Google Meet, Microsoft Teams
- **📱 Easy Setup**: Chrome extension with simple one-click installation
- **🔒 Privacy-Focused**: Audio processing with optional on-device fallbacks

## 🛠 Tech Stack

### Frontend (Chrome Extension)

- **React + TypeScript**: Modern UI development
- **Vite**: Fast build tool and dev server
- **TailwindCSS**: Utility-first styling
- **Web Audio API**: Real-time audio capture
- **WebSocket**: Real-time communication

### Backend (Node.js Server)

- **Node.js + TypeScript**: Server-side development
- **Express + WebSocket**: API and real-time communication
- **Google Cloud Speech-to-Text**: Streaming STT (~200ms latency)
- **Google Gemini AI**: Contextual translation
- **Multiple TTS Providers**: ElevenLabs, Azure, Google, Cartesia

## 📦 Quick Start

### Prerequisites

1. **Google Cloud Account** with Speech-to-Text API enabled
2. **Gemini API Key** from Google AI Studio
3. **TTS Provider Account** (ElevenLabs recommended)

### 1. Clone Repository

```bash
git clone https://github.com/your-username/TranslatorJHU.git
cd TranslatorJHU
```

### 2. Backend Setup

```bash
cd TranslatorJHU-Backend
npm install
cp env.example .env
# Edit .env with your API keys
npm run dev
```

### 3. Frontend Setup

```bash
cd ../TranslatorJHU-Frontend
npm install
npm run build:extension
```

### 4. Load Chrome Extension

1. Open `chrome://extensions/`
2. Enable "Developer mode"
3. Click "Load unpacked"
4. Select `TranslatorJHU-Frontend/dist/` folder

## 🎯 Usage

1. **Join a meeting** on Zoom, Google Meet, or Microsoft Teams
2. **Click the extension icon** in your browser toolbar
3. **Select languages** (source and target)
4. **Start translation** and enable captions overlay
5. **Speak naturally** - see real-time captions and hear translated audio

## 🔧 Configuration

### Backend Environment Variables

```env
# Required
GEMINI_API_KEY=your-gemini-api-key
GOOGLE_CLOUD_PROJECT_ID=your-project-id
GOOGLE_APPLICATION_CREDENTIALS=path/to/service-account.json

# TTS Provider (choose one or more)
ELEVENLABS_API_KEY=your-elevenlabs-key
AZURE_SPEECH_KEY=your-azure-key
AZURE_SPEECH_REGION=your-azure-region

# Optional
PORT=8080
LOG_LEVEL=info
```

### Supported Languages

- **English** ↔ **Spanish, French, German, Italian, Portuguese**
- **Chinese** ↔ **English, Japanese, Korean**
- **Arabic** ↔ **English, French**
- **Russian** ↔ **English, German**
- **Hindi** ↔ **English**

_More language pairs available - see backend configuration_

## 🏗 Architecture

```
┌─────────────────┐    WebSocket    ┌──────────────────┐
│  Chrome         │◄──────────────►│  Node.js         │
│  Extension      │                 │  Backend         │
│                 │                 │                  │
│ ┌─────────────┐ │                 │ ┌──────────────┐ │
│ │ Popup UI    │ │                 │ │ Translation  │ │
│ │ Audio       │ │                 │ │ Pipeline     │ │
│ │ Capture     │ │                 │ │              │ │
│ │ Captions    │ │                 │ │ STT → Gemini │ │
│ │ Overlay     │ │                 │ │ → TTS        │ │
│ └─────────────┘ │                 │ └──────────────┘ │
└─────────────────┘                 └──────────────────┘
        │                                     │
        │                                     │
   ┌────▼────┐                         ┌─────▼─────┐
   │ Meeting │                         │    AI     │
   │ Audio   │                         │ Services  │
   │ Stream  │                         │           │
   └─────────┘                         │ • Google  │
                                       │   Cloud   │
                                       │ • Gemini  │
                                       │ • ElevenLabs │
                                       └───────────┘
```

## 📁 Project Structure

```
TranslatorJHU/
├── TranslatorJHU-Frontend/     # Chrome Extension
│   ├── src/
│   │   ├── background/         # Service worker
│   │   ├── content/           # Content scripts
│   │   ├── popup/             # Extension popup
│   │   ├── overlay/           # Captions overlay
│   │   └── services/          # Audio & WebSocket
│   └── public/
│       └── manifest.json      # Extension manifest
│
├── TranslatorJHU-Backend/      # Node.js Server
│   ├── src/
│   │   ├── services/
│   │   │   ├── stt/           # Speech-to-Text
│   │   │   ├── translation/   # Gemini AI
│   │   │   └── tts/           # Text-to-Speech
│   │   ├── websocket/         # WebSocket handling
│   │   └── routes/            # REST API
│   └── env.example            # Environment template
│
└── README.md                   # This file
```

## 🚀 Deployment

### Backend Deployment

**Recommended: Google Cloud Run** (proximity to Gemini API)

```bash
# Build and deploy
npm run build
gcloud run deploy translator-jhu-backend \
  --source . \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

**Alternative: Docker**

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY dist ./dist
EXPOSE 8080
CMD ["npm", "start"]
```

### Extension Distribution

1. **Chrome Web Store**: Package and submit extension
2. **Enterprise**: Use Chrome Enterprise policies for deployment
3. **Development**: Load unpacked for testing

## 🔍 Performance

- **STT Latency**: ~200ms (Google Cloud Speech)
- **Translation**: ~300ms (Gemini 1.5 Flash)
- **TTS Latency**: ~150ms (ElevenLabs) to ~250ms (others)
- **Total Latency**: ~650ms end-to-end
- **Audio Quality**: 16kHz, optimized for speech

## 🛡 Security & Privacy

- **Local Processing**: Audio stays in your Google Cloud project
- **No Data Storage**: Conversations not permanently stored
- **Encrypted Transport**: All communication over HTTPS/WSS
- **API Key Security**: Environment-based configuration
- **Extension Permissions**: Minimal required permissions only

## 🤝 Contributing

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Google Cloud** for Speech-to-Text and Gemini AI
- **ElevenLabs** for ultra-realistic voice synthesis
- **Microsoft Azure** for Neural TTS services
- **Open Source Community** for the amazing tools and libraries

---

**Built with ❤️ for seamless global communication**
