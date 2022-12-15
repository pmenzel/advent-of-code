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

int n_sensors = 28;
sensor sensors[28] = {
{1024246,3626229,1884119},
{1897626,7510,1479061},
{2546325,2012887,1449906},
{178,2765639,1417811},
{3937091,2143160,1386603},
{3328074,1273456,1314559},
{2650614,595151,1313714},
{3924022,634379,1191740},
{1442554,1608100,1182104},
{1405010,486446,922823},
{433246,1337298,881806},
{2935977,2838245,815596},
{3778742,2914974,773138},
{2852855,3976978,720727},
{193758,2220950,679542},
{151527,640680,662846},
{803094,813675,648136},
{3896022,3773818,632902},
{268657,162438,537538},
{3505386,3962087,430535},
{819467,239010,406764},
{3138934,3439134,390828},
{3491072,3408908,310160},
{3502942,6438,142719},
{3328398,3645875,85919},
{3369963,3641076,43117},
{3386231,3635056,20829},
{3395706,3633894,10192}
};


struct ThreadData {
	int start, stop;
};


void* test_rows(void * data) {
	struct ThreadData *td = data;
	for(int x = td->start; x <= td-> stop; x++) {
		for(int y = 1; y <= 4000000; y++) {
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
	int n_threads = 8;
	struct ThreadData data[n_threads];
	pthread_t thread[n_threads];
	for (int i = 0; i < n_threads; i++) {
		data[i].start = 1 + 500000 * i;
		data[i].stop = (i+1) * 500000;
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

