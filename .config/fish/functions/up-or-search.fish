# References:
# https://github.com/fish-shell/fish-shell/issues/825#issuecomment-440286038
# https://github.com/2m/fish-history-merge/blob/master/functions/up-or-search.fish

function up-or-search -d "Depending on cursor position and current mode, either prefix search backward or move up one line"
    # If we are already in search mode, continue
    if commandline --search-mode
        commandline -f history-prefix-search-backward
        return
    end

    # If we are navigating the pager, then up always navigates
    if commandline --paging-mode
        commandline -f up-line
        return
    end

    # We are not already in search mode.
    # If we are on the top line, start search mode,
    # otherwise move up
    set lineno (commandline -L)

    switch $lineno
        case 1
            commandline -f history-prefix-search-backward
            history merge

        case '*'
            commandline -f up-line
    end
end
