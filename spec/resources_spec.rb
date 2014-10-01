require 'spec_helper'

describe 'Nodes with resource restrictions' do

  let(:permissions_hash)  { {} }
  let(:permissions)       { Sanction.build(permissions_hash) }
  let(:predicates)        { [] }
  let(:permission)        { Sanction::Permission.new(permissions, *predicates)}

  describe 'whitelisted resources' do
    let(:permissions_hash) do
      {
        mode: 'whitelist',
        scope: ['manage', 'read'],
        resources: ['bookcase'],
        subjects: [
          {
            id: 3,
            mode: 'blacklist',
            type: 'bookcase',
            scope: [],
            resources: ['pack'],
            subjects: [
              {
                id: 12,
                type: 'shelf'
              }
            ]
          },
          {
            id: 6,
            mode: 'whitelist',
            type: 'bookcase',
            scope: [],
            resources: ['*'],
            subjects: [
              {
                id: 8,
                type: 'shelf'
              }
            ]
          }
        ]
      }
    end

    describe 'nested wildcard' do
      let(:predicates) { [Bookcase.new(6), Shelf]}

      it 'should allow shelves' do
        permission.permitted?.must_equal true
      end
    end

    describe 'nested blacklist' do
      let(:predicates) { [Bookcase.new(3), Pack] }

      it 'should not allow packs' do
        permission.permitted?.must_equal false
      end
    end

    describe 'bookcase' do
      let(:predicates) { [Bookcase] }

      it 'should allow bookcases' do
        permission.permitted?.must_equal true
      end
    end

    describe 'shelf' do
      let(:predicates) { [Shelf] }

      it 'should not allow shelves' do
        permission.permitted?.must_equal false
      end
    end

  end

  describe 'none blacklisted resource type' do
    let(:permissions_hash) do
      {
        mode: 'blacklist',
        scope: ['manage', 'read'],
        resources: ['bookcase'],
        subjects: [
          {
            id: 6,
            type: 'bookcase',
            scope: []
          }
        ]
      }
    end

    it 'should not return the bookcase ids' do
      permission.path[:bookcase].denied_ids.must_equal [6]
    end
  end

  describe 'none whitelisted resource type' do
    let(:permissions_hash) do
      {
        mode: 'whitelist',
        scope: ['manage', 'read'],
        resources: [],
        subjects: [
          {
            id: 6,
            type: 'bookcase',
            scope: []
          }
        ]
      }
    end

    it 'should not return the bookcase ids' do
      permission.path[:bookcase].allowed_ids.must_equal []
    end

  end

  describe 'blacklisted resources' do
    let(:permissions_hash) do
      {
        mode: 'whitelist',
        scope: ['manage', 'read'],
        resources: ['bookcase'],
        subjects: [
          {
            id: 6,
            type: 'bookcase',
            scope: []
          }
        ]
      }
    end

    describe 'bookcase' do
      let(:predicates) { [Bookcase] }

      it 'should allow bookcases' do
        permission.permitted?.must_equal true
      end
    end

    describe 'shelf' do
      let(:predicates) { [Shelf] }

      it 'should not allow shelves' do
        permission.permitted?.must_equal false
      end
    end
    
  end

end