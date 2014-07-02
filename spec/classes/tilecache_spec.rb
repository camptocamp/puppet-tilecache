require 'spec_helper'
describe 'tilecache' do
  let (:pre_condition) {
    "Exec { path => '/foo' }"
  }

  context 'when on Debian lenny' do
    let (:facts) { {
      :operatingsystem => 'Debian',
      :osfamily        => 'Debian',
      :lsbdistcodename => 'lenny',
      :selinux         => false,
    } }

    it { should compile.with_all_deps }
  end
end
