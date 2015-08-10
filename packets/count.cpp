#include <stdio.h> /* printf */
#include <ctype.h> //for isprint()
#include <stdlib.h>
#include <pcap.h> /* if this gives you an error try pcap/pcap.h */
#include <time.h> /* time_t, struct tm, difftime, time, mktime */

#include <iostream>
#include <fstream>
using namespace std; 

int g_argc;
char **g_argv;

void my_callback(u_char *tmr,const struct pcap_pkthdr* pkthdr,const u_char*
        packet){
    time_t *oldtimer = ( time_t *)tmr;
    time_t newtimer;
    double seconds;
    static int count = 1;

    time(&newtimer);
    seconds = difftime( newtimer, *oldtimer );
    count++;
    if( seconds > 300 ){
        //printf ( "%.f seconds elapsed\n" , seconds );
  	unsigned long int sec= time(NULL);
        //printf( "%lu %d\n", sec, count );

  	ofstream myfile;
  	myfile.open ( g_argv[1] );
  	myfile <<sec<<" "<<seconds<<" "<<count<<endl;
  	myfile.close();

	count = 1; // resets static variable!
	( *oldtimer ) = time( NULL ); 
    }
/*   printf( "This Packet Size: %d\n", pkthdr->len );
    for( size_t  i=0; i < pkthdr->len; i++ ){
	// size_t only because warning "comparison btw signed and unsiglned"
	if( isprint( packet[i] ) ) printf( "%c", packet[i] );
	else printf(". ");

	if( (i%16 == 0 && i!=0) || i==pkthdr->len-1 ) printf( "\n" );
    }*/
}

int main( int argc, char* argv[]){
   //cout << "argc = " << argc << endl;
   //for(int i = 0; i < argc; i++)
      //cout << "argv[" << i << "] = " << argv[i] << endl;
    g_argc = argc;
    g_argv = argv;

    //char dev[]="p4p1"; 
    char errbuf[PCAP_ERRBUF_SIZE];
    pcap_t* descr;
    time_t timer;

    descr = pcap_open_live( argv[1],BUFSIZ,0,1000,errbuf); // 1000 for less load
    //descr = pcap_open_live(dev,BUFSIZ,0,-1,errbuf);
	//BUFSIZ is defined in pcap.h

    if(descr == NULL)
    {
        printf("pcap_open_live(): %s\n",errbuf);
        exit(1);
    }

    time(&timer);
    pcap_loop(descr,-1,my_callback, ( u_char *)&timer );

    pcap_close(descr);
    return(0);
}
