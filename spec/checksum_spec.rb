require 'spec_helper'
require 'checksum_generator'

describe "checksum_generator" do

  checksum_texts = [{val: 'foo bar baz wibble fizzbuzz fizz buzz', expected: '7-4-5-21-37'}, {val: 'The quick brown fox jumps over the lazy dog', expected: '9-4-4-24-43'}]

  it "needs checksum text" do
    expect { ChecksumGenerator.generateChecksum() }.to raise_error(ArgumentError)
  end

  it 'needs to delete unwanted chars' do
    removed_chars = ChecksumGenerator.remove_unwanted_chars('áálááőlpőúlkpőkpkpő')
    expect(removed_chars).to eq('llplkpkpkp')
  end

  it 'creates 10 char words' do
    removed_chars = ChecksumGenerator.create_ten_char_words('afgafzsgfigsdfigigreigerifgerifgeirfgaierfg')
    expect(removed_chars).to eq(['afgafzsgfi', 'gsdfigigre', 'igerifgeri', 'fgeirfgaie', 'rfg'])
  end

  it "needs to capitalize words" do
    cap_array = ChecksumGenerator.captialize_words(['fgfgdgdfg','dfgdgdg','ddfgdgdg','d']) 
    expect(cap_array).to eq(['Fgfgdgdfg', 'Dfgdgdg', 'Ddfgdgdg', 'D'])
  end

  it "needs to convert vowels" do
    cap_array = ChecksumGenerator.convert_vowels(['FoObarbazw', 'IbblefizOb', 'Uzzfizzbuz', 'Z']) 
    expect(cap_array).to eq('Foobarbazw IbblEfizob UzzfIzzbUz Z')
  end
  
  checksum_texts.each do |text|
    it "needs to numberize checksum text #{text[:val]} to #{text[:expected]}" do
      removed_chars = ChecksumGenerator.remove_unwanted_chars(text[:val])
      ten_char_words = ChecksumGenerator.create_ten_char_words(removed_chars)
      captialized_words = ChecksumGenerator.captialize_words(ten_char_words)
      convert_vowels = ChecksumGenerator.convert_vowels(captialized_words)
      numberized_checksum = ChecksumGenerator.numberize_checksum(text[:val], ten_char_words, convert_vowels)
      
      expect(numberized_checksum).to eq(text[:expected])
    end

    it "needs to create correct checksum from: #{text[:val]}" do
      generated_checksum = ChecksumGenerator.generateChecksum(text[:val])
      
      expect(generated_checksum).to eq(text[:expected])
    end
  end

end