from random_words import RandomWords


def random_string():
    word = RandomWords()
    return word.random_word() + word.random_word() + word.random_word()