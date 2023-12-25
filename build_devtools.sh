#
pushd packages/content_cache

rm -rf extension/devtools/build
mkdir extension/devtools/build

popd


#
pushd packages/content_cache_devtools_extension

flutter pub get && dart run devtools_extensions build_and_copy \
  --source=. \
  --dest=../content_cache/extension/devtools

popd