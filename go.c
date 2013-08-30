/* Run shell script in ~/bin as root without need to enter sudo password */

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[])
{
   /* Set effective user id of the process as root */
   setuid( 0 );

   char path[50] = "/home/ppai/bin/";
   char command[20];
   struct stat sb;

   if ( argc != 2 )
      goto err;

   strcpy (command, argv[1]);
   strcat (path, command);

   /* Check if file exists and is executable */
   if ( !(stat(path, &sb) == 0 && sb.st_mode & S_IXUSR) )
      goto err;

   printf ("Running %s as root...\n\n", path);
   system (path);
   return 0;

err :
   printf ("error\n");
   return 1;
}
