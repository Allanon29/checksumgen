require 'spec_helper'
require 'checksum_generator'

describe "checksum_generator" do
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
    cap_array = ChecksumGenerator.convert_vowels(['Foobarbazw', 'Ibblefizzb', 'Uzzfizzbuz', 'Z']).join('') 
    expect(cap_array).to eq(['Foobarbazw', 'IbblEfizzb', 'UzzfIzzbUz', 'Z'])
  end
end