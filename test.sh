#!/bin/bash

USERNAME=$(getent passwd | awk -F: '$3 >= 1000 && $3 < 65534{print $1}')

for USER in $USERNAME; do

	EXPIRY_DATE=$(sudo chage -l "$USERNAME" | grep "Account expires" | cut -d ':' -f 2 | xargs)

	if [ "$EXPIRY_DATE" = "never"]; then
		continue
	fi 
	
	EXPIRY_TIMESTAMP=$(date -d "$EXPIRY_DATE" +%s)
	CURRENT_TIMESTAMP=$(date +%s)

	if [ "$CURRENT_TIMESTAMP" -ge "$EXPIRY_TIMESTAMP" ]; then
		echo "Account $USERNAME has expired. Deleting user..."
		echo "Would delete: $USERNAME"
		#userdel -r "$USERNAME"
	else
		echo "Account $USERNAME has not expired."
	fi
done
