function pipfg -d "Alias to `pip freeze | grep -i foo`"
    pip freeze ^ /dev/null | grep -i $argv
end
