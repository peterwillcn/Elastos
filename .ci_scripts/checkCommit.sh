
# skip submodule:ToolChains
# skip commit with ci-skip or skip-ci
# since one day ago

git submodule foreach '
if [ "$path" = "ToolChains" ]; then
    return 0
else
    if
        git log --since=1.days --grep="ci-skip" --grep="skip-ci" --invert-grep -i | grep Author
    then
        echo "find commit"
        return 1
    fi
fi
'
