require 'spec_helper'

describe 'common', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_anchor('common::begin') }
      it { is_expected.to contain_class('common::params') }
      it { is_expected.to contain_class('common::install') }
      it { is_expected.to contain_class('common::config') }
      it { is_expected.to contain_anchor('common::end') }

      describe 'common::install' do
        context 'defaults' do
          let(:params) do
            {
              package_name: 'colordiff'
            }
          end

          it do
            is_expected.to contain_package('common').with(
              'ensure' => 'present'
            )
          end
        end

        context 'when package latest' do
          let(:params) do
            {
              package_ensure: 'latest',
              package_name:   'colordiff'
            }
          end

          it do
            is_expected.to contain_package('common').with(
              'ensure' => 'latest'
            )
          end
        end

        context 'when package absent' do
          let(:params) do
            {
              package_ensure: 'absent',
              package_name:   'colordiff'
            }
          end

          it do
            is_expected.to contain_package('common').with(
              'ensure' => 'absent'
            )
          end
          it do
            is_expected.to contain_file('common.conf').with(
              'ensure'  => 'present',
              'require' => nil
            )
          end
        end

        context 'when package purged' do
          let(:params) do
            {
              package_ensure: 'purged',
              package_name:   'colordiff'
            }
          end

          it do
            is_expected.to contain_package('common').with(
              'ensure' => 'purged'
            )
          end
          it do
            is_expected.to contain_file('common.conf').with(
              'ensure'  => 'absent',
              'require' => nil
            )
          end
        end
      end

      describe 'common::config' do
        context 'defaults' do
          it do
            is_expected.to contain_file('common.conf').with(
              'ensure'  => 'present',
              'require' => nil
            )
          end
        end

        context 'when source dir' do
          let(:params) do
            {
              config_dir_source: 'puppet:///modules/common/etc'
            }
          end

          it do
            is_expected.to contain_file('common.dir').with(
              'ensure'  => 'directory',
              'force'   => false,
              'purge'   => false,
              'recurse' => true,
              'source'  => 'puppet:///modules/common/etc',
              'require' => nil
            )
          end
        end

        context 'when source dir purged' do
          let(:params) do
            {
              config_dir_purge: true,
              config_dir_source: 'puppet:///modules/common/etc'
            }
          end

          it do
            is_expected.to contain_file('common.dir').with(
              'ensure'  => 'directory',
              'force'   => true,
              'purge'   => true,
              'recurse' => true,
              'source'  => 'puppet:///modules/common/etc',
              'require' => nil
            )
          end
        end

        context 'when source file' do
          let(:params) do
            {
              config_file_source: 'puppet:///modules/common/etc/group'
            }
          end

          it do
            is_expected.to contain_file('common.conf').with(
              'ensure'  => 'present',
              'source'  => 'puppet:///modules/common/etc/group',
              'require' => nil
            )
          end
        end

        context 'when content string' do
          let(:params) do
            {
              config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
            }
          end

          it do
            is_expected.to contain_file('common.conf').with(
              'ensure'  => 'present',
              'content' => %r{THIS FILE IS MANAGED BY PUPPET},
              'require' => nil
            )
          end
        end
      end
    end
  end
end
