rm -r xcFramework

xcodebuild archive \
  -project RecycleUI.xcodeproj \
  -scheme RecycleUI \
  -configuration Release \
  -sdk iphoneos \
  -archivePath "archives/device/RecycleUI" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
  
xcodebuild archive \
  -project RecycleUI.xcodeproj \
  -scheme RecycleUI \
  -configuration Release \
  -sdk iphonesimulator \
  -archivePath "archives/simulator/RecycleUI" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
           -framework archives/device/RecycleUI.xcarchive/Products/Library/Frameworks/RecycleUI.framework \
           -framework archives/simulator/RecycleUI.xcarchive/Products/Library/Frameworks/RecycleUI.framework \
           -output xcFramework/RecycleUI.xcframework
