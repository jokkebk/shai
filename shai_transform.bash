# Usage: bind this function to a keybinding in your bash configuration
# to transform the current command line input with ChatGPT. Unlike
# Fish setup, you don't need to start with # in the command line.
#
# source /path/to/shai_transform.bash
# bind '"\C-q":"shai_transform /path/to/shai your_openai_api_key\n"'

shai_transform() {
    # Get the current command line input
    query=$READLINE_LINE

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
        READLINE_LINE=$result
    else
        echo "Error"
    fi
}