# OBSOLETE CONFIGURATION

After more than 15 years developing this code base, this repository is no more maintained.  
I'm cleaning and rewriting this configuration using the Doom Emacs framework [HERE](https://github.com/pivaldi/pimacs).

## About

Here is not only a clean configuration
of [*Emacs*](http://www.gnu.org/software/emacs/)
but a full working bundle that I use daily for personal and
professional developments ; it can be installed and working in two
minutes.  
If you already have a working *Emacs* configuration, the
install process avoids to overwrite your configuration and you can go back
easily.  
**This bundle only works on a Unix-like system** and is intensively
used in *Debian GNU/Linux Stretch* with *GNU Emacs 25.1.1*.  
However, **this program is distributed in the hope that it will be
useful, but without any warranty ; without even the implied warranty
of merchantability or fitness for a particular purpose.**

## Dependencies

Some *Emacs packages* are not distributed in the bundle because
they are usually provided as system package.

If you're lucky to run on *Debian/Ubuntu GNU/Linux*, you can execute the
following command line as root (sudo for the *Ubuntu* users) in order
to install some useful system packages that will be handle by this
configuration :

```bash
apt-get install \
  git \
  apel \
  aspell \
  aspell-en \
  aspell-fr \
  dictionaries-common \
  global \
  libnotify-bin \
  xosd-bin \
  flim \
  xfonts-terminus \
  xfonts-terminus-dos \
  xfonts-terminus-oblique \
  ttf-ancient-fonts \
  silversearcher-ag
```

If you attempt to code in *Python*, you need to install theses packages :

```bash
apt-get install \
  python3 \
  pymacs \
  python-rope \
  python-ropemacs \
  pylint \
  virtualenv \
  python-pip \
```
