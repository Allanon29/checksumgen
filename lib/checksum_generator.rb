class ChecksumGenerator
    def self.generateChecksum(checksum_text)
        english_alphabet = ('a'..'z').to_a
        vowels = ['a','e','i','o','u']

        original_word_count = checksum_text.split(' ').length
        original_length = checksum_text.length

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

        ten_word_array.map! { |w| w.capitalize }

        splitted_ten_word_array = ten_word_array.join(' ').split('')
        myarray = []
        splitted_ten_word_array.each_with_index do |w,i|
            elements_with_lower_index = splitted_ten_word_array[0...i].select { |e| vowels.include?(e.downcase) }
            
            
            myarray.push(w) if !vowels.include?(w.downcase)
            if splitted_ten_word_array[i-1] === ' ' && vowels.include?(w.downcase) || vowels.include?(w.downcase) && elements_with_lower_index.length > 0 && i > 1 && !vowels.include?(splitted_ten_word_array[i-1].downcase) && !vowels.include?(splitted_ten_word_array[i-2].downcase) && elements_with_lower_index[-1] === elements_with_lower_index[-1].upcase
                print elements_with_lower_index[-1]
                myarray.push(w.capitalize)
            elsif vowels.include?(w.downcase)
                i != 0 && splitted_ten_word_array[i-1] != ' ' ? myarray.push(w.downcase) : myarray.push(w)
            end
        end

        uppercase_vowels = myarray.select { |l| vowels.include?(l.downcase) && l === l.upcase }.length
        consonant_count = myarray.select { |l| !vowels.include?(l.downcase) && l != ' ' }.length

        checksum_to_return = original_word_count.to_s + "-" + number_of_new_words.to_s + "-" + uppercase_vowels.to_s + "-" + consonant_count.to_s + "-" + original_length.to_s

        return checksum_to_return
    end

    def remove_unwanted_chars
    end
end