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
 
