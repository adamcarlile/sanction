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

  describe 'with complex permissons' do
    let(:permissions_hash) { PERMISSIONS }

    it 'should return nil for a missing id and type' do
      permissions.find('test', 5).must_be_nil
    end
  end

end