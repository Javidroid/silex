rm -f pubspec.lock && rm -f ios/Podfile.lock && rm -f -r build && rm -f -r ios/.symlinks && rm -f -r android/.gradle && rm -f -r android/build && rm -f -r android/app/.gradle && rm -f -r android/app/build && flutter precache --ios && flutter clean && flutter pub get && cd ios && pod deintegrate && pod install && pod update && pod install && pod update && pod install && cd ..
