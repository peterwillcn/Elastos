## Preliminary dependency: setup_doc_tools.sh
## Will look for the Elastos.Trinity repo at the same level as this repo to generate Trinity plugins documentation

# DocStrap template documentation: https://github.com/docstrap/docstrap

# First need to build trinity in order to apply plugins documentation patches
../../Elastos.Trinity/ToolChains/bin/build all
# Generate the documentation
jsdoc -c ./jsdoc.conf.json -t ./node_modules/ink-docstrap/template -r ../../Elastos.Trinity/Runtime/plugins/ README.md