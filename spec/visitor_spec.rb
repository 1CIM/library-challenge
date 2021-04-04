require './lib/visitor.rb'
require './lib/library.rb'
require 'date'

describe Visitor do

    

    it 'can check what books are available for rent' do
        expected_outcome = [
            {:available=>true, :item=>{:author=>"J.R.R. Tolkien", :title=>"Lord of the Rings"}, :return_date=>nil},
            {:available=>true, :item=>{:author=>"Eric Nylund", :title=>"Halo: Fall of Reach"}, :return_date=>nil},
            {:available=>true, :item=>{:author=>"E.L. James", :title=>"Fifty Shades of Grey"}, :return_date=>nil}
        ]
        expect(subject.see_available).to eq expected_outcome
    end
   
    it 'can rent the book' do
        subject.read_book_list
        subject.rent_the_book({title: 'Lord of the Rings'})
        subject.read_book_list
        subject.pull_book({title: 'Lord of the Rings'})
        expected_outcome = {:item=>{:title=>"Lord of the Rings", :author=>"J.R.R. Tolkien"}, :available=>false, :return_date=>subject.thirty_days_later}
        expect(subject.pulled_book).to eq expected_outcome
    end

    it 'sends a recipet' do
        subject.read_book_list
        subject.rent_the_book({title: 'Fifty Shades of Grey'})
        expected_outcome = {title: "Fifty Shades of Grey", return_date: subject.thirty_days_later, date: Date.today.strftime('%d-%m-%y') }
        expect(subject.receipt).to eq expected_outcome
    end  

    after(:all) do
        book_list = YAML.load_file('./lib/books_original_state.yml')
        File.open('./lib/books.yml', 'w') { |file| file.write book_list.to_yaml }
      end
    
    #rent_the_book
    #see_currently_owned
    #return_the_book

end