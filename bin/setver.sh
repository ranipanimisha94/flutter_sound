#!/bin/bash
if [ -z "$1" ]; then
        echo "Correct usage is $0 <Version>"
        exit -1
fi



VERSION=$1
VERSION_CODE=${VERSION//./}
VERSION_CODE=${VERSION_CODE//+/}

gsed -i  "s/const VERSION = .*$/const VERSION = '$VERSION'/"                  flutter_sound_web/src/flutter_sound.js;
gsed -i  "s/const PLAYER_VERSION = .*$/const PLAYER_VERSION = '$VERSION'/"    flutter_sound_web/src/flutter_sound_player.js;
gsed -i  "s/const RECORDER_VERSION = .*$/const RECORDER_VERSION = '$VERSION'/"    flutter_sound_web/src/flutter_sound_recorder.js;



gsed -i  "s/^\( *s.version *= *\).*$/\1'$VERSION'/"                                     flutter_sound_core/flutter_sound_core.podspec 2>/dev/null

gsed -i  "s/^\( *s.dependency *'flutter_sound_core', *\).*$/\1'$VERSION'/"                        flutter_sound/ios/flutter_sound.podspec 2>/dev/null
gsed -i  "s/^\( *s.dependency *'flutter_sound_core', *\).*$/\1'$VERSION'/"                        flutter_sound/ios/flauto.podspec 2>/dev/null
gsed -i  "s/^\( *s.dependency *'flutter_sound_core', *\).*$/\1'$VERSION'/"                        flutter_sound/ios/flutter_sound_lite.podspec 2>/dev/null
gsed -i  "s/^\( *s.dependency *'flutter_sound_core', *\).*$/\1'$VERSION'/"                        flutter_sound/ios/flauto_lite.podspec 2>/dev/null


gsed -i  "s/^\( *versionName *\).*$/\1'$VERSION'/"                                      flutter_sound_core/android/build.gradle
gsed -i  "s/^\( *versionCode *\).*$/\11$VERSION_CODE/"                                  flutter_sound_core/android/build.gradle

gsed -i  "s/^\( *\/* *implementation 'com.github.canardoux:flutter_sound_core:\).*$/\1$VERSION'/"             flutter_sound/android/build.gradle


gsed -i  "s/^\( *version *\).*$/\1'$VERSION'/"                                          flutter_sound/android/build.gradle

gsed -i  "s/^\( *s.version *= *\).*$/\1'$VERSION'/"                                     flutter_sound/ios/flutter_sound.podspec 2>/dev/null
gsed -i  "s/^\( *s.version *= *\).*$/\1'$VERSION'/"                                     flutter_sound/ios/flauto.podspec 2>/dev/null
gsed -i  "s/^\( *version: *\).*$/\1$VERSION/"                                           flutter_sound/pubspec.yaml
gsed -i  "s/^\( *flutter_sound_platform_interface: *#* *\).*$/\1$VERSION/"              flutter_sound/pubspec.yaml
gsed -i  "s/^\( *flauto_platform_interface2: *#* *\).*$/\1$VERSION/"                     flutter_sound/pubspec.yaml
gsed -i  "s/^\( *flutter_sound_web: *#* *\).*$/\1$VERSION/"                             flutter_sound/pubspec.yaml
gsed -i  "s/^\( *flauto_web: *#* *\).*$/\1$VERSION/"                                    flutter_sound/pubspec.yaml

gsed -i  "s/^\( *version: *\).*$/\1$VERSION/"                                           flutter_sound/example/pubspec.yaml
gsed -i  "s/^\( *flutter_sound: *#* *\^*\).*$/\1$VERSION/"                              flutter_sound/example/pubspec.yaml
gsed -i  "s/^\( *#* *flutter_sound_platform_interface: *#* *\^*\).*$/\1$VERSION/"       flutter_sound/example/pubspec.yaml
gsed -i  "s/^\( *#* *flutter_sound_web: *#* *\^*\).*$/\1$VERSION/"                      flutter_sound/example/pubspec.yaml
gsed -i  "s/^\( *\/* *implementation 'com.github.canardoux:flutter_sound_core:\).*$/\1$VERSION'/"       flutter_sound/example/android/app/build.gradle

gsed -i  "s/^\( *flauto: *#* *\^*\).*$/\1$VERSION/"                                     flutter_sound/example/pubspec.yaml
gsed -i  "s/^\( *#* *flauto_platform_interface2: *#* *\^*\).*$/\1$VERSION/"              flutter_sound/example/pubspec.yaml
gsed -i  "s/^\( *#* *flauto_web: *#* *\^*\).*$/\1$VERSION/"                             flutter_sound/example/pubspec.yaml

gsed -i  "s/^\( *libraryVersion = \).*$/\1$VERSION/"                                    flutter_sound_core/android/gradle.properties
gsed -i  "s/^\( *flutter_sound_lite: *#* *\^*\).*$/\1$VERSION/"                         flutter_sound/example/pubspec.yaml
gsed -i  "s/^\( *## \).*$/\1$VERSION/"                                                  flutter_sound/CHANGELOG.md
gsed -i  "s/^\( *## \).*$/\1$VERSION/"                                                  flutter_sound_core/CHANGELOG.md 2>/dev/null
gsed -i  "s/^\( *## \).*$/\1$VERSION/"                                                  flutter_sound_platform_interface/CHANGELOG.md
gsed -i  "s/^\( *version: *\).*$/\1$VERSION/"                                           flutter_sound_platform_interface/pubspec.yaml
gsed -i  "s/^\( *version *= *\).*$/\1'$VERSION'/"                                       flutter_sound_core/android/bintray.gradle 2>/dev/null
gsed -i  "s/^\( *version: *\).*$/\1$VERSION/"                                           flutter_sound_web/pubspec.yaml
gsed -i  "s/^\( *flutter_sound_platform_interface: *#* *\).*$/\1$VERSION/"              flutter_sound_web/pubspec.yaml
#gsed -i  "s/^\( *flauto_platform_interface2: *#* *\).*$/\1$VERSION/"                     flutter_sound_web/pubspec.yaml
gsed -i  "s/^\( *## \).*$/\1$VERSION/"                                                  flutter_sound_web/CHANGELOG.md
gsed -i  "s/^\( *\"version\": *\).*$/\1\"$VERSION\",/"                                  flutter_sound_web/package.json
###gsed -i  "s/^\( *<script src=\"https:\/\/cdn.jsdelivr.net\/npm\/flutter_sound_core@\)[^\/]*/\1$VERSION/g" flutter_sound/example/web/index.html
###gsed -i  "s/^\( *<script src=\"https:\/\/cdn.jsdelivr.net\/npm\/flutter_sound_core@[^+/]*\)[^/]*/\1/g" flutter_sound/example/web/index.html
gsed -i  "s/^\( *s\.version *= *\).*$/\1'$VERSION'/"                                    flutter_sound_core/flutter_sound_core.podspec

gsed -i  "s/^tau_version:.*/tau_version: $VERSION/"                                     doc/_config.yml
gsed -i  "s/^\( *version: \).*/\1$VERSION/"                                             doc/_data/sidebars/mydoc_sidebar.yml
