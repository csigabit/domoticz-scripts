#!/bin/bash
 
 # Settings
 
 NASIP="192.168.221.4"       # NAS IP Address
 PASSWORD="password"         # SNMP Password
 DOMO_IP="192.168.221.4"     # Domoticz IP Address
 DOMO_PORT="1180"            # Domoticz Port
 NAS_IDX="20"                # NAS Switch IDX
 NAS_HD1_TEMP_IDX="21"       # NAS HD1 Temp IDX
 NAS_HD2_TEMP_IDX="22"       # NAS HD2 Temp IDX
 NAS_HD1_TEMP_IDX="23"       # NAS HD3 Temp IDX
 NAS_HD2_TEMP_IDX="24"       # NAS HD4 Temp IDX
 NAS_HD1_TEMP_IDX="25"       # NAS HD5 Temp IDX
 NAS_HD2_TEMP_IDX="26"       # NAS HD6 Temp IDX
 NAS_HD1_TEMP_IDX="27"       # NAS HD7 Temp IDX
 NAS_HD2_TEMP_IDX="28"       # NAS HD8 Temp IDX
 NAS_HD_SPACE_IDX="32"       # NAS HD Space IDX in Go
 NAS_CPU_IDX="29"            # NAS CPU IDX
 NAS_MEM_IDX="30"            # NAS MEM IDX
 
 
 # Check if NAS in online 
 
 PINGTIME=`ping -c 1 -q $NASIP | awk -F"/" '{print $5}' | xargs`
 
 echo $PINGTIME
 if expr "$PINGTIME" '>' 0
 then
   curl -s "http://$DOMO_IP:$DOMO_PORT/json.htm?type=devices&rid=$NAS_IDX" | grep "Status" | grep "On" > /dev/null
 
       if [ $? -eq 0 ] ; then
        echo "NAS already ON"
       
        # Temperature HD1
        HDtemp1=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.0`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD1_TEMP_IDX&nvalue=0&svalue=$HDtemp1"
 
        # Temperature HD2
        HDtemp2=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.1`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD2_TEMP_IDX&nvalue=0&svalue=$HDtemp2"
        
        # Temperature HD3
        HDtemp1=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.2`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD3_TEMP_IDX&nvalue=0&svalue=$HDtemp3"
 
        # Temperature HD4
        HDtemp2=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.3`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD4_TEMP_IDX&nvalue=0&svalue=$HDtemp4"
        
        # Temperature HD5
        HDtemp1=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.4`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD5_TEMP_IDX&nvalue=0&svalue=$HDtemp5"
 
        # Temperature HD6
        HDtemp2=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.5`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD6_TEMP_IDX&nvalue=0&svalue=$HDtemp6"
        
        # Temperature HD7
        HDtemp1=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.6`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD7_TEMP_IDX&nvalue=0&svalue=$HDtemp7"
 
        # Temperature HD8
        HDtemp2=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.7`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD8_TEMP_IDX&nvalue=0&svalue=$HDtemp8"

        # Free space volume in Go
        HDUnit=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.2.1.25.2.3.1.4.42`  # Change OID to .38 on DSM 5.1, .41 on DSM 6.0, 42 on DSM 6.1
        HDTotal=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.2.1.25.2.3.1.5.42` # Change OID to .38 on DSM 5.1, .41 on DSM 6.0, 42 on DSM 6.1
        HDUsed=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.2.1.25.2.3.1.6.42`  # Change OID to .38 on DSM 5.1, .41 on DSM 6.0, 42 on DSM 6.1
        HDFree=$((($HDTotal - $HDUsed) * $HDUnit / 1024 / 1024 / 1024))
 
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD_SPACE_IDX&nvalue=0&svalue=$HDFree"

	# CPU utilisation
        CpuUser=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.11.9.0`
	CpuSystem=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.11.10.0`
	CpuUse=$(($CpuUser + $CpuSystem))
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_CPU_IDX&nvalue=0&svalue=$CpuUse"

        # Free Memory Available in %
	MemAvailable=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.4.6.0`
        MemAvailableinMo=$(($MemAvailable / 1024))
	MemUsepercent=$((($MemAvailableinMo * 100) / 1024))
        # Send data
       curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_MEM_IDX&nvalue=0&svalue=$MemUsepercent"
      
else
        echo "NAS ON"
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=switchlight&idx=$NAS_IDX&switchcmd=On"
 
        # Temperature HD1
        HDtemp1=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.0`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD1_TEMP_IDX&nvalue=0&svalue=$HDtemp1"
 
        # Temperature HD2
        HDtemp2=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.1`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD2_TEMP_IDX&nvalue=0&svalue=$HDtemp2"
        
        # Temperature HD3
        HDtemp1=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.2`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD3_TEMP_IDX&nvalue=0&svalue=$HDtemp3"
 
        # Temperature HD4
        HDtemp2=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.3`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD4_TEMP_IDX&nvalue=0&svalue=$HDtemp4"
        
        # Temperature HD5
        HDtemp1=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.4`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD5_TEMP_IDX&nvalue=0&svalue=$HDtemp5"
 
        # Temperature HD6
        HDtemp2=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.5`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD6_TEMP_IDX&nvalue=0&svalue=$HDtemp6"
        
        # Temperature HD7
        HDtemp1=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.6`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD7_TEMP_IDX&nvalue=0&svalue=$HDtemp7"
 
        # Temperature HD8
        HDtemp2=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.6574.2.1.1.6.7`
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD8_TEMP_IDX&nvalue=0&svalue=$HDtemp8"
 
        # Free space volume in Go
        HDUnit=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.2.1.25.2.3.1.4.42`  # Change OID to .38 on DSM 5.1, .41 on DSM 6.0, 42 on DSM 6.1
        HDTotal=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.2.1.25.2.3.1.5.42` # Change OID to .38 on DSM 5.1, .41 on DSM 6.0, 42 on DSM 6.1
        HDUsed=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.2.1.25.2.3.1.6.42`  # Change OID to .38 on DSM 5.1, .41 on DSM 6.0, 42 on DSM 6.1
        HDFree=$((($HDTotal - $HDUsed) * $HDUnit / 1024 / 1024 / 1024))
 
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_HD_SPACE_IDX&nvalue=0&svalue=$HDFree"
 
	# CPU utilisation
        CpuUser=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.11.9.0`
	CpuSystem=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.11.10.0`
	CpuUse=$(($CpuUser + $CpuSystem))
        # Send data
        curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_CPU_IDX&nvalue=0&svalue=$CpuUse"

        # Free Memory Available in %
	MemAvailable=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.4.6.0`
        MemAvailableinMo=$(($MemAvailable / 1024))
	MemUsepercent=$((($MemAvailableinMo * 100) / 1024))
        # Send data
       curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_MEM_IDX&nvalue=0&svalue=$MemUsepercent"

      fi
 
 else
        curl -s "http://$DOMO_IP:$DOMO_PORT/json.htm?type=devices&rid=$NAS_IDX" | grep "Status" | grep "Off" > /dev/null
        if [ $? -eq 0 ] ; then
                echo "NAS already OFF"
                exit
        else
                echo "NAS OFF"
                # Send data
                curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=switchlight&idx=$NAS_IDX&switchcmd=Off"
        fi
 fi
