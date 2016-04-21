
#' to train text data
#'
#' @param layer1_size feature size
#' @param train_file training text data
#' @param save_vocab_file file name to save vocab data
#' @param read_vocab_file file name to read vocab
#' @param debug_mode debug mode
#' @param binary output file format
#' @param cbow training method used
#' @param alpha alpha
#' @param output_file output file name (MUST be binary)
#' @param window window
#' @param sample sample size
#' @param hs hs
#' @param negative negative
#' @param iter iter
#' @param min_count minimum count
#' @param num_threads number of threads
#' @param classes classes
#' @export
#' @examples
#' model=word2vec(train_file = "text8",output_file = "vec.bin",binary=1)
word2vec=function(layer1_size=0,train_file=0,save_vocab_file=0,read_vocab_file=0,
                  debug_mode=0,binary=1,cbow=0,alpha=0,output_file=0,window=0,
                  sample=0,hs=0,negative=0,iter=0,min_count=0,classes=0,num_threads=2)
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
           riter=as.character(iter),
           rmin_count=as.character(min_count),
           rclasses=as.character(classes),
           rnum_threads=as.character(num_threads)
           )
  class(OUT) <- "word2vec"
  names(OUT)[2] <- "model_file"
  OUT
}

#' Gets closest words to the searched word
#'
#' @param file_name trained data file name (MUST be binary)
#' @param search_word search keyword
#' @param num number of closest words
#' @return data frame giving closest words and cosine distances
#' @export
#' @examples
#' dist=distance("vec.bin","king",20)
distance=function(file_name,search_word,num=15)
{
  OUT=.C("distance",rfile_name=as.character(file_name),search_word=as.character(search_word),rN=as.integer(num),rbestw=as.character(rep("123",num)),rbestd=as.double(rep(0,num)))
  data=as.data.frame(cbind(OUT$rbestw,OUT$rbestd))
  colnames(data)=c("word","dist")
  data
}

#' Gets closest analogy to the searched word
#'
#' @param file_name trained data file name (MUST be binary)
#' @param search_words search keywords
#' @param num number of closest words
#' @return data frame giving closest analogy and cosine distances
#' @export
#' @examples
#' ana=word_analogy("vec.bin","king queen man",20)

word_analogy=function(file_name,search_words,num=20)
{
  OUT=.C("word_analogy",rfile_name=as.character(file_name),search_words=as.character(search_words),rN=as.integer(num),rbestw=as.character(rep("11",num)),rbestd=as.double(rep(0,num)))
  data=as.data.frame(cbind(OUT$rbestw,OUT$rbestd))
  colnames(data)=c("word","dist")
  data
}

#' to convert words to phrases
#'
#' @param train_file train file name
#' @param output_file output file name
#' @param debug_mode debug mode
#' @param min_count minimum count
#' @param threshold threshold value
#' @return data frame giving closest analogy and cosine distances
#' @export
#' @examples
#' model=word2phrase("text8","vec.txt")
word2phrase=function(train_file,output_file,debug_mode=0,min_count=0,threshold=0)
{
  OUT=.C("word2phrase",rtrain_file=as.character(train_file),rdebug_mode=as.integer(debug_mode),routput_file=as.character(output_file),rmin_count=as.integer(min_count),rthreshold=as.double(threshold))
  class(OUT) <- "word2vec"
  names(OUT)[2] <- "model_file"
  OUT
}

#' to convert binary file to text file
#'
#' @param bin_file binary file name
#' @param txt_file text file name
#' @return text file giving text file
#' @export
#' @examples
#' bin_to_txt("binary_name.bin","txt_name.bin")
bin_to_txt=function(bin_file,txt_file)
{
  d=.C("bin_to_txt",rfile_name=as.character(bin_file),routput_file=as.character(txt_file))
  d
}
