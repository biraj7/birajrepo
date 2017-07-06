#!/bin/bash
echo "Enter a DC no."
read dc
echo "Enter a Pod no."
read pod
echo "Enter a VPC no."
read vpc
ssh root@d${dc}p${pod}v${vpc}mgmt-dr2c << EOF
mkdir -p /opt/vmware/hms/support/HMS-old-logs
/bin/mv /opt/vmware/hms/support/HSB* /opt/vmware/hms/support/HMS-old-logs/
/opt/vmware/hms/bin/generatesupportbundle.sh
/bin/tar -cvzf /opt/vmware/hms/support/vCA-HMS-bundle.tar.gz /opt/vmware/hms/support/HSB-*
echo "Please wait 40 seconds...."
sleep 40
EOF
echo "Completed on: d${dc}p${pod}v${vpc}mgmt-dr2c"
echo "-----------------------------------------------------------------------"
echo "Now copying to jump"
sleep 2
function copy-to-jump
{
        echo "Enter dr2c server name"
        read server
        scp root@${server}:/opt/vmware/hms/support/vCA-HMS-bundle.tar.gz ./${server}.tar.gz
        echo "DR2C logs are copied to the current linjump path."
}
copy-to-jump
