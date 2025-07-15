# Скрипт Автоматизованої Пост-Установки Arch Linux з KDE Plasma (для Archboot) ✨

Цей скрипт призначений для автоматизованого встановлення та базового налаштування робочого середовища KDE Plasma на щойно встановлену базову систему Arch Linux, використовуючи образ `archboot`. Він встановлює необхідні системні утиліти, шрифти, мультимедійні кодеки, мережеві інструменти та інші компоненти, а також налаштовує деякі базові системні служби.

## **Особливості** ✨

*   **Перевірка прав Root**: Скрипт перевіряє, чи запускається він з правами суперкористувача (root).
*   **Оновлення Системи**: Перед встановленням оновлює базу даних пакетів `pacman` та встановлені пакети.
*   **Автоматичне Встановлення `yay`**: Якщо `yay` (AUR-хелпер) не знайдено, скрипт автоматично завантажує та компілює його.
*   **Встановлення Пакетів**: Встановлює широкий спектр пакетів як з офіційних репозиторіїв Arch Linux (за допомогою `pacman`), так і з Arch User Repository (AUR, за допомогою `yay`).
*   **Налаштування Локалі**: Дозволяє користувачеві вказати код локалі для встановлення відповідних мовних пакетів Firefox та Aspell.
*   **Автоматичні Налаштування Системних Служб**: Після встановлення пакетів скрипт вмикає та запускає ключові системні служби, такі як SDDM (дисплейний менеджер), NetworkManager, systemd-timesyncd (синхронізація часу), PipeWire (аудіо) та CUPS (друк).

## **Вимоги** 📋

*   Вже встановлена базова система Arch Linux за допомогою образу `archboot`.
*   Активне інтернет-з'єднання.
*   Запуск скрипта з правами `root` (використовуйте `sudo`).

## **Використання** 🚀

1.  **Завантажте скрипт**: Клонуйте репозиторій або завантажте файл `install.sh`.
    ```bash
    git clone https://github.com/ваш_користувач/arch-install-script.git
    cd arch-install-script
    ```
    _Замініть `ваш_користувач` та `arch-install-script` на відповідні дані вашого репозиторію._

2.  **Запустіть скрипт**: Виконайте скрипт з правами `root`.
    ```bash
    sudo bash install.sh
    ```

3.  **Введіть код локалі**: Під час виконання скрипт запитає у вас код локалі (наприклад, `uk_UA` або `en_US`). Це необхідно для встановлення мовних пакетів Firefox та Aspell.

4.  **Дочекайтеся завершення**: Скрипт автоматично встановить всі необхідні пакети та виконає базові налаштування.

## **Попередження** ⚠️

*   **`--noconfirm`**: Скрипт використовує опцію `--noconfirm` для `pacman` та `yay`, що означає, що він не буде запитувати підтвердження перед встановленням пакетів. Переконайтеся, що ви ознайомлені зі списком пакетів, які будуть встановлені.
*   **Права `root`**: Скрипт виконує критичні системні зміни. Завжди будьте обережні при запуску будь-яких скриптів з правами `root`.
*   **Підключення до Інтернету**: Переконайтеся, що у вас стабільне інтернет-з'єднання протягом всього процесу, оскільки скрипт завантажує багато пакетів.
*   **Перезавантаження**: Після успішного завершення роботи скрипта рекомендується перезавантажити систему, щоб всі зміни набули чинності.

## **Встановлювані Пакети** 📦

### **Офіційні Репозиторії (pacman)**

Цей скрипт встановлює наступні пакети з офіційних репозиторіїв Arch Linux:

*   **Мережа**: `modemmanager`, `networkmanager`, `networkmanager-openconnect`, `networkmanager-openvpn`, `nss-mdns`, `openssh`, `usb_modeswitch`, `wpa_supplicant`, `xl2tpd`
*   **Системні Утиліти**: `pacman-contrib`, `pkgfile`, `rebuild-detector`, `reflector`, `libwnck3`, `mlocate`, `poppler-glib`, `xdg-user-dirs`, `xdg-utils`, `efitools`, `haveged`, `nfs-utils`, `nilfs-utils`, `ntp`, `smartmontools`, `unrar`, `unzip`, `xz`, `rtkit`, `dmidecode`, `dmraid`, `hdparm`, `lsscsi`, `mtools`, `sg3_utils`, `sof-firmware`, `power-profiles-daemon`, `upower`, `duf`, `git`, `glances`, `hwinfo`, `meld`, `pv`, `python-defusedxml`, `python-packaging`, `rsync`, `sed`, `wget`
*   **Графіка та Драйвери**: `mesa-utils`, `xf86-input-libinput`, `xorg-xdpyinfo`, `xorg-server`, `xorg-xinit`, `xorg-xinput`, `xorg-xlsclients`, `xorg-xrandr`, `xf86-video-amdgpu`, `xf86-video-ati`
*   **Шрифти**: `cantarell-fonts`, `freetype2`, `noto-fonts`, `noto-fonts-emoji`, `noto-fonts-cjk`, `noto-fonts-extra`, `ttf-bitstream-vera`, `ttf-dejavu`, `ttf-liberation`, `ttf-opensans`
*   **Аудіо**: `alsa-firmware`, `alsa-plugins`, `alsa-utils`, `pavucontrol`, `pipewire-pulse`, `wireplumber`
*   **Друк**: `cups`, `cups-browsed`, `cups-filters`, `cups-pdf`, `foomatic-db`, `foomatic-db-engine`, `foomatic-db-gutenprint-ppds`, `foomatic-db-nonfree`, `foomatic-db-nonfree-ppds`, `ghostscript`, `gsfonts`, `gutenprint`, `splix`, `system-config-printer`, `hplip`, `python-pillow`, `python-pyqt5`, `python-reportlab`, `sane`
*   **KDE Plasma**: `plasma-framework5`, `ark`, `bluedevil`, `breeze-gtk`, `dolphin`, `dolphin-plugins`, `fwupd`, `haruna`, `kate`, `kcalc`, `kde-cli-tools`, `kde-gtk-config`, `kdeconnect`, `kdegraphics-thumbnailers`, `kdeplasma-addons`, `kio-admin`, `kio-extras`, `kio-fuse`, `konsole`, `kscreen`, `kwallet-pam`, `kwayland-integration`, `libappindicator-gtk3`, `maliit-keyboard`, `okular`, `plasma-browser-integration`, `plasma-desktop`, `plasma-disks`, `plasma-firewall`, `plasma-nm`, `plasma-pa`, `plasma-systemmonitor`, `plasma-workspace`, `plasma-x11-session`, `powerdevil`, `print-manager`, `qt5-imageformats`, `sddm-kcm`, `spectacle`, `xdg-desktop-portal-kde`, `xsettingsd`, `sddm`
*   **Мікрокод**: `amd-ucode`, `intel-ucode`
*   **Браузери**: `firefox`, `firefox-i18n-(код_локалі)`
*   **Перевірка Орфографії**: `aspell`, `aspell-(код_локалі)`

### **Arch User Repository (AUR)**

Цей скрипт встановлює наступні пакети з AUR (через `yay`):

*   `libdvdcss` (Бібліотека для декодування DVD)
*   `lxmxi` (Системна інформація)
*   `downgrade` (Для відкату пакетів)
*   `pamac-aur` (Графічний менеджер пакетів з підтримкою AUR)
*   `archlinux-themes-sddm` (Теми Arch Linux для SDDM)

## **Внесок** 🤝

Будь-які внески вітаються! Якщо у вас є пропозиції щодо покращення, ви можете відкрити issue або pull request.

## **Ліцензія** 📄

Цей проект ліцензовано за ліцензією MIT. Дивіться файл `LICENSE` для більш детальної інформації. 