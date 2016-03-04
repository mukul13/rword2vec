#' Gets word count from the text data 
#'
#' @param file_name text data
#' @param vocab_file output vocab count file name
#' @param max_vocab maximum vocab
#' @para verbose verbose 0,1 or 2)
#' @param min_count minimum occurrence of word
#' @return data frame giving word count
#' @export
#' @examples
#' data=vocab_count("text8","vocab.txt")

vocab_count=function(file_name,vocab_file,verbose=2,max_vocab=0,min_count=1)
{
  OUT=.C("vocab_count",rfile_name=as.character(file_name),rvocab_file=as.character(vocab_file),verbose=as.integer(verbose),rmax_vocab=as.integer(max_vocab),rmin_count=as.integer(min_count))
  class(OUT) <- "word2vec"
  names(OUT)[2] <- "model_file"
  OUT
}