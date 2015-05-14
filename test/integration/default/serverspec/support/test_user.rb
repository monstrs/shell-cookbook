#
# Custom test_user matcher
#
module Serverspec
  module Type
    class TestUser < User
      require 'json'

      def initialize
        file = ::File.read('/tmp/kitchen/dna.json')
        json = ::JSON.parse(file)
        users = json['shell']['users']
        super(users.keys.first)
      end

      def test_user?
        !!@name
      end
    end
  end
end

define_method 'test_user' do
  eval 'Serverspec::Type::TestUser.new'
end
