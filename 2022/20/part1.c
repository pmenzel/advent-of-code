#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>
#include <string.h>


struct Number
{
    int original_order;
    int value;
    struct Number *next;
    struct Number *prev;
};

void print_list(struct Number *start) {
	struct Number *first = start;
	printf("-------------------------\n");
		do{
			printf("%i %i\n", start->value, start->original_order);
			start = start->next;
		} while (start != first) ;
}

void print_Number_info(struct Number *n) {
	printf("Info for number with value %i and original order %i\n", n->value, n->original_order);
	printf("  Next number has value %i and original order %i\n", n->next->value, n->next->original_order);
	printf("  Prev number has value %i and original order %i\n", n->prev->value, n->prev->original_order);

}

int main(int argc, char **argv) {

	int num;
	int c = 1;
	struct Number *first = NULL;
	struct Number *last = NULL;
	struct Number *prev = NULL;
	struct Number *number_zero = NULL;
	struct Number *n = NULL;

	while (scanf("%d", &num) == 1) {
		//printf("Read number %i: %d\n", c, num);
		n = malloc(sizeof(struct Number));
		n->value = num;
		n->original_order = c++;
		if(first == NULL) {
			first = n;
		}
		if(prev != NULL) {
			prev->next = n;
			n->prev = prev;
		}
		prev = n;
		if(num == 0) {
			number_zero = n;
		}
	}
	last = n;
	last->next = first;
	first->prev = last;
//	print_list(first);

	while(1) {

		struct Number *next_Number = NULL;
		int lowest_order = 100000;
		struct Number *curr = first;
		do {
			if(curr->original_order < lowest_order) {
				next_Number = curr;
				lowest_order = curr->original_order;
			}
			curr = curr->next;
		} while (curr != first);
		if(lowest_order >= 100000) break;

		//print_Number_info(next_Number);

		next_Number->original_order = 100000 + abs(next_Number->original_order);
		if(next_Number->value != 0) {
			// move Number around
			// splice out next_Numer from current position
			next_Number->prev->next = next_Number->next;
			next_Number->next->prev = next_Number->prev;
			if(next_Number->value > 0) {
				struct Number *curr = next_Number;
				for(int i = 1; i <= next_Number->value; i++) {
					curr = curr->next;
				}
				//place next_Number after curr
				struct Number *old_curr_next = curr->next;
				curr->next->prev = next_Number;
				curr->next = next_Number;
				next_Number->next = old_curr_next;
				next_Number->prev = curr;
			}
			else {
				struct Number *curr = next_Number;
				for(int i = next_Number->value; i <= 0; i++) {
					curr = curr->prev;
				}
				//place next_Number after curr
				struct Number *old_curr_next = curr->next;
				curr->next->prev = next_Number;
				curr->next = next_Number;
				next_Number->next = old_curr_next;
				next_Number->prev = curr;
			}
		}
		else {
			next_Number->original_order = 100000 ;
		}
		//printf("List after rearrangement:\n");
		//print_list(first);

	}

	// find sum of 1000th, 2000th, and 3000th numbers after the value 0

	struct Number *curr = number_zero;
	int sum = 0;
	for(int i = 1; i <= 3000; i++) {
		curr = curr->next;
		if(i % 1000 == 0) { sum += curr->value; }
	}
	printf("sum=%i", sum);


}

