set -o vi

alias icat="kitty +kitten icat"

# ls aliases
alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
alias la="ls -a --color=auto"

# recursive grep aliases
alias rgc='grep -r --include="*.h" --include="*.c" --include="*.hpp" --include="*.cpp" --include="*.mako"'
alias rgp='grep -r --include="*.py"'
alias rgj='grep -r --include="*.json"'
alias rgb='grep -r --include="BUILD"'

# bazel aliases
alias bq='bazel query'
alias bb='bazel build'
alias br='bazel run'
alias bt='bazel test --test_output=all'
alias btt='bazel test --test_output=all --keep_going --test_tag_filters=native'
