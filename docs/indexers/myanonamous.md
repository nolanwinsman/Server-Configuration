# MyAnonaMouse Setup

## Get Invited to Group

## Dynamic Seedbox Setup


enter `/bin/sh` for the qbittorrent container

```sh
docker exec -it qbittorrent /bin/sh
```

Get container IP

```sh
curl https://www.myanonamouse.net/myip.php
```

You should see the seedbox IP address from the webpage.

1. On MAM menu above go to YOUR NAME > Preferences > Security
2. There create a new session with your Seedbox Ip and click "switch to ASN" and then click "Allow session to set dynamic seedbox IP." Note: I am unsure if "switch to ASN" is necessary, but it seemed to work for me
3. Copied the "View ASN locked session cookie" (it's changed from after clicking submit in step 2) 
4. Now open seedbox via ssh (or webmin). 
5. In the console of the seedbox inside the qbittorrent container enter:

enter `/bin/sh` for the qbittorrent container

```sh
docker exec -it qbittorrent /bin/sh
```

I created a few directories inside my config folder to store the cookies, cron logs and curl script

```sh
mkdir config/scripts/
mkdir config/scripts/cron_logs/
mkdir config/cookies/
```

input the command with your session_cookie from step 3.

Note the path `/config/cookies/mam.cookies` this is where I stored my cookie file inside the container. You can put it wherever you want just remember where it's stored.

```sh
sudo curl -c /config/cookies/mam.cookies -b 'mam_id=IP_session_cookie' https://t.myanonamouse.net/json/dynamicSeedbox.php
```

Next I created the curl script to be run every hour. You can change it to be whatever interval you want but the guide uses every hour so I'm sticking with it

```sh

```

```sh
vi /config/scripts/mam.sh
```

enter the following cript into `mam.sh`

```sh
#!/bin/sh
curl -c /config/cookies/mam.cookies -b /config/cookies/mam.cookies https://t.myanonamouse.net/json/dynamicSeedbox.php
```

Save and quit vi. Make the script executable

```sh
chmod +x /config/scripts/mam.sh
```

Before creating the cronjob, test the command before entering it into cron

```sh
/bin/sh /config/scripts/mam.sh >> /config/scripts/cron_logs/mam.log 2>&1
```

Create the cronjob

```sh
crontab -e
```

input this information into crontab

```sh
# MAM script to run every hour
0 * * * * /bin/sh /config/scripts/mam.sh >> /config/scripts/cron_logs/mam.log 2>&1
```

Ensure crond daemon is running

```sh
crond -f &
```

After you save and quit crontab, myanonamouse should be completely setup.


## Alternative script

If you want a better shell script to run on crond, you can try the below script from a MAM user. I have not yet used this script so I cannot say it works.

```sh
#!/bin/sh

# Comment out the next line once things are working, this enables logging
# commands as they are run.
set -x

# The directory to store the two state files - /config is a docker standard
MAMID=__LONGSTRING__
STATEDIR=/config
CACHEFILE=${STATEDIR}/MAM.ip
COOKIEFILE=${STATEDIR}/MAM.cookie

OLDIP=`cat $CACHEFILE`

# Use ip.me to look up the current IP address. The MAM test URL is below in
# case the ip.me option fails.
NEWIP=`curl -s ip4.me/api/ | md5sum - | awk '{print $1}'`
# NEWIP=`curl -s https://www.myanonamouse.net/myip.php | md5sum - | awk '{print $1}'`

# Check to see if the IP address has changed
if [ "${OLDIP}" != "${NEWIP}" ]
then
  echo New IP detected
  # Marker 1 : First run
  curl -s -b "mam_id=$MAMID" -c $COOKIEFILE https://t.myanonamouse.net/json/dynamicSeedbox.php | grep '"Success":true'
  # Marker 2 : Repeat executions
  # curl -s -b $COOKIEFILE -c $COOKIEFILE https://t.myanonamouse.net/json/dynamicSeedbox.php | grep '"Success":true'
  # Marker 3 : End of curl commands

  # If that command worked, and we therefore got the success message
  # from MAM, update the CACHEFILE for the next execution
  if [ $? -eq 0 ]
  then
    echo $NEWIP > $CACHEFILE
  fi
fi
```