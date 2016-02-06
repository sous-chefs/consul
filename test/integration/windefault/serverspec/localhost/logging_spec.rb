require 'spec_helper'

context 'logging' do
  describe file('C:\foo\bar\out.log') do
    it { should be_file }
  end

  describe file('C:\foo\bar\err.log') do
    it { should be_file }
  end
end