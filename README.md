# SHAI - Shell AI Assistant

A command-line tool that converts natural language descriptions into Unix commands using OpenAI's GPT models.

## Pre-requisites and building

1. Get your OpenAI API key from https://platform.openai.com/
2. Make sure you have Go 1.23.4 or later installed
3. Clone this repository
4. Build the binary:

```sh
go build -o shai
```

## Fish shell

1. Configure Fish shell:
   Copy or symlink `shai_transform.fish` to `~/.config/fish/functions`

2. Add the following to your Fish config (`~/.config/fish/config.fish`):

   ```sh
   bind \r 'shai_transform /path/to/shai your_openai_api_key'
   ```

Once you restart fish (or `exec fish`), you can just type a "commented out" command:

```sh
$ # find all png files in current dir
```

Pressing `enter` should transform this into:

```sh
$ find . -name "*.png"
```

You can review and edit the command before pressing `enter` again to actually run it. If the line doesn't start with #, it will be executed normally.

## Bash and zsh

Separate `shai_transform.bash` and `shai_transform.zsh` scripts are provided for
`bash` and `zsh` shells, they include instructions how to set up `.bashrc` or
`.zshrc`. As binding `enter` is quite hard, these rely instead on keybinding
(`ctrl-q` in the examples) than comment-style conversion:

```sh
$ find all png files in current dir
```

Pressing `ctrl-q` should transform this into:

```sh
$ find . -name "*.png"
```

*Note*: Bash 4.0 or newer is required due to `bind -x` and readline support.