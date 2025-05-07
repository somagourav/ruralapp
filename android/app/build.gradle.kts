// plugins {
//     id("com.android.application")
//     id("kotlin-android")
//     id("dev.flutter.flutter-gradle-plugin")
//     id("com.google.gms.google-services")
//     // id("org.jetbrains.kotlin.android")
//     kotlin("android")
//     kotlin("android.extensions")
//     id("kotlin-parcelize")
// }
// dependencies {
//     implementation(platform("com.google.firebase:firebase-bom:33.12.0"))
//     implementation("com.google.firebase:firebase-analytics")
//     implementation("com.google.firebase:firebase-auth")
//     implementation("com.google.firebase:firebase-firestore")
//     implementation("com.google.firebase:firebase-firestore-ktx:24.9.0")
//     implementation("com.android.support:appcompat-v7:28.0.0")
//     implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.5.21")

//   // Add the dependencies for any other desired Firebase products
//   // https://firebase.google.com/docs/android/setup#available-libraries
// }

// android {
//     namespace = "com.example.ruralapp"
//     compileSdk = 35
//     // ndkVersion = flutter.ndkVersion changes
//     ndkVersion = "27.0.12077973"

//     compileOptions {
//         // sourceCompatibility = JavaVersion.VERSION_11
//         // targetCompatibility = JavaVersion.VERSION_11  changes
//         sourceCompatibility = JavaVersion.VERSION_17
//         targetCompatibility = JavaVersion.VERSION_17
//     }

//     kotlinOptions {
//         jvmTarget = "17"
//         // jvmTarget = JavaVersion.VERSION_11.toString() changes
//     }

//     defaultConfig {
//         // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//         applicationId = "com.example.ruralapp"
//         // You can update the following values to match your application needs.
//         // For more information, see: https://flutter.dev/to/review-gradle-config.
//         // minSdk = flutter.minSdkVersion changes
//         minSdk = 23
//         targetSdk = 35
//         versionCode = 1
//         versionName = "1.0"
//     }

//     buildTypes {
//         release {
//             // TODO: Add your own signing config for the release build.
//             // Signing with the debug keys for now, so `flutter run --release` works.
//             signingConfig = signingConfigs.getByName("debug")
//         }
//     }
// }

// flutter {
//     source = "../.."
// }

import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    // Remove this line: id("kotlin-android-extensions")
    kotlin("android")
    id("kotlin-parcelize") // Make sure this is included
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-firestore-ktx:24.9.0")
    implementation("com.android.support:appcompat-v7:28.0.0")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.5.21")
}
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
keystoreProperties.load(FileInputStream(keystorePropertiesFile))
android {
    namespace = "com.somagourav.ruralapp"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    signingConfigs {
        create("release") {
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            signingConfig = signingConfigs.getByName("release")
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.somagourav.ruralapp"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }


}

flutter {
    source = "../.."
}
