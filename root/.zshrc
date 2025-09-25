current() {
    CURRENT_ZSH_FILE="${(%):-%x}"
    echo "$(realpath $CURRENT_ZSH_FILE)"
}

export BACKUP_PATH="/backup"
export DOTENV_PATH=$BACKUP_PATH/dotenv
export DOTENV_ZSH_PATH=$DOTENV_PATH/zsh

export HISTFILE=$DOTENV_ZSH_PATH/private/zsh_history

source $DOTENV_ZSH_PATH/custom/functions/prelude/source.zsh

source_batch $DOTENV_ZSH_PATH/custom/functions/prelude
source_batch $DOTENV_ZSH_PATH/custom/functions/shorts

plugins=(git rust ssh-agent)

export ZSH="$DOTENV_ZSH_PATH/ohmyzsh"
export ZSH_THEME="dallas"
export ZSH_CUSTOM="$DOTENV_ZSH_PATH/custom"

zstyle :omz:plugins:ssh-agent identities ~/back/dotenv/.ssh/{git_github}

source $ZSH/oh-my-zsh.sh
