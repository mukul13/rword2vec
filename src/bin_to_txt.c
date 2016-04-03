#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
//#include <malloc.h>


void bin_to_txt(char **rfile_name,char **routput_file) {
  long long max_size = 2000;         // max length of strings
  long long max_w = 50;              // max length of vocabulary entries

  //long long N=20;
 // char st1[max_size];
  char file_name[max_size];
  float len;

  long long words, size, a, b;
  char ch;
  float *M;
  char *vocab;

   strcpy(file_name,*rfile_name);
  //printf("%s",file_name);
  FILE *f = fopen(file_name, "rb");
  FILE *fout =fopen(*routput_file,"wb");
  if (f == NULL) {
    printf("Input file not found\n");
    return ;
  }
  if(fscanf(f, "%lld", &words)==1) fprintf(fout,"%lld ",words);

  if(fscanf(f, "%lld", &size)==1)fprintf(fout,"%lld",size);
  
  vocab = (char *)malloc((long long)words * max_w * sizeof(char));
    M = (float *)malloc((long long)words * (long long)size * sizeof(float));
  if (M == NULL) {
    printf("Cannot allocate memory: %lld MB    %lld  %lld\n", (long long)words * size * sizeof(float) / 1048576, words, size);
    return ;
  }
  for (b = 0; b < words; b++) {
    a = 0;
    while (1) {
    //  printf("1");
      vocab[b * max_w + a] = fgetc(f);
      fprintf(fout,"%c",vocab[b * max_w + a]);
      if (feof(f) || (vocab[b * max_w + a] == ' ')) {
        
        break;}
      if ((a < max_w) && (vocab[b * max_w + a] != '\n')) 
        {
          a++;
        }
    }
    vocab[b * max_w + a] = 0;
    for (a = 0; a < size; a++) 
    {
      if(a==0)
      {
          if(fread(&M[a + b * size], sizeof(float), 1, f)==1)    fprintf(fout,"%f",M[a+b*size]);
      }
      else
      {
        if(fread(&M[a + b * size], sizeof(float), 1, f)==1)    fprintf(fout," %f",M[a+b*size]);
      }
    }

    len = 0;
    for (a = 0; a < size; a++) len += M[a + b * size] * M[a + b * size];
    len = sqrt(len);
    for (a = 0; a < size; a++) M[a + b * size] /= len;
  }
  fclose(f);
}
