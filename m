Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail102.csoft.net ([96.47.74.245]:54799 "EHLO mail102.csoft.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbaLKPLy (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 11 Dec 2014 10:11:54 -0500
Message-ID: <5489B215.20707@fid4.com>
Date: Thu, 11 Dec 2014 10:02:45 -0500
From: "Michael C. Cambria" <mcc@fid4.com>
MIME-Version: 1.0
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
References: <20141207150814.GA9532@omega> <548487CF.4060009@fid4.com> <20141207171311.GB9532@omega> <20141207171903.GC9532@omega> <5484C900.2020402@fid4.com> <20141207215452.GB20260@omega>
In-Reply-To: <20141207215452.GB20260@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org


On 12/07/2014 04:54 PM, Alexander Aring wrote:
>
> ok. Read introductions at [0]. Begin at "Bring up 6LoWPAN" section. 
> For the at86rf230 you should have default a wpan0 interface. If you 
> use wpan-tools simple type "iwpan" and read the help for setting 
> address information. I think for at86rf230 you need to set the panid 
> only, phy settings should be transceiver defaults and short address 
> isn't supported for 6LoWPAN (except broadcast address, of course). The 
> documentation is a little bit outdated currently. 
[deleted]
>
> If you need help simple ask here or for better fast live supporting 
> you can contact me via IRC #linux-wpan on irc.freenode.net. Ping 
> between two nodes should be an easy setup. - Alex [0] 
> http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/GettingStarted-0.2 
> -- To unsubscribe from this list: send the line "unsubscribe 
> linux-wpan" in the body of a message to majordomo@vger.kernel.org More 
> majordomo info at http://vger.kernel.org/majordomo-info.html 

I'm using bluetooth-next, and it boots and seems to find the openlabs.co 
adapter just fine.

GettingStarted-0.2 describes the "iz" command.  I don't have "iz".  I 
built/installed on the Pi itself, downloaded from
http://wpan.cakelab.org/releases/.  I do see an iwpan command installed 
(see below).Are there more user tools or do we just substitute iz with 
iwpan?

Once an IPv6 address is assigned to wpan0, should I be able to ping 
wpan0 from an IPv6 address on a different box?  I ask because I only 
have one Pi at the moment and can't test radio to radio.



pi@raspberrypi:~$ iwpan list
wpan_phy wpan-phy0
supported channels:
         page 0: 11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26
current_page: 0
current_channel: 13
cca_mode: 0
tx_power: 0
pi@raspberrypi:~$
pi@raspberrypi:~$
pi@raspberrypi:~$
pi@raspberrypi:~$
pi@raspberrypi:~$ ifconfig
eth0      Link encap:Ethernet  HWaddr 7a:93:66:29:55:e3
           inet addr:192.168.1.171  Bcast:192.168.1.255 Mask:255.255.255.0
           inet6 addr: fe80::7893:66ff:fe29:55e3/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500 Metric:1
           RX packets:140 errors:2 dropped:0 overruns:0 frame:0
           TX packets:64 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:10011 (9.7 KiB)  TX bytes:6536 (6.3 KiB)

[deleted]

wpan0     Link encap:UNSPEC  HWaddr 
26-8E-9A-10-24-7B-3A-81-00-00-00-00-00-00-00-00
           UP BROADCAST RUNNING NOARP  MTU:127  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:300
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

pi@raspberrypi:~$



