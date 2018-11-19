# dotfiles

Nothing special. Just my bash and zsh profiles. 

## Zsh 

I initially followed [this awesome guide](https://medium.com/@Clovis_app/configuration-of-a-beautiful-efficient-terminal-and-prompt-on-osx-in-7-minutes-827c29391961) to make my terminal look amazing.

Although that was a very good starting point, the following steps are what worked for me and what makes my Zsh look just the way I want it, using the .zshrc in this repo.

This assumes you have [Homebrew](https://brew.sh/) installed.

### Step 1: Install `zsh` using Homebrew.
```
$ brew install zsh
```

### Step 2: Install Oh My Zsh
[Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) is an open source framework that manages your `zsh` configuration. There are other frameworks out there and they should be exclusively installed In other words, you should use either one or the other, not two or more at the same time.

```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

The script should automatically set `zsh` as your default shell. However, if it fails to do so, you can do it manually:

```
$ chsh -s $(which zsh)
```

### Step 3: Install a cool font
There are many fonts you can use with iTerm, but the most popular seems to be Source Code Pro. Because I am using a cool theme for my zsh installation, I will go with one that has all the bells and whistles: Source Code Pro + Powerline + Awesome. This font has been carefully engineered to adequately satisfy my needs, and only because my zsh theme is not heavy with too many colors.

You can find the font [here](https://github.com/Falkor/dotfiles/tree/master/fonts). Download it and install it using Font Book.

In terminal/iTerm, set this as your default font. In iTerm, be sure to uncheck the 'Use a different font for non-ASCII text' checkbox. However, if you want a special symbol font for non-ASCII text, you can surely do that. Just be sure to change your powerlevel9k settings to reflect the codes of your symbol font (on macOS, use Font Book with command-2 to see all the characters in the font and hover over your desired symbol to get its code).

### Step 4: Install Powerlevel9k theme

This is the theme I use for my zsh. You should read more about it [here](https://github.com/bhilburn/powerlevel9k), where you will also find detailed installation instructions.

My installation is on macOS and if you have the same, using Homebrew, of course:

```
$ brew tap sambadevi/powerlevel9k
$ brew install powerlevel9k
```

And then install the theme for use in Oh My Zsh:

```
$ git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

Now you can experiment with my `.zshrc` file to configure your terminal the way you want it!

