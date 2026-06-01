# ============================================================================
#  Dockerfile — "receta" para construir la imagen del curso
# ============================================================================
FROM kalilinux/kali-rolling:latest

# ----------------------------------------------------------------------------
# ENV: variables de entorno permanentes dentro del contenedor
# ----------------------------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=es_ES.UTF-8 \
    LC_ALL=es_ES.UTF-8 \
    TERM=xterm-256color

# ----------------------------------------------------------------------------
# Pre-respuesta a una pregunta interactiva de Wireshark
# ----------------------------------------------------------------------------
RUN echo "wireshark-common wireshark-common/install-setuid boolean false" \
    | debconf-set-selections

# ----------------------------------------------------------------------------
# RUN: ejecutar comandos durante la construcción de la imagen
# ----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    \
    # === Editores de texto y shells ===
    neovim \
    vim \
    bash \
    bash-completion \
    \
    # === Herramientas de 4ta generación ===
    perl \
    make \
    gawk \
    sed \
    grep \
    \
    # === Utilidades básicas de UNIX ===
    coreutils \
    findutils \
    procps \
    less \
    tree \
    jq \
    \
    # === Páginas de manual (comando `man`) ===
    man-db \
    manpages \
    manpages-posix \
    \
    # === Red básica y utilidades de descarga ===
    curl \
    wget \
    git \
    git-lfs \
    ca-certificates \
    locales \
    \
    # === Linter para scripts Bash ===
    shellcheck \
    \
    # === Reconocimiento y escaneo de red ===
    nmap \
    masscan \
    \
    # === Captura y análisis de paquetes de red ===
    tcpdump \
    tshark \
    \
    # === Utilidades de red variadas ===
    netcat-traditional \
    socat \
    dnsutils \
    whois \
    traceroute \
    mtr-tiny \
    iproute2 \
    net-tools \
    iputils-ping \
    \
    # === Anonimato: Tor y similares ===
    tor \
    torsocks \
    proxychains4 \
    obfs4proxy \
    \
    # === Cliente HTTP más legible ===
    httpie \
    \
 && sed -i 's/# es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen \
 && locale-gen \
 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# ----------------------------------------------------------------------------
# SHELL & WORKDIR
# ----------------------------------------------------------------------------
SHELL ["/bin/bash", "-c"]
WORKDIR /workspaces

# Configuración de Git global
RUN git config --system --add safe.directory '*' \
 && git config --system init.defaultBranch main \
 && git config --system pull.rebase false \
 && git lfs install --system

# ----------------------------------------------------------------------------
# Configuración del Prompt personalizado (Daniel Villarreal) en Bash
# ----------------------------------------------------------------------------
# Usamos un único comando RUN con 'cat <<'EOF'' para escribir limpiamente en el .bashrc de root
RUN cat >> /root/.bashrc <<'EOF'

# Configuración del Prompt para Bash
set_prompt() {
    # Guardamos el estado del último comando inmediatamente
    local ESTADO=$?

    # Definición de colores para Bash
    local CIAN="\[\e[36m\]"
    local AMARILLO="\[\e[33m\]"
    local VERDE="\[\e[32m\]"
    local ROJO="\[\e[31m\]"
    local RESET="\[\e[0m\]"

    # Condicional basado en el estado del último comando
    local SIMBOLO
    if [ $ESTADO -eq 0 ]; then
        SIMBOLO="${VERDE}➜"
    else
        SIMBOLO="${ROJO}✗"
    fi

    # Construcción del prompt
    # \W muestra solo el directorio actual
    # \$ muestra # si eres root
    PS1="${CIAN}[Daniel Villarreal]${RESET} ${AMARILLO}\W${RESET} ${SIMBOLO}${RESET} \\$ "
}

# Le indicamos a Bash que ejecute la función antes de cada prompt
PROMPT_COMMAND=set_prompt
EOF

# Aseguramos que la shell por defecto del usuario root sea Bash
RUN chsh -s /usr/bin/bash root

# ----------------------------------------------------------------------------
# CMD: comando que se ejecuta por defecto al arrancar el contenedor
# ----------------------------------------------------------------------------
# Se declara UNA SOLA VEZ al final del archivo
CMD ["/bin/bash"]