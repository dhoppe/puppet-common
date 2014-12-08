require 'spec_helper'

describe 'common::define', :type => :define do
  ['Debian'].each do |osfamily|
    let(:facts) {{
      :osfamily => osfamily,
    }}
    let(:pre_condition) { 'include common' }
    let(:title) { 'group' }

    context "on #{osfamily}" do
      context 'when source file' do
        let(:params) {{
          :config_file_source => 'puppet:///modules/common/etc/group',
        }}

        it do
          is_expected.to contain_file('define_group').with({
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/common/etc/group',
            'require' => nil,
          })
        end
      end

      context 'when content string' do
        let(:params) {{
          :config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        }}

        it do
          is_expected.to contain_file('define_group').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => nil,
          })
        end
      end

#      context 'when content template' do
#        let(:params) {{
#          :config_file_template => 'common/etc/group.erb',
#        }}
#
#        it do
#          is_expected.to contain_file('define_group').with({
#            'ensure'  => 'present',
#            'content' => /THIS FILE IS MANAGED BY PUPPET/,
#            'require' => nil,
#          })
#        end
#      end
#
#      context 'when content template (custom)' do
#        let(:params) {{
#          :config_file_template     => 'common/etc/group.erb',
#          :config_file_options_hash => {
#            'key' => 'value',
#          },
#        }}
#
#        it do
#          is_expected.to contain_file('define_group').with({
#            'ensure'  => 'present',
#            'content' => /THIS FILE IS MANAGED BY PUPPET/,
#            'require' => nil,
#          })
#        end
#      end
    end
  end
end
