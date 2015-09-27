# -*- coding: utf-8 -*-

# This file is based on original work by Benedykt Wieczorek

# Copyright © 2015 Benedykt Wieczorek <pawlacz@yandex.ru>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function __fish_pip_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = "pip" ]
    return 0
  end
  return 1
end

function __fish_pip_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

function __fish_pip_search_packages
  set cmd (commandline -op)
  set q $cmd[3]
  pip search $q | grep -ie "^$q" | awk -F' - ' '{print $1}' | sed 's/ //g'
end


# keyword
complete --no-files -c pip -n "__fish_pip_needs_command" -a install   -d "Install packages."
complete --no-files -c pip -n "__fish_pip_needs_command" -a uninstall -d "Uninstall packages."
complete --no-files -c pip -n "__fish_pip_needs_command" -a freeze    -d "Output installed packages in requirements format."
complete --no-files -c pip -n "__fish_pip_needs_command" -a list      -d "List installed packages."
complete --no-files -c pip -n "__fish_pip_needs_command" -a show      -d "Show information about installed packages."
complete --no-files -c pip -n "__fish_pip_needs_command" -a search    -d "Search PyPI for packages."
complete --no-files -c pip -n "__fish_pip_needs_command" -a wheel     -d "Build wheels from your requirements."
complete --no-files -c pip -n "__fish_pip_needs_command" -a help      -d "Show help for commands."


# general
complete --no-files -c pip -s h, -l help             -d "Show help."
complete --no-files -c pip -s v, -l verbose          -d "Give more output. Option is additive, and can be used up to 3 times."
complete --no-files -c pip -s V, -l version          -d "Show version and exit."
complete --no-files -c pip -s q, -l quiet            -d "Give less output."
complete --no-files -c pip       -l log-file      -r -d "Path to a verbose non-appending log, that only logs failures. This log is active by default at /home/daz/.pip/pip.log."
complete --no-files -c pip       -l log           -r -d "Path to a verbose appending log. This log is inactive by default."
complete --no-files -c pip       -l proxy         -r -d "Specify a proxy in the form [user                                                                                      : passwd@]proxy.server                  : port."
complete --no-files -c pip       -l timeout       -r -d "Set the socket timeout (default 15 seconds)."
complete --no-files -c pip       -l exists-action -r -d "Default action when a path already exists                                                                              : (s)witch, (i)gnore, (w)ipe, (b)ackup."
complete --no-files -c pip       -l cert          -r -d "Path to alternate CA bundle."


# install packages
complete --no-files -c pip -n "__fish_pip_using_command install" -a "(__fish_pip_search_packages)" -d "Package"


# install
complete --no-files -c pip -n "__fish_pip_using_command install" -s e -l editable         -d "Install a project in editable mode (i.e. setuptools \"develop mode\") from a local project path or a VCS url."
complete --no-files -c pip -n "__fish_pip_using_command install" -s r -l requirement      -d "Install from the given requirements file. This option can be used multiple times."
complete --no-files -c pip -n "__fish_pip_using_command install" -s b -l build            -d "Directory to unpack packages into and build in. The default in a virtualenv is \"<venv path>/build\". The default for global installs is \"<OS tempdir>/pip_build_<username>\"."
complete --no-files -c pip -n "__fish_pip_using_command install" -s t -l target           -d "Install packages into <dir>."
complete --no-files -c pip -n "__fish_pip_using_command install" -s d -l download         -d "Download packages into <dir> instead of installing them, regardless of what's already installed."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l download-cache   -d "Cache downloaded packages in <dir>."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l src              -d "Directory to check out editable projects into. The default in a virtualenv is \"<venv path>/src\". The default for global installs is \"<currentdir>/src\"."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l upgrade          -d "Upgrade all packages to the newest available version. This process is recursive regardless of whether a dependency is already satisfied."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l force-reinstall  -d "When upgrading, reinstall all packages even if they are already up-to-date."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l ignore-installed -d "Ignore the installed packages (reinstalling instead)."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l no-deps          -d "Don't install package dependencies."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l install-option   -d "Extra arguments to be supplied to the setup.py install command (use like --install-option=\"--install-scripts=/usr/local/bin\"). Use multiple --install-option options to pass multiple options to setup.py install. If you are using an option with a directory path, be sure to use absolute path."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l global-option    -d "Extra global options to be supplied to the setup.py call before the install command."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l user             -d "Install using the user scheme."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l egg              -d "Install packages as eggs, not 'flat', like pip normally does. This option is not about installing *from* eggs. (WARNING: Because this option overrides pip's normal install logic, requirements files may not behave as expected.)"
complete --no-files -c pip -n "__fish_pip_using_command install"      -l root             -d "Install everything relative to this alternate root directory."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l compile          -d "Compile py files to pyc"
complete --no-files -c pip -n "__fish_pip_using_command install"      -l no-compile       -d "Do not compile py files to pyc"
complete --no-files -c pip -n "__fish_pip_using_command install"      -l no-use-wheel     -d "Do not Find and prefer wheel archives when searching indexes and find-links locations."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l pre              -d "Include pre-release and development versions. By default, pip only finds stable versions."
complete --no-files -c pip -n "__fish_pip_using_command install"      -l no-clean         -d "Don't clean up build directories."


# list
complete --no-files -c pip -n "__fish_pip_using_command list" -s o -l  outdated -d "List outdated packages (excluding editables)"
complete --no-files -c pip -n "__fish_pip_using_command list" -s u -l  uptodate -d "List uptodate packages (excluding editables)"
complete --no-files -c pip -n "__fish_pip_using_command list" -s e -l  editable -d "List editable projects."
complete --no-files -c pip -n "__fish_pip_using_command list" -s l -l  local    -d "If in a virtualenv that has global access, do not list globally-installed packages."
complete --no-files -c pip -n "__fish_pip_using_command list"      -l  pre      -d "Include pre-release and development versions. By default, pip only finds stable versions."
