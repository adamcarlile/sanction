require 'spec_helper'

describe Sanction::Gatekeeper do

  let(:permissions) { Sanction.build(PERMISSIONS) }
  let(:bookcase)    { Bookcase.new.tap { |x| x.id = 1 } }
  let(:gatekeeper)  { Sanction::Gatekeeper.new(permissions, bookcase, shelf) }

  describe 'with a blacklisted shelf' do

    let(:shelf)       { Shelf.new.tap { |x| x.id = 6 } }

    it "should not be permitted" do
      gatekeeper.permission.must_be_nil
    end

  end

  describe 'with a none blacklisted shelf in a blacklisted node' do

    let(:shelf)      { Shelf.new.tap { |x| x.id = 8 } }

    it 'should be permitted' do
      gatekeeper.permission.wont_be_nil
    end

  end

end