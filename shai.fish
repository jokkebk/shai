# Usage: bind this function to a keybinding in your fish configuration
#
# bind \r shai_transform /path/to/shai your_openai_api_key

function shai_transform
    # Accept binary location and API key as arguments
    set shai_binary $argv[1]
    set openai_api_key $argv[2]

    if test -z "$shai_binary" -o -z "$openai_api_key"
        echo "Error: SHAI_BINARY or OPENAI_API_KEY is missing."
        return 1
    end

    # Fetch the current command line
    set cmd (commandline)

    # Check if the line starts with a hash
    if string match -q "#*" $cmd
        # Remove the '#' and possible leading space
        set query (string trim (string sub -s 2 $cmd))

        # Run the shai command with the temporary environment variable
        set result (env OPENAI_API_KEY=$openai_api_key $shai_binary $query)

        # Replace the current command line with the output of shai
        commandline -r $result
    else
        # Execute normally
        commandline -f execute
    end
end