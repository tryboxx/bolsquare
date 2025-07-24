rm -r ./scripts/xcov/xcov_output/
xcov -p bolsquare.xcodeproj -s bolsquare -o scripts/xcov/xcov_output -x scripts/xcov/xcov_ignore.xcovignore -r bolsquare
open ./scripts/xcov/xcov_output/index.html
