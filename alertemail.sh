#!/bin/sh

 

################

# VARIABLES

################

EMAIL_LIST= name@com.com

SENDER=secalert@com.com

TMP_DIR=/tmp

TMP_FILE=${TMP_DIR}/tmp_mail.$$

#

# The first argument $1 is the alarm level of the Alert:

Severity_Level=$1

case ${Severity_Level} in

        0) ALARM_LVL="0 - Emergency";;

        1) ALARM_LVL="1 - Alert";;

        2) ALARM_LVL="2 - Critical";;

        3) ALARM_LVL="3 - Error";;

        4) ALARM_LVL="4 - Warning";;

    5) ALARM_LVL="5 - Notice";;

    6) ALARM_LVL="6 - Informational";;

    7) ALARM_LVL="7 - Debugging";;

esac

#

# The second argument $2 is the class of the Alert:

CLASS_ALARM=$2

#

# The thrid argument $3 is the title of the Alert:

TITLE_ALARM=$3

#

# Keep the relevent information from the message in $* :

echo $* > ${TMP_FILE}

MESSAGE_ALARM="`cut -d' ' -f3- ${TMP_FILE}`"

 

################

# MAIN

################

if [ ! -d ${TMP_DIR} ]

then

        mkdir -p ${TMP_DIR}

fi

(

echo "Event Type : ${CLASS_ALARM}"

echo "Severity Level : ${ALARM_LVL}"

echo ""

echo "Messages :"

echo "${MESSAGE_ALARM}"

echo ""

) | /bin/mailx -s "${TITLE_ALARM}" -r ${SENDER} ${EMAIL_LIST}

/bin/rm -f ${TMP_FILE}
