#!/bin/bash
if [ -z "$1" ]; then
        echo "Correct usage is $0 <Version> "
        exit -1
fi



VERSION=$1
VERSION_CODE=${VERSION#./}
VERSION_CODE=${VERSION_CODE#+/}

bin/flavor.sh FULL
bin/reldev.sh REL
bin/setver.sh $VERSION
 
cd flutter_sound
#flutter clean
#flutter pub get
flutter pub publish
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi
cd ..

bin/flavor.sh LITE

cd flutter_sound
#flutter clean
#flutter pub get
flutter pub publish
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi
cd ..

bin/flavor.sh FULL



cd flutter_sound
flutter analyze lib
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi
dartdoc lib
if [ $? -ne 0 ]; then
    echo "Error"
    #exit -1
fi
rm -rf doc
cd example
flutter analyze lib
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi
dartdoc lib
if [ $? -ne 0 ]; then
    echo "Error"
    #exit -1
fi
rm -rf doc
cd ../..




cd flutter_sound/example/ios
pod cache clean --all
rm Podfile.lock
rm -rf .symlinks/
cd ..
flutter clean
flutter pub get
cd ios
pod update
pod repo update
pod install --repo-update
pod update
pod install
arch -x86_64 pod install --repo-update
cd ..
flutter build ios
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi

# Bug in flutter tools : if "flutter build --release" we must first "--debug" and then "--profile" before "--release"
flutter build apk --debug
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi

flutter build web
if [ $? -ne 0 ]; then
    echo "Error"
    exit -1
fi

cd ../..


bin/doc.sh $VERSION

git add .
git commit -m "TAU : Version $VERSION"
git push origin
git push gl
#git push bb
if [ ! -z "$VERSION" ]; then
        git tag -f $VERSION
        git push  -f origin $VERSION
        git push  -f gl $VERSION
        #git push  -f bb $VERSION
fi

cd tau_core
git add .
git commit -m "TAU : Version $VERSION"
git push origin
git push gl
#git push bb
if [ ! -z "$VERSION" ]; then
    git tag -f $VERSION
    git push  -f origin $VERSION
    git push  -f gl $VERSION
    #git push  -f bb $VERSION
fi
cd ..


#git add .
#git commit -m "Release Version: $VERSION"
#if [ ! -z "$VERSION" ]; then
#        git tag -f $VERSION
#        git push --tag -f
#fi
#git checkout gh-pages
#git merge master
#git push
#if [ ! -z "$VERSION" ]; then
#        git tag -f $VERSION
 #       git push --tag -f
#fi
#git checkout master




echo 'E.O.J'
