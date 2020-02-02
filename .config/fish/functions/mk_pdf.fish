function mk_pdf
    set -l size $argv[1]
    set -l input $argv[2]
    set -l output $argv[3]

    convert "$input" \
    -resize "$size>" \
    -gravity center \
    "$output"
end

