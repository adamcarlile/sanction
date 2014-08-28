require 'spec_helper'

describe Sanction::Permission do

  let(:permissions) { Sanction.build(permissions_hash) }
  let(:predicates)  { [] }
  let(:permission)  { Sanction::Permission.new(permissions, *predicates)}

  let(:bookcase)    { Bookcase.new(6) }
  let(:shelf)       { Shelf.new(4) }
  let(:pack)        { Pack.new(5) }

  describe "With simple whitelist permissions" do

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
    let(:predicates)  { [bookcase] }

    it 'should be permitted' do
      permission.permitted?.must_equal true
    end

    it 'should have scope manage' do
      permission.permitted_with_scope?(:manage).must_equal true
    end

    it 'should have scope read' do
      permission.permitted_with_scope?(:read).must_equal true
    end

  end

  describe "With simple blacklist permissions" do
    let(:permissions_hash) do
      {
        mode: 'blacklist',
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
    let(:predicates)  { [bookcase] }

    it 'should not be permitted' do
      permission.permitted?.must_equal false
    end

    it 'should not be permitted for a scope of manage' do
      permission.permitted_with_scope?(:manage).must_equal false
    end

  end

  describe "With complex whitelist permissions" do
    let(:permissions_hash) { PERMISSIONS }
    let(:bookcase)   { Bookcase.new(2) }
    let(:predicates) { [bookcase, shelf] }

    describe "with a blacklisted mode shelf" do
      let(:shelf)    { Shelf.new(7) }

      describe "with a pack on the blacklist" do
        let(:pack)        { Pack.new(8) }
        let(:predicates)  { [bookcase, shelf, pack] }

        it 'should not be permitted' do
          permission.permitted?.must_equal false
        end

      end

      describe "with a pack not on the blacklist" do
        let(:pack)       { Pack.new(100) }
        let(:predicates) { [bookcase, shelf, pack] }

        it 'should be permitted' do
          permission.permitted?.must_equal true
        end

        it 'should have its parents scopes' do
          permission.permitted_with_scope?(:manage).must_equal true
          permission.permitted_with_scope?(:read).must_equal true
        end

      end

    end

    describe "with a whitelisted shelf" do
      let(:shelf)    { Shelf.new(4) }

      it 'should be permitted' do
        permission.permitted?.must_equal true
      end

      describe "with a whitelisted pack" do
        let(:pack)   { Pack.new(5) }
        let(:predicates) { [bookcase, shelf, pack] }

        it 'should be permitted' do
          permission.permitted?.must_equal true
        end

        it 'should have a read and manage scope' do
          permission.permitted_with_scope?(:manage).must_equal true
          permission.permitted_with_scope?(:read).must_equal true
        end

      end

    end

  end

  describe "With missing blacklist permissions" do
    let(:permissions_hash) { PERMISSIONS }
    let(:bookcase)    { Bookcase.new(1) }
    let(:predicates)  { [bookcase, shelf] }

    describe "with a blacklisted shelf" do
      let(:shelf)     { Shelf.new(6) }

      it 'should not be permitted' do
        permission.permitted?.must_equal false
      end

      describe "with a pack within a blacklisted shelf" do
        let(:pack)        { Pack.new(98) }
        let(:predicates)  { [bookcase, shelf, pack] }

        it 'should not be permitted' do
          permission.permitted?.must_equal false
        end

        it 'should not have a read scope' do
          permission.permitted_with_scope?(:read).must_equal false
        end

      end

    end

    describe 'with a non blacklisted shelf' do
      let(:shelf)     { Shelf.new(31) }

      it 'should be permitted' do
        permission.permitted?.must_equal true
      end

      describe 'with a non blacklisted pack' do
        let(:pack)        { Pack.new(10) }
        let(:predicates)  { [bookcase, shelf, pack] }

        it 'should be permitted' do
          permission.permitted?.must_equal true
        end

        it 'should have a read scope' do
          permission.permitted_with_scope?(:read).must_equal true
        end

      end

    end
  end

end