# Secure NixOS with FIDO2 Authentication

This project provides a secure NixOS environment with full disk encryption and FIDO2 authentication, leveraging the power of Nix flakes and Snowfall Lib. It consists of two repositories:

* **`nixos`:**  This repository contains reusable NixOS modules that implement the core security features, including full disk encryption with detached header and key, and FIDO2 authentication for LUKS and PAM.
* **`nixos-example`:** This repository provides an example implementation of how to use the modules to configure a secure NixOS system. It offers various profiles for different use cases (desktop, gaming, developer, productivity, server) and allows users to easily customize their system and home configurations.

## Key Features

* **Robust Security:**  Full disk encryption using LUKS with a detached header and key stored securely on a USB drive.
* **Strong Authentication:**  Leverage YubiKeys for FIDO2 authentication for both LUKS and PAM, ensuring only authorized users can access your system.
* **Versatile Profiles:** Choose from pre-configured profiles optimized for different use cases:
    * **Desktop:** A complete desktop environment with essential applications.
    * **Gaming:** Optimized for gaming performance with necessary drivers and software.
    * **Developer:**  Includes development tools, compilers, and IDEs for various programming languages.
    * **Productivity:** Focuses on office productivity tools and collaboration software.
    * **Server:** A minimal server setup with security hardening.
* **Modular Design:**  The core security features are implemented as reusable NixOS modules in the `nixos` repository.
* **Easy Customization:** The `nixos-example` repository provides a clear structure for users to customize their system and home configurations.
* **Open Source:**  Both repositories are open source and welcome community contributions.

## Supported Profiles

* **Desktop:**  Provides a full-featured desktop environment with popular applications like a web browser, office suite, and multimedia tools.
* **Gaming:**  Includes optimized settings for gaming performance, graphics drivers, and game launchers.
* **Developer:**  Comes with a comprehensive set of development tools, including compilers, debuggers, and IDEs for various programming languages.
* **Productivity:**  Features office productivity applications, collaboration tools, and cloud storage integration.
* **Server:**  Offers a minimal and secure server configuration suitable for web servers, databases, and other server applications.

## Getting Started

1. **Clone the Example Repository:**
    ```bash
    git clone https://github.com/l0newander3r/nixos-example
    ```
2. **Configure Your System:**
    * Navigate to the `systems/<system>` directory in the cloned repository.
    * Copy the `example` folder to your desired hostname (or rename it for goodness sake).
    * Modify the `default.nix` and set your preferences and desired profiles there.
    * Use the modules from the `nixos` repository to configure your desired security settings and profiles. Refer to the module documentation and the example configurations for guidance.
3. **Configure Your Home Environment:**
    * Navigate to the `homes/<systems>` directory in the cloned repository.
    * Copy the `user@example` folder to reflect your desired username and matching hostname.
    * Modify the `default.nix` to configure your home environment, including packages, dotfiles, and other personal settings.
4. **Build and Boot:**
    ```bash
    nixos-rebuild switch --flake .#<profile>
    ```
    (Replace `<profile>` with the desired profile, e.g., `desktop`, `gaming`, etc.)

## Security Considerations

This flake prioritizes security by implementing:

* **Full Disk Encryption:**  All data on your disk is encrypted using LUKS, preventing unauthorized access even if your device is lost or stolen.
* **Detached Header and Key:** The LUKS header and key are stored on a separate USB drive, adding an extra layer of security.
* **FIDO2 Authentication:** YubiKeys are used for strong two-factor authentication for both LUKS and PAM, ensuring only you can unlock your drive and log in.

## Usage Instructions

* **Switching Profiles:**  Use `nixos-rebuild switch --flake .#<profile>` to switch between different profiles.
* **Updating the System:**  Update the flake and rebuild the system with `nixos-rebuild switch --flake .#<profile>`.

## Contributing

Contributions are welcome to both repositories! Feel free to open issues, submit pull requests, or join the discussion.

## License

Both repositories are licensed under the [MIT License](LICENSE).

## Disclaimer

This project is provided "as is" without warranty of any kind. Use it at your own risk. The authors are not responsible for any data loss or security breaches that may occur.