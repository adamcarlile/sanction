require 'spec_helper'

# Issues lifted from the web app

describe 'application issues' do

  let(:permissions_hash)  { {} }
  let(:permissions)       { Sanction.build(permissions_hash) }
  let(:predicates)        { [] }
  let(:permission)        { Sanction::Permission.new(permissions, *predicates)}

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

  end


end