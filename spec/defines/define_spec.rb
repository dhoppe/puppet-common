require 'spec_helper'

describe 'common::define', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:pre_condition) { 'include common' }
      let(:title) { 'group' }

      context 'when source file' do
        let(:params) do
          {
            config_file_path: '/etc/group.2nd',
            config_file_source: 'puppet:///modules/common/etc/group'
          }
        end

        it do
          is_expected.to contain_file('define_group').with(
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/common/etc/group',
            'require' => nil
          )
        end
      end

      context 'when content string' do
        let(:params) do
          {
            config_file_path: '/etc/group.3rd',
            config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
          }
        end

        it do
          is_expected.to contain_file('define_group').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'require' => nil
          )
        end
      end

      # context 'when content template' do
      #   let(:params) {{
      #     :config_file_path   => '/etc/group.4th',
      #     :config_file_template => 'common/etc/group.erb',
      #   }}

      #   it do
      #     is_expected.to contain_file('define_group').with(
      #       'ensure'  => 'present',
      #       'content' => /THIS FILE IS MANAGED BY PUPPET/,
      #       'require' => nil,
      #     )
      #   end
      # end

      # context 'when content template (custom)' do
      #   let(:params) {{
      #     :config_file_path         => '/etc/group.5th',
      #     :config_file_template     => 'common/etc/group.erb',
      #     :config_file_options_hash => {
      #       'key' => 'value',
      #     },
      #   }}

      #   it do
      #     is_expected.to contain_file('define_group').with(
      #       'ensure'  => 'present',
      #       'content' => /THIS FILE IS MANAGED BY PUPPET/,
      #       'require' => nil,
      #     )
      #   end
      # end
    end
  end
end
