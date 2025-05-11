# python_channel
add to pubspec.yaml
```yaml
dependencies:
  python_channel:
    git:
      url: https://github.com/NguyenVanDuongTDH/python_channel.git
```

thêm ở đầu file
android.build.gradle.kts
```build.gradle
buildscript {
    repositories {
        google()
        mavenCentral()
        maven(url = "https://chaquo.com/maven") // ✅ Chaquopy repo
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.2.0") // hoặc 8.7.0 nếu bạn đã dùng
        classpath("com.chaquo.python:gradle:12.0.0")      // ✅ Chaquopy plugin
    }
}
```

build.gradle.kts
```build.gradle
plugins {
    id "com.android.application"
    id 'com.chaquo.python' //add chaquopy
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}
//
//
//
android {
//
//
//
defaultConfig {
        //
        //
        //
        ndk {
         abiFilters "armeabi-v7a", "arm64-v8a", "x86", "x86_64"
        }
        python {
                // buildPython "C:/Users/Ahmed/AppData/Local/Programs/Python/Python311/python.exe"
                pip {
                    // A requirement specifier, with or without a version number:
                    install "numpy"
                }
            }
        defaultConfig {
        version = "3.8"
        }
        sourceSets {
             main {
                 python.srcDir "src/main/python"
             }
        }
}
//
//
//
}
```
 
