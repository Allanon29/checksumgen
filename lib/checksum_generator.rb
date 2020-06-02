class ChecksumGenerator
    def self.generateChecksum(checksum_text)
        english_alphabet = ('a'..'z').to_a

        removed_letters = checksum_text.split('').map {|l| l if english_alphabet.include?(l) || l == ' ' }.join('')

        ten_char_words = removed_letters.delete(' ').split('')
        ten_word_array = []
        num_of_ten_char_words = ten_char_words.length.to_f / 10.to_f

        number_of_new_words = num_of_ten_char_words.ceil

        i = 1
        if num_of_ten_char_words.to_i === 0
            ten_word_array.push(ten_char_words.join(''))
        else
            while i <= num_of_ten_char_words do
                ten_word_array.push(ten_char_words[0..9].join(''))
                ten_char_words.slice!(0..9)
                i += 1
            end
            if ten_char_words.length > 0
                ten_word_array.push(ten_char_words.join(''))
            end
        end

        return ten_word_array.join(' ')
    end
end