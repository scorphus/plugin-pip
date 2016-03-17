function pip-uninstall-all -d "Uninstall all pip packages"
    if [ (count $argv) -gt 0 ]
        switch $argv[1]
        case "-h*" "--h*" "help"
            echo "Usage: pip-uninstall-all [-i|--interactive]"
            return 0
        case "-i*" "--interactive*" "interactive"
            set interactive 1
        end
    end
    set -l read_prompt ""
    if test "$VIRTUAL_ENV" = ""
        set read_prompt (omf::err)"We are NOT in a virtualenv, proceed (y/N)? "(omf::off)
    else
        set read_prompt (omf::em)"We are in "(basename $VIRTUAL_ENV)", proceed (y/N)? "(omf::off)
    end
    read -l -p "echo '$read_prompt'" doit
    if test "$doit" = "y"
        for package in (pip list | egrep -iv "pip|setuptools|wheel" | cut -d\  -f1)
            echo -n "Uninstalling $package... "
            if set -q interactive
                pip uninstall -q $package
            else
                pip uninstall -q $package -y
                echo " ...done!"
            end
        end
        echo "Installing/updating pip, setuptools and wheel..."
        pip install -U pip setuptools wheel
    end
end
