# Função para obter o caminho real de um arquivo, resolvendo symlinks
origin() {
    [[ -e "$1" ]] || return 1      # verifica se o arquivo existe
    readlink -f "$1"                # -f resolve todos os symlinks e retorna o caminho absoluto
}

# Função para obter o script Zsh atual resolvendo symlinks
current() {
    local script="${(%):-%x}"       # caminho do script atual
    origin "$script"
}
