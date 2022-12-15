#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>
#include <string.h>
#include <pthread.h>


typedef struct
{
    int x;
    int y;
    int d;
} sensor;

int n_sensors = 14;
sensor sensors[14] = {
{2,0,10},
{8,7,9},
{20,14,8},
{20,1,7},
{2,18,7},
{17,20,6},
{16,7,5},
{14,17,5},
{12,14,4},
{10,20,4},
{0,11,3},
{13,2,3},
{14,3,1},
{9,16,1}
};


struct ThreadData {
	int start, stop;
	int thread_nr;
};


void* test_rows(void * data) {
	struct ThreadData *td = data;
	for(int x = td->start; x <= td-> stop; x++) {
		printf("Thread %i doing x = %i\n", td->thread_nr, x);
		for(int y = 1; y <= 20; y++) {
			int found = 0;
			for(int s = 0; s < n_sensors; s++) {
				// dist to sensor
				int dd = abs(x - sensors[s].x) + abs(y - sensors[s].y);
				//printf("Checking %i,%i with distance %i\n", x, y, dd);
				if(dd <= sensors[s].d) {
					//printf("Point %i,%i is covered by sensor %i\n", x, y, s);
					found = 1;
					break;
				}
			}
			if(found==0) {
				printf("x=%i y=%i\n", x, y);
				exit(0);
			}
		}
	}
	return NULL;
}

int main(int argc, char **argv) {
	int n_threads = 5;
	struct ThreadData data[n_threads];
	pthread_t thread[n_threads];
	for (int i = 0; i < n_threads; i++) {
		data[i].start = 1 + 4 * i;
		data[i].stop = (i+1) * 4;
		data[i].thread_nr = i;
	}

	/* Launch Threads */
	for (int i=0; i<n_threads; i++) {
		pthread_create(&thread[i], NULL, test_rows, &data[i]);
	}

	/* Wait for Threads to Finish */
	for (int i=0; i<n_threads; i++) {
		pthread_join(thread[i], NULL);
	}

}

