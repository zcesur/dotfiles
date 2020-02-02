function mk_logo
    set -l size $argv[1]
    set -l input $argv[2]
    set -l output $argv[3]

    convert "$input" \
    -thumbnail "$size>" \
    -gravity center \
    -background transparent \
    -extent "$size" \
    "$output"

end

