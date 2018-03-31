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
used in *Debian GNU/Linux Stretch* with *GNU Emacs 25.1.1*. However :
<span style="color:#AA3333;font-weight:bold">this program is distributed in the hope
that it will be useful, but without any warranty ; without even the
implied warranty of merchantability or fitness for a particular purpose.</span>

## Dependencies

Some *Emacs packages* are not distributed in the bundle because
they are usually provided as system package.

If you're lucky to run on <em>Debian/Ubuntu GNU/Linux, you can execute the
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

## Installation

Now you can grab the bundle and install it with the following
command lines (you can change *emacs.d* with an other name,
it will be the *new* repository where the bundle lives).

```bash
cd
git clone https://github.com/pivaldi/pi-emacs-configuration.git emacs.d
cd emacs.d
git checkout -b mybranch
chmod u+x ./install.sh
./install.sh

```

## Keep up to date

If you want to customize this configuration, but want to be update of my
changes without any conflicts, you can write your own code in two files :

- **user-pre-init.el** which will be loaded before any other configuration ;
- **user-post-init.el** which will be loaded at the end of the configuration.

To retrieve my changes, execute these commands in the directory
where lives the code (*~/emacs.d* the default)

```bash
git commit -a -m 'My configuration changes'
git fetch origin
git merge origin/master
```

If you encounter any problem you can revert to your last configuration
by executing `git reset --hard HEAD`.

## Know issue

My configuration has a minor conflict
with <a href="http://www.emacswiki.org/emacs/Icicles">*icicles*</a>,
if you want absolutely the icicles features let me know.
