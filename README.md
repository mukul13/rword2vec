# rword2vec
R wrapper to google's word2vec and GloVe
The word2vec tool takes a text corpus as input and produces the word vectors as output. It first constructs a vocabulary from the training text data and then learns vector representation of words. 

### Examples
To download sample text data, click [here](http://mattmahoney.net/dc/text8.zip -O text8.gz).

To install rowrd2vec package
```R
library(devtools)
install_github("mukul13/rword2vec")
```

To train text data to give word vectors
```R
model=word2vec(train_file = "text8",output_file = "vec.bin",binary=1)
```

To get closest words
```R
### file_name must be binary
dist=distance(file_name = "vec.bin",search_word = "king",num = 20)
```

To get analogy or to observe strong regularities in the word vector space
```R
### file name must be binary
ana=word_analogy(file_name = "vec.bin",search_words = "king queen man",num = 20)
```
To convert words to phrases
```R
word2phrase(train_file = "text8",output_file = "vec.txt")

### use this new text file to give word vectors
model=word2vec(train_file = "vec.txt",output_file = "vec2.bin",binary=1)
```

To do word count
```R
### to count word occurences in input file
vocab_count("text8","vocab.txt",min_count = 20)
```

### Resources
* [word2vec](https://code.google.com/archive/p/word2vec/) 
