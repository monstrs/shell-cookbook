name             'shell'
maintainer			 'Andrey Linko'
maintainer_email 'AndreyLinko@gmail.com'
license				   'Apache 2.0'
description			 'Install default shell configuration for selected users'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version				   '0.0.1'
recipe				   'shell::default', 'Installs default shell configuration for selected users'

depends 'git'
depends 'vim'
depends 'zsh'

supports 'ubuntu'
