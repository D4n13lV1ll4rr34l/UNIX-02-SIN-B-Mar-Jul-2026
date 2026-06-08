# ============================================================================
# COURSE: Introduction to UNIX — SIN-B
# STUDENT: Daniel Villarreal
# ASSIGNMENT: Documenting the Course Dockerfile (Chapters 1-3 Reference)
# ============================================================================

# --- BLOCK a & b: Base Image and Layer Architecture ---
# Citing BHB Ch. 3 (Setting up the lab / Docker concepts): 
# A base image is a read-only template that contains the core OS and pre-installed environments.
# We utilize 'kali-rolling' (continuous update version) because it provides an optimized, 
# cutting-edge environment packed with native security testing utilities.
# Instruction order is critical because Docker builds images utilizing immutable layers. 
# Changing an early instruction invalidates the cache for all subsequent steps, forcing a full rebuild.
FROM kalilinux/kali-rolling:latest

# --- BLOCK c: Environment Variables ---
# Citing BHB Ch. 1 (Environment Variables): Environment variables store global configuration data.
# DEBIAN_FRONTEND=noninteractive: Forces apt-get to assume default answers, preventing build freezes.
# LANG/LC_ALL: Instantiates UTF-8 encoding so special characters like accents or emojis render correctly.
# TERM: Informs CLI tools that the terminal supports 256 colors, enabling syntax highlighting in text editors.
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=es_ES.UTF-8 \
    LC_ALL=es_ES.UTF-8 \
    TERM=xterm-256color

# --- BLOCK d: Pre-configuring Package Prompts ---
# Certain tools like Wireshark/tshark trigger interactive prompts asking if non-root users 
# should be allowed to capture network packets. 
# This command injects a pre-defined answer into the debconf database to keep the build fully automated.
RUN echo "wireshark-common wireshark-common/install-setuid boolean false" | debconf-set-selections

# --- BLOCK e, f, & g: The Big RUN Command (Optimization, Locales, and Cleanup) ---
# Citing BHB Ch. 1 & 2 (Pipes, Redirection, text utilities) and Ch. 3 (Docker structure):
# Why ONE big RUN? Every individual RUN instruction creates a distinct physical layer on disk. 
# Combining commands using '&&' and '\' minimizes layers, drastically reducing the final image footprint.
# 'apt-get update' updates package definitions, and 'install' downloads the binaries.
# '-y' answers yes automatically, and '--no-install-recommends' skips optional software dependencies.
# Tool Categorization & References:
#   - neovim/vim/zsh: Core interactive shell environments and text editors (BHB Ch. 1).
#   - gawk/sed/grep: Powerhouses for regex parsing and text stream filtering (BHB Ch. 2).
#   - coreutils/findutils/procps: Vital Unix system binaries (cat, ls, ps, kill, top) (BHB Ch. 1).
#   - man-db/manpages: Reinstalls system documentation missing from thin base images (BHB Ch. 1).
#   - nmap/masscan/tcpdump/tshark: Utilities for port mapping, packet sniffing, and network analysis.
#   - tor/proxychains4: Anonymization overlays to route connection traffic safely.
#   - jq: CLI query tool engineered specifically for processing structured JSON streams.
RUN apt-get update && apt-get install -y --no-install-recommends \
    neovim \
    vim \
    zsh \
    bash-completion \
    perl \
    make \
    gawk \
    sed \
    grep \
    coreutils \
    findutils \
    procps \
    less \
    tree \
    jq \
    man-db \
    manpages \
    manpages-posix \
    curl \
    wget \
    git \
    git-lfs \
    ca-certificates \
    locales \
    shellcheck \
    nmap \
    masscan \
    tcpdump \
    tshark \
    netcat-traditional \
    socat \
    dnsutils \
    whois \
    traceroute \
    mtr-tiny \
    iproute2 \
    net-tools \
    iputils-ping \
    tor \
    torsocks \
    proxychains4 \
    obfs4proxy \
    httpie \
    && \
    # --- BLOCK f: Locale Configuration ---
    # Citing BHB Ch. 2: 'sed -i' alters the configuration file in-place to uncomment Spanish language support.
    # 'locale-gen' compiles those rules into system locales.
    sed -i 's/# es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen && locale-gen \
    && \
    # --- BLOCK g: Image Layer Cleanup ---
    # Removes local cache databases and temporary installation lists to save space.
    # CRITICAL: This must happen inside the SAME RUN layer, otherwise the deleted data stays hidden in the history layers.
    apt-get clean && rm -rf /var/lib/apt/lists/*

# --- BLOCK h: Default Shell Configuration for Build ---
# Citing BHB Ch. 1 (The Shell): By default, Docker executes RUN tasks inside '/bin/sh'.
# Changing the default execution SHELL to ['/bin/bash', '-c'] unlocks robust Bash capabilities for script tasks.
SHELL ["/bin/bash", "-c"]

# --- BLOCK i: Working Directory ---
# Defines the active execution directory inside the container context where operations take place.
# Codespaces maps repository folders straight into subfolders of '/workspaces'.
WORKDIR /workspaces

# --- BLOCK j: System-Wide Git and LFS Settings ---
# Implements global system configurations for Git control behavior.
# Marks all workspace directories as safe to prevent file-ownership UID warnings inside Docker.
# Initializes Large File Storage ('git lfs install') globally across the workspace environment.
RUN git config --system --add safe.directory '*' \
 && git config --system init.defaultBranch main \
 && git config --system pull.rebase false \
 && git lfs install --system

# --- BLOCK k: Changing the Default User Shell ---
# Executes 'chsh' to alter the default system environment login database, 
# permanently migrating the root user's execution terminal environment from Bash to Zsh.
RUN chsh -s /usr/bin/zsh root

# --- BLOCK l: Here-Document Shell Customization ---
# Citing BHB Ch. 1 (Here-Documents '<<'):
# The '<<' operator pipes multi-line blocks of text into standard input (stdin) without spawning external files.
# '>>' appends this block straight into the user's '.zshrc' configuration profile.
# The PROMPT variable establishes colors, system user variables, and formatting for the active CLI theme.
RUN cat >> /root/.zshrc <<'EOF'
set_prompt_status() {
    echo "%(?..%F{red}✗ %?%f)"
}
PROMPT='%F{cyan}[Daniel-Villarreal]%f %F{yellow}%1~%f %F{green}%(?.✓.)%f$(set_prompt_status) %# '
EOF

# --- BLOCK m: Container Startup Command ---
# 'RUN' processes instructions to compile the image during development builds.
# 'CMD' establishes the ultimate runtime application that fires up automatically when the container boots.
# This ensures a clean, interactive Zsh environment welcomes the user on initialization.
CMD ["/usr/bin/zsh"]