# Source the shai_transform function and bind in .zshrc
#
# source /Users/joonas.pihlajamaa/koodi/shai/shai_transform.zsh
#
# shai_transform_wrapper() {
#     shai_transform /path/to/shai your_openai_api_key
# }
#
# zle -N shai_transform_wrapper
# bindkey '^Q' shai_transform_wrapper

shai_transform() {
    # Get the current command line input
    query=$BUFFER

    # Get the binary path and API key from arguments
    shai_binary=$1
    api_key=$2

    # Check if arguments are missing
    if [[ -z "$shai_binary" || -z "$api_key" ]]; then
        echo "Error: Missing arguments."
        return
    fi

    # Execute the shai binary with the query and read the result
    result=$(env OPENAI_API_KEY=$api_key $shai_binary "$query" 2>/dev/null)

    # Replace the command line with the result or show error
    if [[ $? -eq 0 ]]; then
        BUFFER=$result
    else
        echo "Error"
    fi
}