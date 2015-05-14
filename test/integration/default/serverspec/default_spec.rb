require_relative 'spec_helper'

describe test_user do
  it { should exist }
  it { should have_login_shell '/bin/zsh' }
end
