class ChecksumGenerator 
    # Initialize the Rails application.
    VOWELS = ['a','e','i','o','u']
    ALPHABET = ('a'..'z').to_a

    def self.generateChecksum(checksum_text)
        
        removed_letters = remove_unwanted_chars(checksum_text)
        ten_char_words = create_ten_char_words(removed_letters)
        capitalized_words = captialize_words(ten_char_words)
        converted_vowels = convert_vowels(capitalized_words)
        checksum_to_numbers = numberize_checksum(checksum_text, ten_char_words, converted_vowels)

        return checksum_to_numbers
    end

    def self.remove_unwanted_chars(checksum_text)
        return checksum_text.split('').map {|l| l if ALPHABET.include?(l.downcase) || l == ' ' }.join()
    end

    def self.create_ten_char_words(removed_letters)
        ten_char_words = removed_letters.delete(' ').split('')
        ten_word_array = []

        num_of_ten_char_words = ten_char_words.length.to_f / 10.to_f

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

        return ten_word_array
    end

    def self.captialize_words(ten_char_words)
        return ten_char_words.map { |w| w.capitalize }
    end

    def self.convert_vowels(capitalized_words)
        splitted_ten_word_array = capitalized_words.join(' ').split('')
        converted_vowel_array = []
        splitted_ten_word_array.each_with_index do |w,i|
            vowels_with_lower_index = converted_vowel_array.select { |e| VOWELS.include?(e.downcase) }

            converted_vowel_array.push(w) if !VOWELS.include?(w.downcase)

            if VOWELS.include?(w.downcase) && !VOWELS.include?(splitted_ten_word_array[i-1].downcase) && !VOWELS.include?(splitted_ten_word_array[i-2].downcase) && vowels_with_lower_index.length > 0 && vowels_with_lower_index[-1] === vowels_with_lower_index[-1].upcase
                converted_vowel_array.push(w.capitalize)
            elsif splitted_ten_word_array[i-1] === ' ' && VOWELS.include?(w.downcase) 
                converted_vowel_array.push(w)
            elsif VOWELS.include?(w.downcase)
                converted_vowel_array.push(w.downcase)
            end
        end

        return converted_vowel_array.join('')
    end

    def self.numberize_checksum(checksum_text, ten_char_words, converted_vowels)
        splitted_converted_vowels = converted_vowels.split('')

        original_word_count = checksum_text.split(' ').length
        original_length = checksum_text.length
        number_of_new_words = ten_char_words.length
        uppercase_vowels = splitted_converted_vowels.select { |l| VOWELS.include?(l.downcase) && l === l.upcase }.length
        consonant_count = splitted_converted_vowels.select { |l| !VOWELS.include?(l.downcase) && l != ' ' }.length

        return "#{original_word_count}-#{number_of_new_words}-#{uppercase_vowels}-#{consonant_count}-#{original_length}"
    end
end