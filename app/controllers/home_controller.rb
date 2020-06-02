class HomeController < ApplicationController
  require 'checksum_generator'

  def index

  end

  def generate_checksum
      text_to_checksum = ChecksumGenerator.generateChecksum(params[:checksum_text])
      redirect_to root_path(checksum: text_to_checksum)
  end
  
end
