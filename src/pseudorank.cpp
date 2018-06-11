#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
Rcpp::NumericVector psrank(Rcpp::NumericVector &data, Rcpp::NumericVector &group, Rcpp::NumericVector &n) {
  
  double N = data.length();
  double ngroups = n.length();
  Rcpp::NumericVector result(N);
  Rcpp::NumericVector result_ties(N);
  
  // Calculate the first pseudo-rank
  int index = group[0];
  result[0] = N/ngroups*1/n[index-1]*1/2 + 0.5;

  // define the matrix for the differences between the pseudo-ranks
  NumericMatrix delta(ngroups, ngroups);
  for(int i = 0; i < ngroups; i++){
    for(int j = i; j < ngroups; j++){
      delta(i,j) = N/ngroups*0.5*(1/n[i]+1/n[j]);
      delta(j,i) = delta(i,j);
    }
  }
  
  int i1 = 0;
  int i2 = 0;
  
  // Case: no ties
  for(int i = 1; i < N; i++){
    i1 = group[i]-1;
    i2 = group[i-1]-1;
    result[i] = result[i-1] + delta(i1, i2);       
  }
  
  double add = 0;
  int j = 0;
  //result_ties = clone(result);
  
  // Case: ties in the data
  for(int i = 0; i < N; i++){
    
    result_ties[i] = result[i];
    
    if(data[i] == data[i+1]) {
      add = 0;
      j = i + 1;
      // sum up the incremental factor for ties
      while(data[i] == data[j]){
        index = group[j];
        add += 1/n[index-1];
        j++;
        if(j == N) {
          break;
        }
      }
      for(int k = i; k < j; k++){
        // we need to distinguish between i > 0 and i == 0, otherwise result[i-1] not defined
        if(i > 0) {
          i1 = group[i]-1;
          i2 = group[i-1]-1;
          result_ties[k] = result[i-1] + delta(i1, i2) + N/ngroups*0.5*add; // 'mid'-pseudo-ranks
        }
        else {
          result_ties[k] = result[0] +  N/ngroups*0.5*add; // 'mid'-pseudo-ranks
        }
      }
      // resume for loop where last block of ties ended
      i = j-1;
      if(i == N - 1) {
        break;
      }
    }
  }
  
  
  return result_ties;
}
