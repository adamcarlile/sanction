require 'spec_helper'

# Issues lifted from the web app

describe 'application issues' do

  let(:permissions_hash)  { {} }
  let(:permissions)       { Sanction.build(permissions_hash) }
  let(:predicates)        { [] }
  let(:permission)        { Sanction::Permission.new(permissions, *predicates)}

  describe 'regular user with one allowed bookcase, but no allowed shelves' do
    let(:permissions_hash) do
      {
        mode: "whitelist",
        scope: [:read],
        subjects: [
          {
            id: "948b9ace-784f-4326-aeb9-a2a0587d75b9", 
            type: 'bookcase', 
            mode: "whitelist", 
            scope: [:read, :manage],
            resources: []
          }
        ],
        resources: [:bookcase]
       }
    end
    let(:predicates) { [Bookcase.new('948b9ace-784f-4326-aeb9-a2a0587d75b9')] }

    it 'should not allow access to any shelves' do
      permission.path[:shelf].permitted?.must_equal false
    end

    describe "allowing a new shelf" do
      before do
        permission.path[:shelf][1234].allow!
      end

      it 'should allow access to the shelf' do
        permission.path[:shelf][1234].permitted?.must_equal true
      end
    end
  end

  describe 'admin user with one banned bookcase' do

    let(:permissions_hash) do
      {
        mode: 'blacklist',
        scope: [:read, :manage],
        subjects: [
          {
            id:   'f23175aa-014b-4796-aaef-878df597e7f1',
            type: 'bookcase', 
            mode: 'whitelist'
          }
        ]
      }
    end

    let(:predicates) { [User.new(32)] }

    it 'should allow access for a user and a random id' do
      permission.permitted?.must_equal true
    end

    describe 'disalowing neseted objects' do
      before do
        permission.path.root[:bookcase][12][:shelf][10][:pack][14].deny!
      end

      it 'should not be viewable' do
        permission.path.root[:bookcase][12][:shelf][10][:pack][14].permitted?.must_equal false
      end
    end

    describe 'disalowing a user' do
      before do
        permission.path.root[:user][12].deny!
      end

      it 'should prevent access to user 12' do
        permission.path.root[:user][12].permitted?.must_equal false
      end
    end

  end


end