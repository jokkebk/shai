# SHAI - Shell AI Assistant

A command-line tool that converts natural language descriptions into Unix commands using OpenAI's GPT models.

## Building

1. Make sure you have Go 1.23.4 or later installed
2. Clone this repository
3. Build the binary:

```sh
go build -o shai
```

## Configuration

1. Get your OpenAI API key from https://platform.openai.com/

2. Configure Fish shell:
   Copy `shai_transform.fish` to `~/.config/fish/functions`

3. Add the following to your Fish config (`~/.config/fish/config.fish`):

   ```sh
   bind \r 'shai_transform /path/to/shai your_openai_api_key'
   ```

## Usage

In Fish shell, start a line with # followed by your command description
Press Enter to transform it into a command
Press Enter again to execute the command
Example:

```sh
# find all png files in current dir
```

Should transform into:

```sh
find . -name "*.png"
```

If the line doesn't start with #, it will be executed normally.

## Requirements

* Go 1.23.4 or later
* Fish shell
* OpenAI API key