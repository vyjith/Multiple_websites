#! /bin/bash

w_root(){
if [ "$EUID" == 0 ]
then
        w_install
else
        echo ""
        echo "Please run this script on root privilege, plese switch the user to root using the sudo su -. Thank you"
        echo "I am exiting from here now"
        echo ""
        exit
fi
}
w_install(){
        echo ""
        echo "Please let me know how many website you would like to host, please choose the below option now"
        echo "1) one website"
        echo "2) More than one websites"
        echo ""
read -p "Please choose the value (1|2): " Answer
case $Answer in
        1)
                echo "You have selected one website. Please hold a moment whle creating one webiste for you"
                w_install_httpd
                w_onewebsite
        ;;
        2)      w_install_httpd
                echo -n "Please let me know how many website you would like to host: "
                read y
                x=1
                while [ $x -le $y ]
                do
                        w_morethanwebsites
                        x=$(( $x +1 ))
                done
        ;;
        *)
                echo "You have entered invalid option"
        ;;
esac
}

w_install_httpd(){
echo "Installing httpd service"
        yum install httpd -y
        service httpd restart
echo ""
}

w_onewebsite(){
echo ""
echo "Please enter the website name"
echo ""
read -p "NOTE: Use lowercase letter and don't use symbols like($,/,*,&,......):" domainone
mkdir -p /var/www/html/$domainone
cat > /var/www/html/$domainone/index.html << EOF
Hello World!
EOF
echo ""
echo "We are preparing for you and thank you for your patience"
echo ""
cat > /etc/httpd/conf.d/$domainone.conf << EOF
<VirtualHost *:80>
DocumentRoot /var/www/html/$domainone
ServerName $domainone
ServerAlias $domainone
</VirtualHost>
EOF
echo ""
echo "Restart httpd service and you can check the website on this URL: http://$domainone after adding the hosts file on your local machine"
service httpd restart
echo ""
echo "The  website is ready and please visit the URL : http://$domainone"
echo ""
}

w_morethanwebsites(){
echo ""
echo "Please enter the "$x" website name"
echo ""
read -p "NOTE: Use lowercase letter and don't use symbols like($,/,*,&,......):" domainone
mkdir -p /var/www/html/$domainone
cat > /var/www/html/$domainone/index.html << EOF
Hello World!
EOF
echo ""
echo "We are preparing for you and thank you for your patience"
echo ""
cat > /etc/httpd/conf.d/$domainone.conf << EOF
<VirtualHost *:80>
DocumentRoot /var/www/html/$domainone
ServerName $domainone
ServerAlias $domainone
</VirtualHost>
EOF
echo ""
echo "Restart httpd service and you can check the website on this URL: http://$domainone after adding the hosts file on your local machine"
service httpd restart
echo ""
echo "The  website is ready and please visit the URL : http://$domainone"
echo ""
}

w_main(){
        w_root
}
w_main
exit
