#include <brdkSTR_func.h>

signed long brdkStrSearch(unsigned long pString, unsigned long pSearchString) {
	signed long pos=-1, i=0,j=0, len1 = brdkStrLen(pString), len2 = brdkStrLen(pSearchString);
	
	if(len1>len2) {
		for(i=0; i <= len1-len2; i++) {
			j=0;
			if(((char*)pString)[i] == ((char*)pSearchString)[j]) {	
				while(((char*)pString)[i+j] == ((char*)pSearchString)[j]) {
					j++;
					if(j==len2) {
						pos = i;
						i=len1-len2+1;
						break;
					}
				}
			}
		}
	}
	return pos;
}
