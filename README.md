# matrix-android-sdk2

Matrix SDK for Android, extracted from the Element Android application.

The SDK is still in beta, and replaces the [legacy Matrix Android SDK](https://github.com/matrix-org/matrix-android-sdk) provided by Matrix.org

## About

This repository contains the matrix-android-sdk extracted from the project [Element Android](https://github.com/vector-im/element-android)

Please open any issue in the Element Android project [Create an issue](https://github.com/vector-im/element-android/issues/new/choose)

## How to integrate the SDK in your application

To integrate the SDK to your application, add the following gradle dependency to the build.gradle of your application module:

> implementation 'com.github.matrix-org:matrix-android-sdk2:v0.0.1'

You need to add Jitpack as a repository in your main build.gradle file. Please follow instructions here: https://jitpack.io/

## Migrate from legacy SDK

Sadly there is no official documentation on how to migrate from the old SDK to the new one. Because the new SDK API is totally new, we guess that there is no easy way to handle a migration.

We advice that new applications uses this new SDK.