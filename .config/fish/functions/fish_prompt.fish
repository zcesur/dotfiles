function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    
    set -g __fish_git_prompt_showupstream "git"

    set -g __fish_git_prompt_char_stateseparator ""
    set -g __fish_git_prompt_char_stagedstate ""
    set -g __fish_git_prompt_char_dirtystate ""
    set -g __fish_git_prompt_char_untrackedfiles ""
    set -g __fish_git_prompt_char_invalidstate ""
    set -g __fish_git_prompt_char_cleanstate ""

    set -g __fish_git_prompt_hide_stagedstate 1
    set -g __fish_git_prompt_hide_dirtystate 1
    set -g __fish_git_prompt_hide_untrackedfiles 1
    set -g __fish_git_prompt_hide_invalidstate 1
    set -g __fish_git_prompt_hide_cleanstate 1


    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch magenta --bold
    end
    if not set -q __fish_git_prompt_char_upstream_ahead
        set -g __fish_git_prompt_char_upstream_ahead "↑"
    end
    if not set -q __fish_git_prompt_char_upstream_behind
        set -g __fish_git_prompt_char_upstream_behind "↓"
    end
    if not set -q __fish_git_prompt_char_upstream_prefix
        set -g __fish_git_prompt_char_upstream_prefix ""
    end


    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate blue
    end
    if not set -q __fish_git_prompt_color_stagedstate
        set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
        set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    end
    if not set -q __fish_git_prompt_color_cleanstate
        set -g __fish_git_prompt_color_cleanstate green --bold
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    set -l color_cwd
    set -l prefix
    set -l suffix
    switch "$USER"
        case root toor
            set suffix '#'
        case '*'
            set suffix '❯'
    end

    # PWD
    set_color cyan
    echo -n (prompt_pwd)
    set_color normal

    printf '%s ' (__fish_vcs_prompt)

    if not test $last_status -eq 0
        set_color $fish_color_error
        echo -n "[$last_status] "
        set_color normal
    end

    echo -n "$suffix "
end
