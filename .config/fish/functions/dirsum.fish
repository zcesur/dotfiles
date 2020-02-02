function dirsum
    find $argv[1] -type f -exec md5sum {} \; | sort -k 2 | md5sum
end

