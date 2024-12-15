# Usage: bind this function to a keybinding in your fish configuration
#
# bind \r 'shai_transform /path/to/shai your_openai_api_key'

function shai_transform
    # Get the current command line input
    set cmd (commandline)

    # Return if the command does not start with #
    if not string match -q "#*" $cmd
        commandline -f execute
        return
    end

    # Get the binary path and API key from arguments
    set shai_binary $argv[1]
    set api_key $argv[2]

    # Check if arguments are missing
    if test -z "$shai_binary" -o -z "$api_key"
        echo "Error: Missing arguments."
        commandline -f execute
        return
    end

    # Trim the leading # and whitespace from the command
    set query (string trim (string sub -s 2 $cmd))

    # Execute the shai binary with the query and read the result
    env OPENAI_API_KEY=$api_key $shai_binary $query 2>/dev/null | read result

    # Replace the command line with the result or show error
    if test $status -eq 0
        commandline -r $result
    else
        echo "Error"
        commandline -f execute
    end
end