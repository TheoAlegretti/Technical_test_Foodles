def _top_n_frequencies_to_dict(sentence :str, n : int):
    """
    (i) we split the input sentence to get every word separtly 
    (ii) for each unique word, we count the number of time it appears (frequence)
    (iii) we sorted the list using the frequence and the word and we put it in the good format 

    Args:
        sentence (str): input sentence with words
        n (int): number minimal of frequence to be return 

    Returns:
        list : output of the word with the frequence (more than n)
    """
    words = sentence.split()
    freq = {}
    for w in words:
        freq[w] = freq.get(w, 0) + 1
    
    sorted_freq = sorted(freq.items(), key=lambda x: -x[1])
    return sorted_freq[:n]

print(
    _top_n_frequencies_to_dict(
    sentence="baz bar foo foo zblah zblah zblah baz toto bar",
    n=3
    )
)

