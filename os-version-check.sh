#OS upgrade:
#!/bin/bash 
for server in `cat server.txt` 
	do echo -e '\n' '\n' '\n' '#####'
echo "making new server: $server',' | tr -d '\n' | tee -a update-output.csv
echo -e '\n' '================================'
sleep 1
ssh root@$server 'mkdir /etc/yum.repos.d/old-repos/;rm /etc/yum.repos.d/rhel-debuginfo.repo /etc/yum.repos.d/rhel-source.repo; mv /etc/yum.repos.d/soe* /etc/yum.repos.d/old-repos/'
scp /home/cldadmin/biraj/5.9-repos/* root@$server:/etc/yum.repos.d/
ssh root@$server "yum install yum-kmod -y"
ssh root@$server "yum -y --skip-broken --disablerepo="*" --enablerepo="soe*" --exclude=glibc* update; /opt/rinfo/bin/rinfosend;
echo -e '\n' >> update-output.csv
echo "just finished server: $server, it has now new version:
ssh root@$server cat /etc/redhat-release | tee -a update-output.csv;sleep2; done

#OS ver check:
for loop same as above
inside do
echo  $server ',' | tr -d '\n' | tee -a output.csv'
ssh root@$server 'cat /etc/redhat-release' 2>/dev/null | cut -d '\n' | tee -a output.csv;
ssh root@$server df -h  | grep sda2 | awk '{print "," $4, "," $5}' | tee -a output.csv
echo -e '\n' >> output.csv
done

