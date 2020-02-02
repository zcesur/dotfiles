function pdf2html
    set -l src $argv[1]

    if string split -m1 -r . "$src" != 'pdf'
        echo "File $src does not have .pdf extension." 1>&2
        return 1
    end

    set -l filename (basename "$src" .pdf)
    set -l dst "$filename.html"
    set -l wd (mktemp -d)

    cp "$src" "$wd"
    pdftohtml "$wd/$src"
    cp "$wd/$filenames.html" "$dst"
    rm -rf -v "$wd"
   
    # Remove HTML line breaks
    sed -i 's/<br\/>//g' "$dst"

    # Remove/replace weird characters/entity references
    sed -i 's/\xe2\x80\x8b//g' "$dst"
    sed -i 's/&#160;/ /g' "$dst"

    # Remove page numberings
    sed -i '/^<hr\/>$/d' "$dst"
    sed -i -r 's/<a name=[0-9]+><\/a>//g' "$dst"
    cat "$dst" |
        tr '\n' '\f' |
        sed -r 's/\f-[0-9]+-\s\f//g' |
        tr '\f' '\n' |
        sponge "$dst"
    
    # # Remove line breaks and split into words
    cat "$dst" |
        tr -d '\n' |
        tr -s ' ' '\n' |
        sponge "$dst"
end
