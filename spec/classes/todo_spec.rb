require 'spec_helper'

describe 'todo', :type => :class do

  context 'with hiera' do
    let :facts do
      {
        :test => 'todo',
      }
    end

    it { should contain_class('todo') }
  end
end
