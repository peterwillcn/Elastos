## Preliminary dependency: setup_doc_tools.sh
## Will look for the Elastos.Trinity repo at the same level as this repo to generate Trinity plugins documentation

# DocStrap template documentation: https://github.com/docstrap/docstrap

jsdoc -c ./jsdoc.conf.json -t ./node_modules/ink-docstrap/template -r ../../Elastos.Trinity/Plugins/ README.md