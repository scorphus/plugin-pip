function piplg -d "Alias to `pip list | grep -i foo`"
    pip list ^ /dev/null | grep -i $argv
end
