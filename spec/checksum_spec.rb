require 'spec_helper'
require 'checksum_generator'

describe "checksum_generator" do
  it "needs checksum text" do
    expect { ChecksumGenerator.generateChecksum() }.to raise_error(ArgumentError)
  end

  it "needs to capitalize words" do
    expect { ChecksumGenerator.generateChecksum('Foobarbazw Ibblefizzb Uzzfizzbuz Z') }.to eq('Foobarbazw IbblEfizzb UzzfIzzbUz Z')
  end
end