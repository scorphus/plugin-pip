function ipip -d "Indexes-aware pip"
  if test (count $argv) -ge 2
    if test $argv[1] = "install"
      if test (count $PIP_INDEX_URLS) -ge 1
        set index_urls "--index-url"=$PIP_INDEX_URLS[1]"simple/"
        set trusted_host (__extract_domain $PIP_INDEX_URLS[1]"simple/")
        set trusted_hosts "--trusted-host" $trusted_host
        if test (count $PIP_INDEX_URLS) -ge 2
          for index_url in $PIP_INDEX_URLS[2..-1]
            set index_urls $index_urls "--extra-index-url"=$index_url"simple/"
            set trusted_host (__extract_domain $index_url"simple/")
            if not contains $trusted_host $trusted_hosts
              set trusted_hosts $trusted_hosts "--trusted-host" $trusted_host
            end
          end
        end
      end
      set pip_version (pip --version | awk '{print $2}')
      if [ "$pip_version" = "1.5.6" ]
        set -e trusted_hosts
      end
      pip install \
        --allow-external --allow-unverified $index_urls $trusted_hosts \
        -U $argv[2..-1]
    else if test $argv[1] = "search"
      if test (count $PIP_INDEX_URLS) -ge 1
        set index_urls "--index"=$PIP_INDEX_URLS[1]
        set trusted_host (__extract_domain $PIP_INDEX_URLS[1]"simple/")
        set trusted_hosts "--trusted-host" $trusted_host
      end
      pip search $index_urls $trusted_hosts $argv[2..-1]
    else
      echo "Sorry, we only support `install` and `search`, mate :("
      return 1
    end
  else
    echo "Wrong arguments number, dude :|"
    return 1
  end
end

function __extract_domain -a url
  if [ (uname) = "Darwin" ]
    alias sed "gsed"
  end
  echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;'
end
