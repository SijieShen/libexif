
WORKSPACEFILEPATH="LibExif/LibExif.xcodeproj"

xcodebuild -project "${WORKSPACEFILEPATH}" \
    -configuration "Release" \
    -sdk "iphoneos" \
    -scheme "GSPro-LibExifFAT" clean &&

xcodebuild -project "${WORKSPACEFILEPATH}" \
    -configuration "Release" \
    -sdk "iphoneos" \
    -scheme "GSPro-LibExifFAT" build
