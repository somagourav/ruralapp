plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}
dependencies {
  // Import the Firebase BoM
  implementation(platform("com.google.firebase:firebase-bom:33.12.0"))


  // TODO: Add the dependencies for Firebase products you want to use
  // When using the BoM, don't specify versions in Firebase dependencies
  implementation("com.google.firebase:firebase-analytics")


  // Add the dependencies for any other desired Firebase products
  // https://firebase.google.com/docs/android/setup#available-libraries
}

android {
    namespace = "com.example.ruralapp"
    compileSdk = flutter.compileSdkVersion
    // ndkVersion = flutter.ndkVersion changes
    ndkVersion = "27.0.12077973"

    compileOptions {
        // sourceCompatibility = JavaVersion.VERSION_11
        // targetCompatibility = JavaVersion.VERSION_11  changes
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
        // jvmTarget = JavaVersion.VERSION_11.toString() changes
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.ruralapp"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // minSdk = flutter.minSdkVersion changes
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}



// plugins {
//     id("com.android.application")
//     id("org.jetbrains.kotlin.android")
//     id("com.google.gms.google-services")
// }

// android {
//     namespace = "com.example.ruralapp"
//     compileSdk = 34

//     defaultConfig {
//         applicationId = "com.example.ruralapp"
//         minSdk = 21
//         targetSdk = 34
//         versionCode = 1
//         versionName = "1.0"
//     }

//     buildTypes {
//         release {
//             isMinifyEnabled = false
//             proguardFiles(
//                 getDefaultProguardFile("proguard-android-optimize.txt"),
//                 "proguard-rules.pro"
//             )
//         }
//     }

//     compileOptions {
//         sourceCompatibility = JavaVersion.VERSION_17
//         targetCompatibility = JavaVersion.VERSION_17
//     }

//     kotlinOptions {
//         jvmTarget = "17"
//     }
// }

// dependencies {
//     // implementation(platform("com.google.firebase:firebase-bom:33.2.0"))
//     implementation(platform("com.google.firebase:firebase-bom:33.12.0"))
//     implementation("com.google.firebase:firebase-auth-ktx")
//     implementation("com.google.firebase:firebase-analytics-ktx")
//     implementation("com.google.firebase:firebase-analytics")

//     implementation("androidx.core:core-ktx:1.12.0")
//     implementation("androidx.appcompat:appcompat:1.6.1")
//     implementation("com.google.android.material:material:1.9.0")
//     implementation("androidx.constraintlayout:constraintlayout:2.1.4")
// }
