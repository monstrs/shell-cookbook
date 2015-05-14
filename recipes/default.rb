#
# Cookbook Name:: shell
# Recipe:: default
#
# Copyright 2015, Andrey Linko
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'git'
include_recipe 'vim'
include_recipe 'zsh'

package 'mc'

node['shell']['users'].each do |username, config|
  user username do
    shell '/bin/zsh'
    action :modify
  end

  home = ruby_block 'get home' do
    block do
      cmd = Mixlib::ShellOut.new("getent passwd '#{username}' | cut -d: -f6")
      cmd.run_command
      cmd.stdout.gsub("\n", '')
    end
  end.block.call

  git 'oh-my-zsh' do
    destination "#{home}/.oh-my-zsh"
    repository 'https://github.com/robbyrussell/oh-my-zsh.git'
    action :sync
  end

  template 'zshrc config' do
    source 'zshrc.erb'
    path "#{home}/.zshrc"
    owner username
    variables config
    action :create_if_missing
  end

  template 'git config' do
    source 'gitconfig.erb'
    path "#{home}/.gitconfig"
    owner username
    variables config
    action :create_if_missing
  end
end
