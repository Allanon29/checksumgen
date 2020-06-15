class ChecksumGenerator 
    
    VOWELS = ['a','e','i','o','u']
    ALPHABET = ('a'..'z').to_a

    # The below method is called from the home_controller
    def self.generateChecksum(checksum_text)  
        removed_letters = remove_unwanted_chars(checksum_text)
        ten_char_words = create_ten_char_words(removed_letters)
        capitalized_words = captialize_words(ten_char_words)
        converted_vowels = convert_vowels(capitalized_words)
        checksum_to_numbers = numberize_checksum(checksum_text, ten_char_words, converted_vowels)

        return checksum_to_numbers
    end

    # Remove any character that is not in the English ABC, not space
    def self.remove_unwanted_chars(checksum_text)
        return checksum_text.split('').map {|l| l if ALPHABET.include?(l.downcase) || l == ' ' }.join()
    end

    # Create words which are 10 characters long, by joining the words
    def self.create_ten_char_words(removed_letters)
        # First I delete spaces from result in the previous step, then create an array of letters which will be the building blocks for the 10 char words
        ten_char_words = removed_letters.delete(' ').split('')
        # Created an empty array which will contain the 10 char long words
        ten_word_array = []
        # I calculate how many 10 char words can be created from the array. If there is a remainder it will be the last word
        num_of_ten_char_words = ten_char_words.length.to_f / 10.to_f
        # Created a loop which puts together the 10 char words from the letter array
        i = 1
        if num_of_ten_char_words.to_i === 0
            # If there are less chars in the letter array then 10 then ther will be 1 word only which has less than 10 chars
            ten_word_array.push(ten_char_words.join(''))
        else
            # If the length of the letter array is more than 10 meaning num_of_ten_char_words is at least 1 then the loop below starts to extract 10 chars from it, the deletes those 10 chars, and adds the created word to ten_word_array
            while i <= num_of_ten_char_words do
                ten_word_array.push(ten_char_words[0..9].join(''))
                ten_char_words.slice!(0..9)
                i += 1
            end
            # This is needed because of the last word which might be less than 10 chars long
            if ten_char_words.length > 0
                ten_word_array.push(ten_char_words.join(''))
            end
        end

        return ten_word_array
    end

    # Capitalize each word (E.g.: Each word should start with a capital letter and all other letter should be lowercase)
    def self.captialize_words(ten_char_words)
        return ten_char_words.map { |w| w.capitalize }
    end

    # Upper case any vowel that is after two or more consonants and previous vowel is upper case.
    # Downcase any vowel that doesn’t match the above rule, do not down case any vowel which is the first letter of a word.
    def self.convert_vowels(capitalized_words)
        # First I add spaces to the captialized ten word array. Spaces will serve as markers of the beginning of words.
        splitted_ten_word_array = capitalized_words.join(' ').split('')
        # The array below will contain the text with converted vowels
        converted_vowel_array = []
        # Then I loop over the array with added spaces
        splitted_ten_word_array.each_with_index do |w,i|
            # To decide if I have to transform the current vowel I need to know if the previous one is uppercase. For this, I filter the converted_vowel_array which might already contain transformed vowels
            vowels_with_lower_index = converted_vowel_array.select { |e| VOWELS.include?(e.downcase) }
            # Push the letter to converted vowel array if its a consonant as they do not need to be transformed.
            converted_vowel_array.push(w) if !VOWELS.include?(w.downcase)
            # First I check if the current letter is a vowel. Then I check if the previous 2 letters are consonants. Then I check if there are any vowels in the filtered array, then if there are I check the last one if its equal to its uppercase version
            if VOWELS.include?(w.downcase) && !VOWELS.include?(splitted_ten_word_array[i-1].downcase) && !VOWELS.include?(splitted_ten_word_array[i-2].downcase) && vowels_with_lower_index.length > 0 && vowels_with_lower_index[-1] === vowels_with_lower_index[-1].upcase
                converted_vowel_array.push(w.upcase)
            elsif splitted_ten_word_array[i-1] === ' ' && VOWELS.include?(w.downcase) 
                # Vowels that are the first letters of a word should be already upcased by the capitalize_words method and must stay that way. They can be identifed by the space before them.
                converted_vowel_array.push(w)
            elsif VOWELS.include?(w.downcase)
                # To avoid creating another loop I put the case here when the vowel needs to be downcased. 
                converted_vowel_array.push(w.downcase)
            end
        end

        return converted_vowel_array.join('')
    end

    # Checksum contains: Count of original words ( before deleting the foreign chars ), Count of newly created words, Count of upper case vowels, Count of consonants, Length of original string ( before deleting the foreign chars )
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