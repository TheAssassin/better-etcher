Codename better-etcher
======

> Flash OS images to SD cards & USB drives, safely and easily.

Codename better-etcher is a fork of Etcher, a powerful OS image flasher built with web technologies to ensure flashing an SDCard or USB drive is a pleasant and safe experience. It protects you from accidentally writing to your hard-drives, ensures every byte of data was written correctly and much more.

We created this forked to address an anti-feature where data was sent from the app back to the developers, unless the user went into the settings and unticked a box. Although we understand that the developers find the data they get that way useful for improving the app, we believe that any code that sends data from a user's computer back to developers ought to be turned off by default, with the user explicity asked for permission to turn it on. The Etcher developers whave made it clear they do not wish to do this, so we used the freedoms protected by their choice of the Apache 2.0 license to do it ourselves.

[Current Release](https://github.com/TheAssassin/better-etcher/releases)

Supported Operating Systems
---------------------------

- Linux (most distros)
- macOS 10.9 and later
- Microsoft Windows 7 and later

Note that Codename better-etcher will run on any platform officially supported by
[Electron][electron]. Read more in their
[documentation][electron-supported-platforms].

Installers
----------

Refer to the [downloads page](https://github.com/TheAssassin/better-etcher/releases) for the latest pre-made
installers for all supported operating systems.

Support
-------

If you're having any problem, please [raise an issue][newissue] on GitHub and
the resin.io team will be happy to help.

License
-------

Codename Better-etcher is free software, and may be redistributed under the terms specified in
the [license].

[electron]: http://electron.atom.io
[electron-supported-platforms]: http://electron.atom.io/docs/tutorial/supported-platforms/
[SUPPORT]: https://github.com/TheAssassin/better-etcher/blob/master/SUPPORT.md
[CONTRIBUTING]: https://github.com/TheAssassin/better-etcher/blob/master/docs/CONTRIBUTING.md
[CLI]: https://github.com/TheAssassin/better-etcher/blob/master/docs/CLI.md
[USER-DOCUMENTATION]: https://github.com/TheAssassin/better-etcher/blob/master/docs/USER-DOCUMENTATION.md
[milestones]: https://github.com/TheAssassin/better-etcher/milestones
[newissue]: https://github.com/TheAssassin/better-etcher/issues/new
[license]: https://github.com/TheAssassin/better-etcher/blob/master/LICENSE
