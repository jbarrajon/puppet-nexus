require 'spec_helper'
describe 'nexus' do
  context 'with default values for all parameters' do
    it { should contain_class('nexus') }
  end
end
