function addCert() {
    read -e -p "Please enter a nickname for this certificate: "
    nickname="$REPLY"

    read -e -p "Please enter the path to the certicate: "
    certPathFull="$REPLY"
    certPath="$(echo -e "${certPathFull}" | tr -d '[[:space:]]')"

    #certutil -d sql:$HOME/.pki/nssdb -A -t P -n "$nickname" -i "$certPath"
    echo -e "\nRunning: \033[36mcertutil -d sql:$HOME/.pki/nssdb -A -t P -n \"$nickname\" -i \"$certPath\"\033[0m\n"

    if (( $? == 0 ));
    then
        echo -e "\033[32mSuccess! Restart Chrome to complete the import.\033[0m"
    else
        echo -e "\033[31mOh testicle teeth! Something went wrong and I don't know what it is so I'm outta here and you're on your own, Pal!\033[0m"
    fi
}

