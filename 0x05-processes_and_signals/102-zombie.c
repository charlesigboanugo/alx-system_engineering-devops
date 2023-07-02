#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

/**
 * infinite_while - loops infinitely
 *
 * Return: should not return, but 0 if it does somehow
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - creates some zombie processes then sleeps 2 seconds forever
 *
 * Return: 0 if child process. parent should not return.
 */
int main(void)
{
	int pid, ct;

	for (ct = 0; ct < 5; ct++)
	{
		pid = fork();
		if (pid != 0)
		{
			printf("Zombie process created, PID: %d\n", pid);
		}
		else
			return (0);
	}
	infinite_while();
	return (0);
}
