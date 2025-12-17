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
	uint32_t * joltages;
	uint32_t depth;
	struct State * next;
};


void queue_push(struct State **q_back, uint32_t n_joltages,	uint32_t *prev_joltages, uint32_t *target_joltages, uint32_t btn, uint32_t depth) {
	if(q_back == NULL) {
		fprintf(stderr, "Queue back is NULL\n");
		exit(1);
	}
	uint32_t *new_joltages = (uint32_t *)malloc(sizeof(uint32_t) * n_joltages);
	for(uint32_t i = 0; i < n_joltages; i++) {
		new_joltages[i] = prev_joltages[i];
		// add btn to joltages if it affects joltage i
		if(((1u << i) & btn) != 0) {
			// test if the joltage already exceeds the target joltage, then do not add to queue.
			if(new_joltages[i] + 1 > target_joltages[i]) {
				//fprintf(stderr, "Skipping btn %i\n", btn);
				free(new_joltages);
				return;
			}
			new_joltages[i] += 1;
		}
	}
	struct State *new_el = (struct State *)malloc(sizeof(struct State));
	new_el->next = NULL;
	new_el->joltages = new_joltages;
	/*
	fprintf(stderr, "Added btn %i to ", btn);
	for(uint32_t i = 0; i < n_joltages; i++) { fprintf(stderr, "%i,", prev_joltages[i]); }
	fprintf(stderr, " resulting in ");
	for(uint32_t i = 0; i < n_joltages; i++) { fprintf(stderr, "%i,", new_el->joltages[i]); }
	fprintf(stderr, " with depth %i\n", depth);
	*/
	new_el->depth = depth;
	(*q_back)->next = new_el;
	*q_back = new_el;
}

int main(int argc, char **argv) {

	uint32_t n_joltages = 0;
	uint32_t * target_joltages = NULL;
	uint32_t n_btns = 0;
	uint32_t *btns = NULL;
	uint32_t btns_to_read = 0;
	uint32_t joltages_to_read = 0;
	uint32_t x;
	uint32_t sum_of_depths = 0;

	while (fread(&x, sizeof x, 1, stdin) == 1) {
		if(x == 0) {
			// do the actual BFS
			struct State *q_head = (struct State *)malloc(sizeof(struct State));
			struct State *q_back = q_head;
			q_head->joltages = (uint32_t *)malloc(sizeof(uint32_t) * n_joltages);
			for(int i = 0; i < n_joltages; i++) { q_head->joltages[i] = 0; }
			q_head->depth = 0;
			q_head->next = NULL;
			uint32_t final_depth = 0;
			while(1) {
				/*
				fprintf(stderr, "Evaluating ");
				for(uint32_t i = 0; i < n_joltages; i++) { fprintf(stderr, "%i,", q_head->joltages[i]); }
				fprintf(stderr, " against target ");
				for(uint32_t i = 0; i < n_joltages; i++) { fprintf(stderr, "%i,", target_joltages[i]); }
				fprintf(stderr, "\n");
				*/
				if(memcmp(q_head->joltages, target_joltages, n_joltages * sizeof(uint32_t)) == 0) {
					//printf("found!!!!\n");
					final_depth = q_head->depth;
					// cleanup remaining queue
					while(q_head->next != NULL) {
						struct State *tmp = q_head;
						q_head = q_head->next;
						free(tmp->joltages);
						free(tmp);
					}
					free(q_head->joltages);
					free(q_head);
					break;
				}
				// process State in queue head
				for(int i = 0; i < n_btns; i++) {
					queue_push(&q_back, n_joltages, q_head->joltages, target_joltages, btns[i], q_head->depth + 1);
				}
				// remove queue head
				struct State *next = q_head->next;
				free(q_head->joltages);
				free(q_head);
				q_head = next;
			}
			printf("final depth = %i\n", final_depth);
			sum_of_depths += final_depth;

			n_joltages = 0;
			free(target_joltages);
			free(btns);
			btns_to_read = 0;
			joltages_to_read = 0;
			n_btns = 0;
			continue;
		}

		if(n_joltages == 0) {
			n_joltages = x;
			fprintf(stderr, "n_joltages = %d\n", n_joltages);
			target_joltages = (uint32_t *)malloc(sizeof(uint32_t) * n_joltages);
			joltages_to_read = n_joltages;
			continue;
		}
		if(joltages_to_read > 0) {
			//target_joltages[n_joltages - joltages_to_read] = x;
			target_joltages[joltages_to_read - 1] = x;
			//fprintf(stderr, "target_joltages[%i] = %d\n", n_joltages - joltages_to_read, x);
			fprintf(stderr, "target_joltages[%i] = %d\n", joltages_to_read - 1, x);
			joltages_to_read--;
			continue;
		}
		if(n_btns == 0) {
			n_btns = x;
			fprintf(stderr, "n_btns %d\n", n_btns);
			btns_to_read = x;
			btns = (uint32_t *)malloc(sizeof(uint32_t) * x);
			continue;
		}
		if(btns_to_read > 0) {
			btns[n_btns - btns_to_read] = x;
			fprintf(stderr, "btn[%i] = %d\n", n_btns - btns_to_read, x);
			btns_to_read--;
			continue;
		}
	}

	printf("sum of button presses = %i\n", sum_of_depths);
}
