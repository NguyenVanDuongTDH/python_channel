# python_channel
add to pubspec.yaml
```yaml
dependencies:
  python_channel:
    git:
      url: https://github.com/NguyenVanDuongTDH/python_channel.git
```

```build.gradle
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google()
        mavenCentral()
        maven { url "https://chaquo.com/maven" }
    }

    dependencies {
        classpath "com.chaquo.python:gradle:12.0.0"
        classpath 'com.android.tools.build:gradle:7.2.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}
```
 
