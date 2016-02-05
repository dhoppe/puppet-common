require 'spec_helper_acceptance'

case fact('osfamily')
when 'Debian'
  config_file_path = '/etc/group'
end

describe 'common', :if => SUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'is_expected.to work with no errors' do
    pp = <<-EOS
      class { 'common': }
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end

  describe 'common::install' do
    # context 'defaults' do
    #   it 'is_expected.to work with no errors' do
    #     pp = <<-EOS
    #       class { 'common': }
    #     EOS

    #     apply_manifest(pp, :catch_failures => true)
    #   end

    #   describe package(package_name) do
    #     it { is_expected.to be_installed }
    #   end
    # end

    # context 'when package latest' do
    #   it 'is_expected.to work with no errors' do
    #     pp = <<-EOS
    #       class { 'common':
    #         package_ensure => 'latest',
    #       }
    #     EOS

    #     apply_manifest(pp, :catch_failures => true)
    #   end

    #   describe package(package_name) do
    #     it { is_expected.to be_installed }
    #   end
    # end

    # context 'when package absent' do
    #   it 'is_expected.to work with no errors' do
    #     pp = <<-EOS
    #       class { 'common':
    #         package_ensure => 'absent',
    #       }
    #     EOS

    #     apply_manifest(pp, :catch_failures => true)
    #   end

    #   describe package(package_name) do
    #     it { is_expected.not_to be_installed }
    #   end
    #   describe file(config_file_path) do
    #     it { is_expected.to be_file }
    #   end
    # end

    # context 'when package purged' do
    #   it 'is_expected.to work with no errors' do
    #     pp = <<-EOS
    #       class { 'common':
    #         package_ensure => 'purged',
    #       }
    #     EOS

    #     apply_manifest(pp, :catch_failures => true)
    #   end

    #   describe package(package_name) do
    #     it { is_expected.not_to be_installed }
    #   end
    #   describe file(config_file_path) do
    #     it { is_expected.not_to be_file }
    #   end
    # end
  end

  describe 'common::config' do
    context 'defaults' do
      it 'is_expected.to work with no errors' do
        pp = <<-EOS
          class { 'common': }
        EOS

        apply_manifest(pp, :catch_failures => true)
      end

      describe file(config_file_path) do
        it { is_expected.to be_file }
      end
    end
  end
end
