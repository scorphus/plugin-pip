function pip-publish -a repo_flag repo_url -d "Show working dir status and publish a python package"
    function _gpublish_git_dirty
      echo (command git status -s --ignore-submodules=dirty ^/dev/null)
    end

    if test ! -e setup.py
        echo "I can't issue a publish here, there's no setup.py to work with!"
        return 1
    end

    switch "$repo_flag"
    case "--repository"
        ;
    case "-r"
        ;
    case "*"
        echo (omf::err)"You didn't specify a repository! (-r/--repository)"(omf::off)
    end

    if [ (_gpublish_git_dirty) ]
        echo (omf::err)"Your working directory is dirty! Look:"(omf::off)
        command git status
    end

    echo -ne (omf::em)
    echo "Package:" (command python setup.py --name --version)
    echo -ne (omf::off)

    read -l -p "echo 'Proceed with publish? (y/N) '" doit
    if test "$doit" = "y"
        python setup.py sdist upload $argv
    else
        echo "Giving up..."
    end
end
