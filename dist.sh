#!/bin/bash -e
OUTPUT_DIR_ROOT=src/out
OUT_PLARCO=ios-arm64-release

OUTPUT_DIR=${OUTPUT_DIR_ROOT}/${OUT_PLARCO}
python3 "./src/tools_webrtc/libs/generate_licenses.py" --target :webrtc "${OUTPUT_DIR}" "${OUTPUT_DIR}"
mv ${OUTPUT_DIR}/LICENSE.md ./LICENSE-${OUT_PLARCO}.md



OUTPUT_DIR_ROOT=src/out

# Loop through all directories in OUTPUT_DIR_ROOT
for OUT_PLARCO in $(ls -d ${OUTPUT_DIR_ROOT}/*/ | xargs -n 1 basename); do
    OUTPUT_DIR=${OUTPUT_DIR_ROOT}/${OUT_PLARCO}
    python3 "./src/tools_webrtc/libs/generate_licenses.py" --target :webrtc "${OUTPUT_DIR}" "${OUTPUT_DIR}"
    mv "${OUTPUT_DIR}/LICENSE.md" "./LICENSE-${OUT_PLARCO}.md"
done

rm -rf out
mkdir -p out/webrtc_debug
mv *debug.md out/webrtc_debug
cp -r webrtc_debug.xcframework out/webrtc_debug
zip -r ./out/webrtc_debug.zip ./out/webrtc_debug

mkdir -p out/webrtc_release
mv *release.md out/webrtc_release
cp -r webrtc_release.xcframework out/webrtc_release
zip -r ./out/webrtc_release.zip ./out/webrtc_release
