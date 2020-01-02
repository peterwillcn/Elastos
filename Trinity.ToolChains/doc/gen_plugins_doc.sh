## Preliminary dependency: setup_doc_tools.sh
## Will look for the Elastos.Trinity repo at the same level as this repo to generate Trinity plugins documentation

# DocStrap template documentation: https://github.com/docstrap/docstrap

# First need to build trinity in order to apply plugins documentation patches
../../ToolChains/bin/build runtime
# Generate the documentation

typedoc ../typings/dist --out ./out --mode file --tsconfig ./tsconfig.json --theme ./trinity-plugins-theme --readme ./README.md --name "Trinity Plugins API Reference" --excludeExternals --includeDeclarations
