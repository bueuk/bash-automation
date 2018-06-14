#!/bin/bash

DB="nantes_db"
EMAIL="your_email@testing123.xxx"
BACKUP_PATH="/backup/dbbackup"  
LOG_PATH="/root/bin/log_backup_db_per_day"  
TGL=`/bin/date +"%d-%m-%y"`  
if [[ "$?" != "0" ]]; then  
TGL="UNKNOWN_DATE"  
fi

#Backup db nya dan note error na mun aya error berdasarkan tanggal proses backup dilakukan
mysqldump --single-transaction -u root $DB > $BACKUP_PATH/$DB-$TGL.sql 2> $LOG_PATH/log-backup-$TGL.log

#############################################################################
#***NOTE 1:
#Jika log backup value nya 0, berarti tidak ada error dalam proses backup DB#
#Bisi poho
###################################END NOTE 1##########################################

###################
#***NOTE 2:
#Jika ada error
##################################################
if [[ "$?" != "0" ]]; then  
#maka hapus file .sql yang gagal dibackup tersebut
rm -f $BACKUP_PATH/$DB-$TGL.sql  
#################################################

#kemudian krim email kalo backup gagal dan kirim error na
mail -s "Database backup failed om" email@namadomain.com<<EOF  
$(cat $LOG_PATH/log-backup-$TGL.log)
EOF  
#######################################END NOTE 2#############################################

###################################################################################################
#***NOTE 3:
#Kalo sudah dipastikan tidak ada error dan backup db sukses
#maka langsung di zip file .sql dan hapus file .sql yg belum di zip tersebut untuk menghemat space#
#######################################END NOTE 3############################################################
else  
zip $BACKUP_PATH/$DB-$TGL.zip $BACKUP_PATH/$DB-$TGL.sql  
rm -f $BACKUP_PATH/$DB-$TGL.sql

mail -s "Database backup SUCCESS" $EMAIL <<EOF
$(cat $LOG_PATH/log-backup-$TGL.log)
$(du -sch $BACKUP_PATH/$DB-$TGL.zip)
EOF

fi
