---
title: Managing Passwords
layout: default
---
# Managing your passwords

{: .note }
By default, KDE comes with a service called KDE Wallet. This is not a password manager in the traditional sense, but instead it holds what are considered to be user secrets. Stuff like your network password, email password, GPG keys, etc. It can be used as a password manager as well, but is probably not the best solution. Disabling it is not recommended, as KDE expects a secret manager (KDE Wallet or another one) to be present. You may disable it, and instead store all credentials in plaintext, but this is obviously not recommended.

{: .note }
Using the built in password manager that your browser supplies is not recommended. They are often not up to snuff with encryption, or don't disclose their encryption model, and often can only be accessed using that browser.

Only two password managers are recommended.
- Bitwarden
- KeePassXC