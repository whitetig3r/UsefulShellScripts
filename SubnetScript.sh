#!/bin/bash
echo;echo;echo;
echo "-----A SUBNETTING COMMAND LINE TOOL------ "
echo;echo;echo;

function hostCalc {
   
   start=2
   hostloc=$(( $1 + 2 ))
 
   until [ $(( 2**start )) -ge $hostloc ]
    do 
          final=$(( start ++ ))
    done

    exp=$(( final+1 ))
    cidr=$(( 32-(( final+1 )) ))

   echo
   echo "PROCESSING............"
   echo 
   echo 
   echo
   echo "The CIDR value to be used is : /$cidr"
   echo 
   echo 


   if [ $cidr -ge 24 ]
   	then
   	 echo "The subnet mask is:";echo;
   	 echo "255.255.255.$(( 256-$(( 2**exp )) )) "
   	 echo
   	 echo "The effective number of subnets is:"
   	 echo
   	 subnets=$(( 2**$((cidr%8)) ))
   	 echo $subnets
   elif [ $cidr -ge 16 ] && [ $cidr -lt 24  ]
   	then
   	 exp=$((exp%8))
   	 echo "The subnet mask is";echo;
   	 echo "255.255.$(( 256-$(( 2**exp )) )).0"
   	 echo
   	 echo "The effective number of subnets is:"
   	 echo
   	 subnets=$(( 2**$((cidr%8)) ))
   	 echo $subnets
   elif [ $cidr -ge 8 ] && [ $cidr -lt 16 ]
   	then
   	 exp=$((exp%8))
   	 echo "The subnet mask is";echo;
   	 echo "255.$(( 256-$(( 2**exp )) )).0.0"
   	 echo
   	 echo "The effective number of subnets is:"
   	 echo
   	 subnets=$(( 2**$((cidr%8)) ))
   	 echo $subnets;
   fi
  echo
}

function driver {
    
   echo
   echo "Enter the number of hosts you wish to have per subnet! "
   echo
   read hosts
   hostCalc $hosts
}

driver