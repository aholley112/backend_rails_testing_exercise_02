require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'associations' do
    it 'belongs to author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with a valid author' do
      author = Author.create(name: 'Author Name')
      book = Book.new(title: 'Book Title', author: author)
      expect(book).to be_valid
    end

    it 'is invalid without an author' do
      book = Book.new(title: 'Book Title')
      book.valid? 
      expect(book.errors[:author]).to include("must exist")
    end
  end

  describe 'when author is deleted' do
    it 'deletes associated books' do
      author = Author.create(name: 'Author Name')
      book = author.books.create(title: 'Book Title')
      expect { author.destroy }.to change { Book.count }.by(-1)
    end
  end
end
