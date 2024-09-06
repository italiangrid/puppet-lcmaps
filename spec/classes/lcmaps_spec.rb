require 'spec_helper'

describe 'lcmaps' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      gridmapdir='/etc/grid-security/gridmapdir'
      groupmapfile='/etc/grid-security/groupmapfile'
      gridmapfile='/etc/grid-security/grid-mapfile'

      context 'with default parameters' do

        it "check installed packages" do
          is_expected.to contain_package('lcmaps').with( :ensure => 'latest' )
        end

        it "check gridmap dir" do
          is_expected.to contain_file(gridmapdir).with( 
            :ensure => 'directory',
            :owner  => 'storm',
            :group  => 'storm',
            :mode   => '0770',
          )
        end

        it "check groupmapfile content" do
          is_expected.to contain_file(groupmapfile).with( :content => /"\/test.vo\/Role=NULL\/Capability=NULL" testvo/ )
          is_expected.to contain_file(groupmapfile).with( :content => /"\/test.vo" testvo/ )
          is_expected.to contain_file(groupmapfile).with( :content => /"\/test.vo.2\/Role=NULL\/Capability=NULL" testvodue/ )
          is_expected.to contain_file(groupmapfile).with( :content => /"\/test.vo.2" testvodue/ )
        end

        it "check grid-mapfile content" do
          is_expected.to contain_file(gridmapfile).with( :content => /"\/test.vo\/Role=NULL\/Capability=NULL" .tstvo/ )
          is_expected.to contain_file(gridmapfile).with( :content => /"\/test.vo" .tstvo/ )
          is_expected.to contain_file(gridmapfile).with( :content => /"\/test.vo.2\/Role=NULL\/Capability=NULL" .testdue/ )
          is_expected.to contain_file(gridmapfile).with( :content => /"\/test.vo.2" .testdue/ )
        end

        it "check test.vo pool account users" do

          is_expected.to contain_group('testvo').with(
            :ensure => 'present',
            :gid    => 7100,
          )
          
          (1..20).each do | i |
            name=sprintf('tstvo%03d', i)
            is_expected.to contain_user(name).with(
              :ensure => 'present',
              :uid    => 7100 + i,
              :gid    => 7100,
              :groups => ['testvo'],
            )
            path=sprintf('%s/%s', gridmapdir, name)
            is_expected.to contain_file(path).with( 
              :ensure  => 'file',
            )
          end
          
        end

        it "check test.vo.2 pool account users" do

          is_expected.to contain_group('testvodue').with(
            :ensure => 'present',
            :gid    => 8100,
          )

          (1..20).each do | i |
            name=sprintf('testdue%03d', i)
            is_expected.to contain_user(name).with(
              :ensure => 'present',
              :uid    => 8100 + i,
              :gid    => 8100,
              :groups => ['testvodue'],
            )
            path=sprintf('%s/%s', gridmapdir, name)
            is_expected.to contain_file(path).with( 
              :ensure  => 'file',
            )
          end
          
        end

        context 'with custom pool accounts' do
          let(:params) do
            {
              'pools' => [
                'name' => 'test',
                'size' => 10,
                'base_uid' => 0,
                'group' => 'g1',
                'groups' => ['g1', 'g2'],
                'gid' => 10,
                'vo' => 'vo',
                'role' => 'admin',
                'capability' => 'admin'
              ],
            }
          end

          it 'check users gridmapdir and groups have been created' do
            (1..10).each do | i |
              name=sprintf('test%03d', i)
              is_expected.to contain_user(name).with(
                :ensure => 'present',
                :uid    => i,
                :gid    => 10,
                :groups => ['g1', 'g2'],
              )
              path=sprintf('%s/%s', gridmapdir, name)
              is_expected.to contain_file(path).with( 
                :ensure  => 'file',
              )
            end
            (1..2).each do | i |
              gname=sprintf('g%d', i)
              is_expected.to contain_group(gname).with(
                :ensure => 'present',
              )
            end
          end

          it "check groupmapfile content" do
            is_expected.to contain_file(groupmapfile).with( :content => /"\/vo\/Role=admin\/Capability=admin" g1/ )
          end

          it "check grid-mapfile content" do
            is_expected.to contain_file(gridmapfile).with( :content => /"\/vo\/Role=admin\/Capability=admin" .test/ )
          end
        end

      end
    end
  end
end
