# PISO ESCENARIO 2
Case 1:

Radius server / Active Directory Laptop 0 

Case 2:

In the User Management challenge lab, you were tasked with creating users and groups.  Using the commands one at a time from the command line can be a tedious process and could lead to potential errorsin syntax.  It is yourduty, as an administrator, to make the process as seamless and efficient as possible.  

  Objetives:

Create a bash script to perform user management tasks as outlined below:
 -> Create a new group.  Each group must have a unique name.  The script must check to ensure that no duplicate group names exist on the system.  If a duplicate is  
  found, an error needs to be reported, and the administrator must try another group name.
 -> Create a new user.  Each user must have a unique name.  The script must check to ensure that no duplicate usernames exist on the system.  If a duplicate is 
  found, an error needs to be reported and the administrator must try another username.  The user will have a Bash login shell and belong to the group that was 
  created in the previous step. 
 -> Create a password for each user that is created.  
 -> Ensure that the new user created is a member of the new group created.
 -> Create a directory at the root (/) of the file system with same name as the user created. 
 -> Set the ownership of the directory to the user and group created.
 -> Set the permissions of the directory to full control for the owner and full control for the group created. 
 -> Set the permission to ensure that only the owner of a file can delete it from the directory. 
 -> Ensure that the script is executable. 
 
 Case 3:
 
There has been suspicious activity on the system.  In order to preserve log information, it will be necessary to archive the current files in /var/logending with
the ".log" extension.  The files are to be saved to a file named log.tar,stored in the directory, ~/archive.  

It has also been requested that the files that were archived be saved to a directory, ~/backup. 

   Objetives:
   
  -> Create an archive named log.tarthat isstored in the archive directory located in the home directory.
  -> Remove path names from the files that are archived.
  -> Produce verbose output while archiving.
  -> List the contents of the archive without extracting.
  -> Extract the files to the directory, ~/backup.
