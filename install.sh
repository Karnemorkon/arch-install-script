#!/bin/bash

# Цей скрипт автоматизує пост-установку Arch Linux, встановленого за допомогою Archboot,
# з робочим середовищем KDE Plasma та іншими необхідними компонентами.
# Він призначений для використання після базового налаштування системи.

# Перевірка, чи скрипт запущено з правами root.
# Цей скрипт повинен бути запущений з sudo.
if [ "$(id -u)" -ne 0 ]; then
  echo "Цей скрипт потрібно запускати з правами root. Будь ласка, використайте 'sudo bash $(basename "$0")'."
  exit 1
fi

# Оновлення бази даних пакетів pacman для отримання найновішої інформації.
echo "Оновлення бази даних пакетів pacman та оновлення встановлених пакетів... 😉"
pacman -Syu --noconfirm

# Перевірка наявності 'yay' - менеджера пакетів AUR.
# Якщо 'yay' не знайдено, ми його встановимо з AUR.
if ! command -v yay &> /dev/null
then
    echo "Менеджер пакетів 'yay' не знайдено. Встановлення 'yay' з AUR... ⏳"
    echo "Вам може знадобитися ввести пароль користувача для встановлення 'yay' через 'makepkg -si'."

    # Встановлення необхідних залежностей для збірки пакетів з AUR.
    pacman -S --noconfirm git base-devel

    # Клонування репозиторію 'yay' до тимчасової директорії.
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    # Зміна власника тимчасової директорії, щоб звичайний користувач міг збирати пакет.
    chown -R $(logname):$(logname) /tmp/yay
    # Перехід до директорії 'yay'.
    pushd /tmp/yay > /dev/null
    # Збірка та встановлення 'yay' під користувачем, який запустив sudo.
    sudo -u $(logname) makepkg -si --noconfirm
    # Повернення до початкової директорії.
    popd > /dev/null
    # Видалення тимчасової директорії 'yay'.
    rm -rf /tmp/yay
    echo "'yay' успішно встановлено! ✨"
else
    echo "Менеджер пакетів 'yay' вже встановлено. ✅"
fi

# Запит коду локалі у користувача для встановлення мовних пакетів.
echo "Будь ласка, введіть ваш код локалі (наприклад, uk_UA, en_US). Це потрібно для встановлення мовних пакетів Firefox та Aspell:"
read LOCALE_CODE

# Список пакетів з офіційних репозиторіїв Arch Linux (pacman).
# Ці пакети будуть встановлені за допомогою pacman.
PACMAN_PACKAGES=(
    modemmanager
    networkmanager
    networkmanager-openconnect
    networkmanager-openvpn
    nss-mdns
    openssh
    usb_modeswitch
    wpa_supplicant
    xl2tpd
    pacman-contrib
    pkgfile
    rebuild-detector
    reflector
    libwnck3
    mesa-utils
    xf86-input-libinput
    xorg-xdpyinfo
    xorg-server
    xorg-xinit
    xorg-xinput
    xorg-xlsclients
    xorg-xrandr
    xf86-video-amdgpu
    xf86-video-ati
    plasma-framework5
    ffmpegthumbnailer
    gst-libav
    gst-plugin-pipewire
    gst-plugins-bad
    gst-plugins-ugly
    libopenraw
    mlocate
    poppler-glib
    xdg-user-dirs
    xdg-utils
    efitools
    haveged
    nfs-utils
    nilfs-utils
    ntp
    smartmontools
    unrar
    unzip
    xz
    rtkit
    dmidecode
    dmraid
    hdparm
    lsscsi
    mtools
    sg3_utils
    sof-firmware
    power-profiles-daemon
    upower
    amd-ucode
    intel-ucode
    duf
    git
    glances
    hwinfo
    meld
    pv
    python-defusedxml
    python-packaging
    rsync
    sed
    wget
    firefox
    aspell
    "firefox-i18n-${LOCALE_CODE%%_*}" # Використання тільки мовного коду (наприклад, uk) для Firefox i18n.
    "aspell-${LOCALE_CODE%%_*}"       # Використання тільки мовного коду (наприклад, uk) для Aspell.
    cantarell-fonts
    freetype2
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    noto-fonts-extra
    ttf-bitstream-vera
    ttf-dejavu
    ttf-liberation
    ttf-opensans
    alsa-firmware
    alsa-plugins
    alsa-utils
    pavucontrol
    pipewire-pulse
    wireplumber
    cups
    cups-browsed
    cups-filters
    cups-pdf
    foomatic-db
    foomatic-db-engine
    foomatic-db-gutenprint-ppds
    foomatic-db-nonfree
    foomatic-db-nonfree-ppds
    ghostscript
    gsfonts
    gutenprint
    splix
    system-config-printer
    hplip
    python-pillow
    python-pyqt5
    python-reportlab
    sane
    ark
    bluedevil
    breeze-gtk
    dolphin
    dolphin-plugins
    fwupd
    haruna
    kate
    kcalc
    kde-cli-tools
    kde-gtk-config
    kdeconnect
    kdegraphics-thumbnailers
    kdeplasma-addons
    kio-admin
    kio-extras
    kio-fuse
    konsole
    kscreen
    kwallet-pam
    kwayland-integration
    libappindicator-gtk3
    maliit-keyboard
    okular
    plasma-browser-integration
    plasma-desktop
    plasma-disks
    plasma-firewall
    plasma-nm
    plasma-pa
    plasma-systemmonitor
    plasma-workspace
    plasma-x11-session
    powerdevil
    print-manager
    qt5-imageformats
    sddm-kcm
    spectacle
    xdg-desktop-portal-kde
    xsettingsd
    sddm # Дисплейний менеджер для KDE Plasma.
)

# Список пакетів з AUR (Arch User Repository), які будуть встановлені за допомогою yay.
AUR_PACKAGES=(
    libdvdcss # Бібліотека для декодування DVD.
    lxmxi     # Системна інформація.
    downgrade # Для відкату пакетів.
    pamac-aur # Графічний менеджер пакетів з підтримкою AUR.
    archlinux-themes-sddm # Теми Arch Linux для SDDM.
)

echo "Розпочинаємо встановлення пакетів з офіційних репозиторіїв Arch Linux... 🚀"
pacman -S --noconfirm "${PACMAN_PACKAGES[@]}"

# Перевірка статусу виходу останньої команди. Якщо не 0, значить була помилка.
if [ $? -ne 0 ]; then
    echo "Помилка при встановленні пакетів pacman. Будь ласка, перевірте вивід вище для деталей. ❌"
    exit 1
fi

echo "Розпочинаємо встановлення пакетів з AUR за допомогою yay... 📦"
# Запуск yay від імені звичайного користувача, а не root.
sudo -u $(logname) yay -S --noconfirm "${AUR_PACKAGES[@]}"

if [ $? -ne 0 ]; then
    echo "Помилка при встановленні пакетів AUR. Будь ласка, перевірте вивід вище для деталей. ❌"
    exit 1
fi

echo "Всі вибрані пакети встановлено успішно! 🎉"

# Додаткові налаштування після встановлення KDE Plasma та інших компонентів.
echo "Виконання післяінсталяційних налаштувань... 🛠️"

# Увімкнення та запуск sddm як менеджера дисплея.
echo "Налаштування sddm як менеджера дисплея... 🖥️"
systemctl enable sddm
systemctl start sddm

# Увімкнення та запуск NetworkManager для керування мережевими з'єднаннями.
echo "Активація NetworkManager... 🌐"
systemctl enable NetworkManager
systemctl start NetworkManager

# Увімкнення та запуск systemd-timesyncd для синхронізації часу за NTP.
echo "Активація ntp (systemd-timesyncd) для синхронізації часу... ⏰"
systemctl enable systemd-timesyncd
systemctl start systemd-timesyncd

# Налаштування PipeWire для звуку.
echo "Налаштування PipeWire... 🔊"
sudo -u $(logname) systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service
sudo -u $(logname) systemctl --user start pipewire.socket pipewire-pulse.socket wireplumber.service

# Увімкнення та запуск CUPS як менеджера друку.
echo "Налаштування CUPS (служби друку)... 🖨️"
systemctl enable cups.service
systemctl start cups.service

# Увімкнення та запуск служби Bluetooth.
echo "Налаштування служби Bluetooth... 📶"
systemctl enable bluetooth.service
systemctl start bluetooth.service

# Налаштування теми SDDM.
echo "Налаштування теми SDDM Arch Linux... 🎨"
echo -e "[Theme]\nCurrent=archlinux" | sudo tee /etc/sddm.conf.d/10-theme.conf > /dev/null

# Оновлення бази даних mlocate для швидкого пошуку файлів.
echo "Налаштування mlocate (оновлення бази даних)... 🔍"
updatedb

echo "Встановлення та налаштування завершено успішно! ✨"
echo "Рекомендовано перезавантажити систему або вийти з системи та увійти в KDE Plasma для застосування всіх змін." 