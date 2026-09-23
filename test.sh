#!/bin/bash

USERNAME="affan"
EXPIRY_DATE=$(sudo chage -l "$USERNAME" | grep "Account expires" | cut -d ':' -f 2 | xargs)
EXPIRY_TIMESTAMP=$(date -d "$EXPIRY_DATE" +%s)
CURRENT_TIMESTAMP=$(date +%s)

if [ "$CURRENT_TIMESTAMP" -ge "$EXPIRY_TIMESTAMP" ]; then
	echo "Account $USERNAME has expired. Deleting user..."
	echo "Would delete: $USERNAME"
	userdel -r "$USERNAME"
else
echo "Account $USERNAME has not expired."
fi
