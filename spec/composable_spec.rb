require 'spec_helper'

# Composing whole graphs with boolean combinators. `yes` permits the bookcase,
# `no` denies it; everything below is built from those two primitives so the
# combinator semantics are unambiguous.
describe Sanction::Composable do

  let(:bookcase) { Bookcase.new(6) }

  let(:yes) do
    Sanction.build(
      mode: 'whitelist',
      scope: ['read'],
      resources: ['bookcase'],
      subjects: [ { id: 6, type: 'bookcase' } ]
    )
  end

  let(:no) do
    Sanction.build(
      mode: 'whitelist',
      scope: ['read'],
      resources: [],
      subjects: [ { id: 6, type: 'bookcase' } ]
    )
  end

  def permits?(graph)
    Sanction::Permission.new(graph, bookcase).permitted?
  end

  # Sanity: the primitives behave as the rest of the suite assumes.
  it 'has a permitting and a denying primitive' do
    _(permits?(yes)).must_equal true
    _(permits?(no)).must_equal false
  end

  describe '#and (intersection)' do
    it 'permits only when both graphs permit' do
      _(permits?(yes.and(yes))).must_equal true
      _(permits?(yes.and(no))).must_equal false
      _(permits?(no.and(yes))).must_equal false
      _(permits?(no.and(no))).must_equal false
    end
  end

  describe '#or (union)' do
    it 'permits when either graph permits' do
      _(permits?(yes.or(yes))).must_equal true
      _(permits?(yes.or(no))).must_equal true
      _(permits?(no.or(yes))).must_equal true
      _(permits?(no.or(no))).must_equal false
    end
  end

  describe 'chaining' do
    # A composite is itself composable, so chains nest to any depth.
    it 'is left-associative: a.or(b).and(c) == (a OR b) AND c' do
      # (yes OR no) AND no  ==  true AND false  ==  false
      _(permits?(yes.or(no).and(no))).must_equal false
    end

    it 'groups explicitly when a chain is passed as the argument' do
      # yes OR (no AND no)  ==  true OR false  ==  true
      _(permits?(yes.or(no.and(no)))).must_equal true
    end
  end

  describe 'scopes' do
    it 'folds permitted_with_scope? through the operator' do
      _(Sanction::Permission.new(yes.and(yes), bookcase).permitted_with_scope?(:read)).must_equal true
      _(Sanction::Permission.new(yes.and(no),  bookcase).permitted_with_scope?(:read)).must_equal false
      _(Sanction::Permission.new(no.or(yes),   bookcase).permitted_with_scope?(:read)).must_equal true
      _(Sanction::Permission.new(yes.and(yes), bookcase).permitted_with_scope?(:write)).must_equal false
    end
  end

end
