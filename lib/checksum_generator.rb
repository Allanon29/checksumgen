class ChecksumGenerator
    def self.generateChecksum(checksum_text)
        english_alphabet = ('a'..'z').to_a

        removed_letters = checksum_text.split('').map {|l| l if english_alphabet.include?(l) || l == ' ' }.join('')

        return removed_letters
    end
end