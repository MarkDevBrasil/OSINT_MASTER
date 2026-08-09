#!/bin/bash

# ==============================
#        OSINT MASTER (By mark)
# ==============================

log() {
    echo "[+] $1"
}

pause() {
    read -p "Pressione enter para continuar..."
}

requisitos() {
    clear
    echo "===== INSTALANDO REQUISITOS ====="
    echo

    sudo apt update

    sudo apt install -y \
        python3 python3-pip git curl jq \
        theharvester subfinder amass assetfinder \
        dnsrecon dnsenum dnsutils whois \
        recon-ng spiderfoot sn0int osrframework \
        sherlock photon metagoofil \
        libimage-exiftool-perl \
        gowitness eyewitness seclists

    echo
    log "Instalando ferramentas python..."

    pip3 install --break-system-packages --upgrade \
        maigret holehe shodan h8mail 2>/dev/null

    if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
        sudo gunzip -f /usr/share/wordlists/rockyou.txt.gz
    fi

    echo
    log "Requisitos instalados"
    pause
    menu
}

dominios() {
    clear
    echo "===== DOMÍNIOS E INFRAESTRUTURA ====="
    echo
    echo "[1] theHarvester"
    echo "[2] subfinder"
    echo "[3] amass"
    echo "[4] assetfinder"
    echo "[5] dnsrecon"
    echo "[6] dnsenum"
    echo "[7] dig / whois"
    echo "[0] Voltar"
    echo

    read -p "OSINT Master > " opcao

    case $opcao in
        1) theHarvester --help ;;
        2) subfinder -h ;;
        3) amass -h ;;
        4) assetfinder -h ;;
        5) dnsrecon -h ;;
        6) dnsenum --help ;;
        7)
            echo
            echo "dig example.com"
            echo "dig AXFR example.com @ns1.example.com"
            echo "whois example.com"
            ;;
        0) menu; return ;;
        *) echo "Opção invalida" ;;
    esac

    pause
    dominios
}

pessoas() {
    clear
    echo "===== WEB OSINT ====="
    echo
    echo "[1] Sherlock"
    echo "[2] Maigret"
    echo "[3] Holehe"
    echo "[4] OSRFramework"
    echo "[5] Photon"
    echo "[0] Voltar"
    echo

    read -p "OSINT Master > " opcao

    case $opcao in
        1) sherlock --help ;;
        2) maigret --help ;;
        3) holehe --help ;;
        4) osrf --help ;;
        5) photon --help ;;
        0) menu; return ;;
        *) echo "Opção invalida" ;;
    esac

    pause
    pessoas
}

frameworks() {
    clear
    echo "===== FRAMEWORK OSINT ====="
    echo
    echo "[1] Recon-ng"
    echo "[2] SpiderFoot"
    echo "[3] Sn0int"
    echo "[0] Voltar"
    echo

    read -p "OSINT Master > " opcao

    case $opcao in
        1) recon-ng ;;
        2) spiderfoot -l 127.0.0.1:5001 ;;
        3) sn0int ;;
        0) menu; return ;;
        *) echo "Opção invalida" ;;
    esac

    pause
    frameworks
}

metadados() {
    clear
    echo "===== METADADOS OSINT  ====="
    echo
    echo "[1] Metagoofil"
    echo "[2] ExifTool"
    echo "[0] Voltar"
    echo

    read -p "OSINT Master > " opcao

    case $opcao in
        1) metagoofil --help ;;
        2) exiftool -h ;;
        0) menu; return ;;
        *) echo "Opção inválida!" ;;
    esac

    pause
    metadados
}

screenshots() {
    clear
    echo "===== SCREENSHOTS / TRIAGEM WEB ====="
    echo
    echo "[1] Gowitness"
    echo "[2] EyeWitness"
    echo "[0] Voltar"
    echo

    read -p "OSINT Master > " opcao

    case $opcao in
        1) gowitness --help ;;
        2) eyewitness --help ;;
        0) menu; return ;;
        *) echo "Opção invalida" ;;
    esac

    pause
    screenshots
}

apis() {
    clear
    echo "===== APIs ====="
    echo
    echo "[1] Shodan"
    echo "[0] Voltar"
    echo

    read -p "OSINT Master > " opcao

    case $opcao in
        1)
            echo
            echo "Shodan requer api key"
            echo
            echo "Configure com:"
            echo "shodan init API_KEY"
            echo
            shodan --help
            ;;
        0)
            menu
            return
            ;;
        *)
            echo "Opção invalida"
            ;;
    esac

    pause
    apis
}

menu() {
    clear

    local width=$(tput cols)
    local box_width=45
    local left_padding=$(( (width - box_width) / 2 ))

    printf "\n\n"

    printf "%*s              OSINT MASTER                \n" "$left_padding" ""
    printf "%*s [1] Instalar requisitos                  \n" "$left_padding" ""
    printf "%*s [2] Domínios e infraestrutura            \n" "$left_padding" ""
    printf "%*s [3] Pessoas, emails e redes sociais      \n" "$left_padding" ""
    printf "%*s [4] Frameworks OSINT                     \n" "$left_padding" ""
    printf "%*s [5] Metadados e documentos               \n" "$left_padding" ""
    printf "%*s [6] Screenshots / triagem web            \n" "$left_padding" ""
    printf "%*s [7] APIs                                 \n" "$left_padding" ""
    printf "%*s [0] Sair                                 \n" "$left_padding" ""

    printf "\n"
    printf "%*sOSINT Master > " "$left_padding" ""

    read opcao

    case $opcao in
        1) requisitos ;;
        2) dominios ;;
        3) pessoas ;;
        4) frameworks ;;
        5) metadados ;;
        6) screenshots ;;
        7) apis ;;
        0)
            clear
            echo "Até a proxima"
            exit 0
            ;;
        *)
            echo "Opção invalida"
            sleep 1
            menu
            ;;
    esac
}

menu
