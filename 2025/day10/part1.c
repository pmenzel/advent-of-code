#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>
#include <string.h>
#include <stdint.h>
#include <inttypes.h>

// gcc -Wall -Wconversion -O2 -g -ansi -pedantic -std=gnu99 part1.c -o part1

struct State
{
	uint32_t lights;
	uint32_t depth;
	struct State * next;
};


void queue_push(struct State **q_back, uint32_t lights, uint32_t depth) {
	if(q_back == NULL) {
		fprintf(stderr, "Queue back is NULL\n");
		exit(1);
	}
	//fprintf(stderr, "Adding %i with depth %i\n", lights, depth);
	struct State *new_el = (struct State *)malloc(sizeof(struct State));
	new_el->lights = lights;
	new_el->depth = depth;
	(*q_back)->next = new_el;
	*q_back = new_el;
}

int main(int argc, char **argv) {

	uint32_t length = 0;
	uint32_t target_lights = 0;
	uint32_t n_btns = 0;
	uint32_t to_read = 0;
	uint32_t *btns;
	uint32_t x;
	uint32_t sum_of_depths = 0;

	while (fread(&x, sizeof x, 1, stdin) == 1) {
		if(x == 0) {
			// do the actual BFS
			struct State *q_head = (struct State *)malloc(sizeof(struct State));
			struct State *q_back = q_head;
			q_head->lights = 0;
			q_head->depth = 0;
			q_head->next = q_head;
			uint32_t final_depth = 0;
			while(1) {
				//fprintf(stderr, "Evaluating %i against %i\n", q_head->lights, target_lights);
				if(q_head->lights == target_lights) {
					final_depth = q_head->depth;
					//TODO: cleanup remaining queue
					break;
				}
				// process State in queue head
				for(int i = 0; i < n_btns; i++) {
					// add q_head lights xor btn to queue
					//fprintf(stderr,"%i ^ %i\n", q_head->lights, btns[i]);
					queue_push(&q_back, q_head->lights ^ btns[i], q_head->depth + 1);
				}
				// remove queue head
				struct State *next = q_head->next;
				free(q_head);
				q_head = next;
			}
			printf("final depth = %i\n", final_depth);
			sum_of_depths += final_depth;

			length = 0;
			target_lights = 0;
			to_read = 0;
			n_btns = 0;
			continue;
		}
		if(length == 0) {
			length = x;
			fprintf(stderr, "Assigning length %d\n", length);
			continue;
		}
		if(target_lights == 0) {
			target_lights = x;
			fprintf(stderr, "Assigning target_lights %d\n", target_lights);
			continue;
		}
		if(n_btns == 0) {
			n_btns = x;
			fprintf(stderr, "Assigning n_btns %d\n", n_btns);
			to_read = x;
			btns = malloc(sizeof(uint32_t));
			btns = (uint32_t *)malloc(sizeof(uint32_t) * x);
			continue;
		}
		if(to_read > 0) {
			btns[n_btns - to_read] = x;
			fprintf(stderr, "Assigning btn %i = %d\n", n_btns - to_read, x);
			to_read--;
		}
	}

	printf("sum of button presses = %i\n", sum_of_depths);
}
