require 'spec_helper'

describe Sanction::Node do

  let(:permissions_hash) do
    {
      mode: 'whitelist',
      scope: ['manage', 'read'],
      subjects: [
        {
          id: 6,
          type: 'bookcase',
          scope: []
        }
      ]
    }
  end
  let(:permissions) { Sanction.build(permissions_hash) }

  it 'should let me find id: 6' do
    permissions.find('bookcase', 6).id.must_equal 6
  end

  describe 'changing root node type' do

    it 'should return the root node as being a blacklist' do
      perm = permissions.root.change_type!(:blacklist)
      perm.mode.must_equal 'blacklist'
    end
  end

  describe 'with complex permissons' do
    let(:permissions_hash) { PERMISSIONS }

    describe 'changing a node type' do

      it 'should return the node as being changed' do
        perm = permissions.find('bookcase', 2).change_type!(:blacklist)
        perm.find('bookcase', 2).mode.must_equal 'blacklist'
      end

    end

    it 'should return root for a missing id and type' do
      permissions.find('test', 5).root?.must_equal true
    end
  end

end