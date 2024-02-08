require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'has many books' do
    association = described_class.reflect_on_association(:books)
    expect(association.macro).to eq(:has_many)
  end
end
