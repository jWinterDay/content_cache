#!/bin/sh

pushd packages/content_cache_devtools_extension

dart run build_runner build --delete-conflicting-outputs && dart format -l 140 lib

popd
