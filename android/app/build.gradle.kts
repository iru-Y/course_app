import java.util.Properties
import java.io.FileInputStream
import java.io.FileNotFoundException // Added import

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = file("../key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    println("Key Alias: ${keystoreProperties["keyAlias"]}")
    println("Store File: ${keystoreProperties["storeFile"]}")
} else {
    throw FileNotFoundException("key.properties file not found")
}

android {
    namespace = "com.example.course"
    compileSdk = 33

    defaultConfig {
        applicationId = "com.example.course"
        minSdk = 21
        targetSdk = 33
        versionCode = 1
        versionName = "1.0.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    applicationVariants.all {
        outputs.forEach {
            val outputImpl = it as com.android.build.gradle.internal.api.ApkVariantOutputImpl
            outputImpl.outputFileName = "course-${versionName}-alpha.apk"
        }
    }
}

flutter {
    source = "../.." // Changed to String path
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
}