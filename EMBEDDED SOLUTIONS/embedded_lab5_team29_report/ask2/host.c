#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    int fd;
    char in[66], out[66];
    struct termios config;
    ssize_t r;
    char device[] = "/dev/pts/2";

    printf("Please give a string to send to guest:\n");
    r = read(0, in, 66);
    if (r<0){
        perror("read");
  		exit(1);
    }
    if (r == 66) {
  		fprintf(stderr, "String must have at most 64 characters! Try again.\n");
        fflush(0);
  		exit(1);
  	}

    fd = open(device, O_RDWR | O_NOCTTY);

    if (fd == -1) {
        printf("Error opening file\n");
        return 1;
    }

// Get the current configuration of the serial interface
    if(tcgetattr(fd, &config) < 0) {
        printf("Configuration error\n");
        return 1;
    }

    config.c_lflag = 0;
    config.c_lflag |= ICANON; // canonical mode
    config.c_cflag |= (CLOCAL | CREAD | CS8);
    config.c_cflag &= ~CSTOPB;
    config.c_cc[VMIN] = 1; // One input byte is enough to return from read()
    config.c_cc[VTIME] = 0; // Inter-character timer off


// Communication speed (simple version, using the predefined
// constants)
    if(cfsetispeed(&config, B9600) < 0 || cfsetospeed(&config, B9600) < 0) {
        printf("Baudrate error\n");
        return 1;
    }

// Finally, apply the configuration
    if(tcsetattr(fd, TCSANOW, &config) < 0) {
        printf("Error with settings\n");
        return 1;
    }

    tcflush(fd, TCIOFLUSH); // flush buffer
    printf("Sending message...\n");
    write(fd, in, 66); // send string
    printf("Getting results...\n");
    read(fd, out, 66); // get results

//print them, don’t forget to subtract output[2] by 48, char->int
    if(out[2]-'0'!=0)
      printf("The most frequent character is %c and it appeared %d times.\n", out[0], out[2]-'0');
    else
      printf("Nothing was written\n");

    close(fd);
    return 0;
}
