require 'spec_helper'

describe 'Wildcarding' do

  let(:permissions_hash)  { {} }
  let(:permissions)       { Sanction.build(permissions_hash) }
  let(:predicates)        { [] }
  let(:permission)        { Sanction::Permission.new(permissions, *predicates)}

  describe 'whitelist' do

    let(:permissions_hash) { {
      mode: 'whitelist',
      scope: ['manage', 'read'],
      resources: ['bookcase', 'user'],
      subjects: [
        {
          id: 1,
          type: 'bookcase',
          scope: ['read']
        },
        {
          id: '*',
          mode: 'blacklist',
          type: 'user',
          scope: ['manage', 'read'],
          subjects: [
            {
              id: '*',
              type: 'bookcase',
              subjects: [
                id: '1',
                type: 'pack'
              ]
            }
          ]
        }
      ]
    } }
    let(:user) { User.new(7) }
    let(:predicates) { [user] }

    it 'should be permitted' do
      permission.permitted?.must_equal true
    end

    it 'should have the scope of manage' do
      permission.permitted_with_scope?(:manage).must_equal true
    end

    describe 'nested block' do
      let(:bookcase)   { Bookcase.new(121) }
      let(:predicates) { [user, bookcase] }

      it 'should not be permitted' do
        permission.permitted?.must_equal false
      end

      describe 'with a pack' do
        let(:pack) { Pack.new(1) }
        let(:predicates) { [user, bookcase, pack] }
        it 'should not be permitted' do
          permission.permitted?.must_equal false
        end
      end

    end
  end

  describe 'blacklist' do
    let(:permissions_hash) { {
      mode: 'blacklist',
      scope: ['manage', 'read'],
      resources: ['bookcase'],
      subjects: [
        {
          id: 1,
          type: 'bookcase',
          scope: ['read']
        },
        {
          id: '*',
          type: 'user',
          scope: ['manage', 'read']
        }
      ]
    } }
    let(:user) { User.new(7) }
    let(:predicates) { [user] }

    it 'should not be permitted' do
      permission.permitted?.must_equal false
    end
  end
end