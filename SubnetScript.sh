#!/bin/bash
echo;echo;echo; 
echo "-----A SUBNETTING COMMAND LINE TOOL------ "        
echo;echo;echo;

# function to calculate subnet mask based on host requirement
function hostCalc {
   
   start=2                     # minimum exponent value to which 2 can be raised to get minimum number of hosts
   hostloc=$(( $1 + 2 ))       # adding the input host requirement with network and broadcast address
 
   until [ $(( 2**start )) -ge $hostloc ]    # run the loop until power of 2 exceeds the host requirement
    do 
          final=$(( start ++ ))              # increment the exponent through every iteration
    done

    exp=$(( final+1 ))                
    cidr=$(( 32-(( final+1 )) ))          # store the CIDR value

   echo
   echo "PROCESSING............"
   echo 
   echo 
   echo
   echo "The CIDR value to be used is : /$cidr"
   echo 
   echo 


   if [ $cidr -ge 24 ] && [ $cidr -le 30 ]         # CIDR values between 24 and 30
   	then
   	 echo "The subnet mask is:"
       echo
       if [ $cidr -eq 24 ]       # when CIDR equals 24
         then
             echo " 255.255.255.0 "  
             echo "The effective number of subnets is:"
             echo "1"
       else        # otherwise
   	       echo "255.255.255.$(( 256-$(( 2**exp )) )) "
   	       echo
   	       echo "The effective number of subnets is:"
   	       echo
   	       subnets=$(( 2**$((cidr%8)) ))
   	       echo $subnets
       fi
   elif [ $cidr -ge 16 ] && [ $cidr -lt 24  ]      # CIDR values between 16 and 24
   	then
   	 exp=$((exp%8))
   	 echo "The subnet mask is";
       echo
       if [ $cidr -eq 16 ]     # when CIDR equals 16
          then
             echo " 255.255.0.0 "  
             echo "The effective number of subnets is:"
             echo "1"
       else            # otherwise
   	       echo "255.255.$(( 256-$(( 2**exp )) )).0"
   	       echo
   	       echo "The effective number of subnets is:"
   	       echo
   	       subnets=$(( 2**$((cidr%8)) ))
   	       echo $subnets
       fi
   elif [ $cidr -ge 8 ] && [ $cidr -lt 16 ]        # CIDR values between 8 and 16
   	then
       if [ $cidr -eq 8 ]    # when CIDR equals 8
          then
             echo " 255.0.0.0 "  
             echo "The effective number of subnets is:"
             echo "1"
       else         # otherwise
   	       exp=$((exp%8)) 
   	       echo "The subnet mask is";echo;
   	       echo "255.$(( 256-$(( 2**exp )) )).0.0"
   	       echo
   	       echo "The effective number of subnets is:"
   	       echo
   	       subnets=$(( 2**$((cidr%8)) ))
   	       echo $subnets;
       fi
   fi
  echo
}
# The driver function for the script 
function driver {         
    
   echo
   echo "Enter the number of hosts you wish to have per subnet! "
   echo
   read hosts
   hostCalc $hosts
}

driver        # call the driver function
