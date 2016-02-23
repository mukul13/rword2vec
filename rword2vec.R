setwd("/home/mukul/Desktop/Mukul Backup/deep learning/word2vec")

dyn.load("word2vec.so")

word2vec=function(layer1_size=0,train_file=0,save_vocab_file=0,read_vocab_file=0,
                  debug_mode=0,binary=1,cbow=0,alpha=0,output_file=0,window=0,
                  sample=0,hs=0,negative=0, num_threads=0,iter=0,min_count=0,classes=0)
{
  OUT = .C("word2vec",rlayer1_size=as.character(layer1_size),
           rtrain_file=as.character(train_file),
           rsave_vocab_file=as.character(save_vocab_file),
           rread_vocab_file=as.character(read_vocab_file),
           rdebug_mode=as.character(debug_mode),
           rbinary=as.character(binary),
           rcbow=as.character(cbow),
           ralpha=as.character(alpha),
           routput_file=as.character(output_file),
           rwindow=as.character(window),
           rsample=as.character(sample),
           rhs=as.character(hs),
           rnegative=as.character(negative),
           rnum_threads=as.character(num_threads),
           riter=as.character(iter),
           rmin_count=as.character(min_count),
           rclasses=as.character(classes)
           )
  class(OUT) <- "word2vec"
  names(OUT)[2] <- "model_file"
  OUT
}


#model=word2vec(train_file = "text8",output_file = "vector.txt",binary=0)
model=word2vec(train_file = "text8",output_file = "vec.bin",binary=1)

dyn.load("distance.so")

distance=function(file_name,search_word,num=15)
{
  OUT=.C("distance",rfile_name=as.character(file_name),search_word=as.character(search_word),rN=as.integer(num),rbestw=as.character(rep("123",num)),rbestd=as.double(rep(0,num)))  
  as.data.frame(cbind(OUT$rbestw,OUT$rbestd))
}

dist=distance("vec.bin","king",20)

dyn.load("word_analogy.so")
word_analogy=function(file_name,search_words,num=20)
{
  OUT=.C("word_analogy",rfile_name=as.character(file_name),search_words=as.character(search_words),rN=as.integer(num),rbestw=as.character(rep("11",num)),rbestd=as.double(rep(0,num)))
  as.data.frame(cbind(OUT$rbestw,OUT$rbestd))
}

ana=word_analogy("vec.bin","king queen man",20)
