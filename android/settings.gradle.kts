pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    val versionFile = file("$flutterSdkPath/bin/cache/flutter.version.json")
    require(versionFile.isFile) { "Run flutter --version to initialize the Flutter SDK" }
    val version = groovy.json.JsonSlurper().parse(versionFile) as Map<*, *>
    require(version["frameworkVersion"] == "3.50.0" &&
        version["frameworkRevision"] == "ab2912035e160d9cad6306df307576da6128ebdb") {
        "Patched Flutter Gradle plugin requires Flutter 3.50.0 (ab2912035e)"
    }
    includeBuild("../third_party/flutter_gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.3.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.20" apply false
}

include(":app")
