# 🏗️ HUMIC Engineering - Sistem Cetak Sertifikat

Sistem cetak sertifikat digital yang dikembangkan oleh HUMIC Engineering untuk mengelola dan mencetak sertifikat secara otomatis dengan template yang dapat dikustomisasi.

## 📋 Deskripsi Project

Project ini terdiri dari dua komponen utama:

- **Mobile App (Flutter)** - Aplikasi mobile untuk input data dan preview sertifikat
- **Backend API (Node.js)** - Server API untuk mengelola data dan proses sertifikat

## 🚀 Fitur Utama

### Mobile App Features

- ✅ **Autentikasi User** - Login dengan email dan password
- ✅ **Input Data Sertifikat** - Upload file Excel dan input data manual
- ✅ **Template Sertifikat** - Multiple template sertifikat yang dapat dipilih
- ✅ **Preview Sertifikat** - Preview sertifikat sebelum cetak
- ✅ **Admin Panel** - Manajemen user dan data sertifikat
- ✅ **File Upload** - Support upload Excel dan gambar tanda tangan
- ✅ **Responsive Design** - UI yang responsif dan user-friendly

### Backend Features

- ✅ **RESTful API** - Endpoint untuk mobile app
- ✅ **Authentication** - JWT token authentication
- ✅ **File Management** - Upload dan storage file
- ✅ **Database Integration** - MySQL database
- ✅ **Firebase Integration** - Cloud storage support
- ✅ **Certificate Generation** - Generate sertifikat PDF

## 🛠️ Tech Stack

### Mobile App (Flutter)

- **Framework**: Flutter 3.5.3+
- **State Management**: GetX
- **HTTP Client**: http package
- **File Handling**: file_picker, path_provider
- **Image Processing**: image package
- **Local Storage**: shared_preferences
- **Excel Processing**: excel package
- **UI Components**: Material Design

### Backend (Node.js)

- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MySQL
- **Authentication**: JWT, bcrypt
- **File Upload**: Multer
- **Cloud Storage**: Firebase
- **CORS**: Enabled for cross-origin requests

## 📱 Screenshots

### Mobile App Screenshots

- Login Page dengan branding HUMIC Engineering
- Input Page untuk data sertifikat
- Template Selection
- Certificate Preview
- Admin Dashboard

## 🚀 Cara Menjalankan Project

### Prerequisites

- Flutter SDK 3.5.3+
- Node.js 18+
- MySQL Database
- Firebase Project (untuk cloud storage)

### Backend Setup

1. **Clone repository**

```bash
git clone <repository-url>
cd CetakSertif-BE
```

2. **Install dependencies**

```bash
npm install
```

3. **Setup environment variables**

```bash
# Buat file .env
cp .env.example .env

# Isi dengan konfigurasi yang sesuai
DB_HOST=localhost
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=humic_certificates
JWT_SECRET=your_jwt_secret
FIREBASE_CONFIG=your_firebase_config
PORT=3000
```

4. **Setup database**

```sql
-- Buat database dan tabel sesuai ERD
CREATE DATABASE humic_certificates;
-- Import struktur database dari docs/ERD.png
```

5. **Jalankan server**

```bash
npm start
# atau
npm run dev
```

### Mobile App Setup

1. **Masuk ke direktori mobile app**

```bash
cd humic_mobile
```

2. **Install Flutter dependencies**

```bash
flutter pub get
```

3. **Setup API configuration**

```bash
# Edit lib/app/data/config/api_config.dart
# Sesuaikan BASE_URL dengan backend server
```

4. **Jalankan aplikasi**

```bash
# Untuk Android
flutter run

# Untuk iOS
flutter run -d ios

# Build APK
flutter build apk --release
```

## 📁 Struktur Project

```
Humic/
├── CetakSertif-BE/          # Backend API
│   ├── src/
│   │   ├── config/          # Database & Firebase config
│   │   ├── controllers/     # API controllers
│   │   ├── middleware/      # Auth & file upload middleware
│   │   ├── models/          # Database models
│   │   ├── routes/          # API routes
│   │   └── uploads/         # File storage
│   └── package.json
│
└── humic_mobile/            # Flutter Mobile App
    ├── lib/
    │   ├── app/
    │   │   ├── constants/   # Colors & Typography
    │   │   ├── data/        # API config & models
    │   │   ├── modules/     # Feature modules
    │   │   ├── routes/      # App routing
    │   │   └── widgets/     # Reusable widgets
    │   └── main.dart
    ├── assets/
    │   ├── fonts/           # Custom fonts
    │   ├── icons/           # App icons
    │   └── images/          # App images
    └── pubspec.yaml
```

## 🔧 API Endpoints

### Authentication

- `POST /api-auth/login` - User login
- `POST /api-auth/register` - User registration

### User Management

- `GET /api-user/profile` - Get user profile
- `PUT /api-user/profile` - Update user profile

### Certificate Management

- `POST /api-sertifikat/create` - Create certificate
- `GET /api-sertifikat/list` - Get certificate list
- `GET /api-sertifikat/:id` - Get certificate detail
- `PUT /api-sertifikat/:id` - Update certificate
- `DELETE /api-sertifikat/:id` - Delete certificate

## 🎨 Design System

### Colors

- **Primary**: HUMIC Brand Color
- **Secondary**: Supporting colors
- **Background**: Clean white
- **Text**: Dark gray for readability

### Typography

- **Font Family**: Poppins (Regular, Medium, SemiBold, Bold)
- **Decorative**: Great Vibes (for certificates)

### Components

- Custom App Bar
- Custom Drawer Navigation
- Custom Input Fields
- Custom Buttons
- Certificate Templates

## 📊 Database Schema

### Tables

- **users** - User accounts dan roles
- **sertifikat** - Certificate data dan metadata
- **templates** - Certificate templates

### Relationships

- User dapat memiliki multiple sertifikat
- Sertifikat terkait dengan template tertentu
- File uploads disimpan di cloud storage

## 🔐 Security Features

- JWT Token Authentication
- Password Hashing dengan bcrypt
- File Upload Validation
- CORS Protection
- Input Sanitization

## 📦 Dependencies

### Mobile App Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  get: ^4.7.2
  http: ^1.3.0
  file_picker: ^8.1.1
  shared_preferences: ^2.5.3
  excel: ^4.0.6
  image: ^4.3.0
  permission_handler: ^12.0.0+1
  image_picker: ^1.1.2
```

### Backend Dependencies

```json
{
  "express": "^4.21.2",
  "mysql2": "^3.12.0",
  "bcrypt": "^5.1.1",
  "jsonwebtoken": "^9.0.2",
  "multer": "^1.4.5-lts.1",
  "firebase": "^11.3.1"
}
```

## 🚀 Deployment

### Backend Deployment

1. Setup production database
2. Configure environment variables
3. Deploy ke server (VPS/Cloud)
4. Setup reverse proxy (Nginx)

### Mobile App Deployment

1. Build release APK/IPA
2. Upload ke Google Play Store/App Store
3. Configure production API endpoints

## 🤝 Contributing

1. Fork repository
2. Buat feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

## 📝 License

Project ini dikembangkan oleh HUMIC Engineering. All rights reserved.

## 👥 Team

- **HUMIC Engineering** - Development Team
- **UI/UX Design** - Custom design system
- **Backend Development** - Node.js API
- **Mobile Development** - Flutter App

## 📞 Support

Untuk pertanyaan atau support, silakan hubungi:

- Email: support@humicengineering.com
- Website: www.humicengineering.com

---

**HUMIC Engineering** - Building Digital Solutions for Tomorrow 🏗️
