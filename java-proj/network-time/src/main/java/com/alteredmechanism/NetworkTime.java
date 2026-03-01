package com.alteredmechanism;

import java.net.InetAddress;
import org.apache.commons.net.ntp.NTPUDPClient;
import org.apache.commons.net.ntp.TimeInfo;
import org.apache.commons.net.ntp.NtpV3Packet;
import org.apache.commons.net.ntp.TimeStamp;
import java.util.Date;

class NetworkTime {
    public static void main(String[] args) {
        try {
            NTPUDPClient client = new NTPUDPClient();
            client.setDefaultTimeout(10000);
            InetAddress ntpServer = InetAddress.getByName("pool.ntp.org");
            TimeInfo timeInfo = client.getTime(ntpServer);
            timeInfo.computeDetails();
            NtpV3Packet packet = timeInfo.getMessage();
            TimeStamp transmitTime = packet.getTransmitTimeStamp();
            Date ntpTime = transmitTime.getDate();
            Date now = new Date();
            System.out.printf("NTP Time: %s\n", ntpTime.toString());
            System.out.printf("System Time: %s\n", now.toString());
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
