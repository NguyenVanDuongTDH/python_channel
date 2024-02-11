# python_channel
add to pubspec.yaml
```yaml
dependencies:
  python_channel:
    git:
      url: https://github.com/NguyenVanDuongTDH/python_channel.git
```


build.gradle:android
```build.gradle
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google()
        mavenCentral()
        maven { url "https://chaquo.com/maven" } //add maven chaquopy
    }

    dependencies {
        classpath "com.chaquo.python:gradle:12.0.0" //add chaquopy
        classpath 'com.android.tools.build:gradle:7.2.0'//add chaquopy
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```

build.gradle:app
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
        abiFilters "arm64-v8a"
        }
        python {
                // buildPython "C:/Users/Ahmed/AppData/Local/Programs/Python/Python311/python.exe"
                pip {
                    // A requirement specifier, with or without a version number:
                    install "numpy"
                }
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
 
