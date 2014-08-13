Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from blu004-omc4s24.hotmail.com ([65.55.111.163]:59571 "EHLO
	BLU004-OMC4S24.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704AbaHMVr6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 13 Aug 2014 17:47:58 -0400
Message-ID: <BLU437-SMTP12A2EB954408C4FD54C241F7EB0@phx.gbl>
Date: Wed, 13 Aug 2014 23:42:46 +0200
From: Cristiano <cristiano_dealti@hotmail.com>
MIME-Version: 1.0
References: <BLU437-SMTP953B598AADB36D1E05A85AF7EB0@phx.gbl> <20140813204803.GC19527@omega>
In-Reply-To: <20140813204803.GC19527@omega>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [Linux-zigbee-devel] Old wiki updated but issues pinging fake
 nodes with relatively large payloads (> 93 octets)
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-zigbee-devel <linux-zigbee-devel@lists.sourceforge.net>, linux-wpan@vger.kernel.org

Thanks Alex,
   Yes the two commits:

http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=eb06481d69c60f6f9318e935053dce13fe3e8951
and
http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=51263fffadee28c99152fb78a2d41e3d10c9b0b5 


are in my kernel tree.

I merged the rpi kernel with net-next maybe one week ago, just before 
3.16 was released.
Merging them was quite easy. I had three small conflicts, related to the 
802.11 stack.

I will try net-next on qemu.

What ARCH/platform are you compiling the kernel for?

Ciao,
   Cristiano

On 08/13/2014 10:48 PM, Alexander Aring wrote:
> Hi,
>
> On Wed, Aug 13, 2014 at 07:16:51PM +0200, Cristiano wrote:
>> *
>> Hi,
>>    I eventually succeeded merging the Raspberry Pi 3.16+ kernel on net-next
>> with trivial merge conflicts (resolved).
>> I understand that the old linux-zigbee wiki is here now:
>>
>> http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/GettingStarted-0.2
>>
>> But it looks quite outdated/wrong. So I rewrote it for myself. Anyway I
>> still have problems which are described at the end.
>> Here it is:
>>
>> Build an 802.15.4-enabled Linux kernel with the following options:
>>
>> CONFIG_IEEE802154=y
>> CONFIG_IEEE802154_6LOWPAN=m
>> CONFIG_MAC802154=m
>> CONFIG_IEEE802154_DRIVERS=y
>> # CONFIG_IEEE802154_FAKEHARD is not set
>> CONFIG_IEEE802154_FAKELB=m
>>
>> If you have a hardware device you may want to enable:
>> CONFIG_IEEE802154_AT86RF230=m
>> CONFIG_IEEE802154_MRF24J40=m
>> CONFIG_IEEE802154_CC2520=m
>>
>> Update your bootloader and boot your new kernel.
>>
>> In our simulated network we will have 3 fake radios. One these radio
>> interfaces, we will start 3 nodes which will have short addresses 0x1,
>> 0x8001 and 0x8002. Node 0x1 will act as a coordinator and shall run
>> izcoordinator on it, which will handle network with PAN ID 0x777. Nodes
>> 0x8001 and 0x8002 will associate with coordinator and will receive addresses
>> after association. We will start izchat tool on these nodes,  and will use
>> Wireshark to monitor network traffic.
>> Before you start you should check that everything works. If you try the
>> following command:
>>
>> Create 3 fake radio interfaces for network devices:
>> # modprobe fakelb numlbs=3
>>
>> Check it with:
>> # iz listphy
>>
>> You should see the following output:
>> wpan-phy0  IEEE 802.15.4 PHY object
>>      page: 0  channel: n/a
>>      channels on page 0: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>> 21 22 23 24 25 26
>>      channels on page 1: 0 1 2 3 4 5 6 7 8 9 10
>>      channels on page 2: 0 1 2 3 4 5 6 7 8 9 10
>>      channels on page 3: 0 1 2 3 4 5 6 7 8 9 10 11 12 13
>>      channels on page 4: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>      channels on page 5: 0 1 2 3 4 5 6 7
>>      channels on page 6: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>> 21
>>
>> wpan-phy1  IEEE 802.15.4 PHY object
>>      page: 0  channel: n/a
>>      channels on page 0: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>> 21 22 23 24 25 26
>>      channels on page 1: 0 1 2 3 4 5 6 7 8 9 10
>>      channels on page 2: 0 1 2 3 4 5 6 7 8 9 10
>>      channels on page 3: 0 1 2 3 4 5 6 7 8 9 10 11 12 13
>>      channels on page 4: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>      channels on page 5: 0 1 2 3 4 5 6 7
>>      channels on page 6: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>> 21
>>
>> wpan-phy2  IEEE 802.15.4 PHY object
>>      page: 0  channel: n/a
>>      channels on page 0: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>> 21 22 23 24 25 26
>>      channels on page 1: 0 1 2 3 4 5 6 7 8 9 10
>>      channels on page 2: 0 1 2 3 4 5 6 7 8 9 10
>>      channels on page 3: 0 1 2 3 4 5 6 7 8 9 10 11 12 13
>>      channels on page 4: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
>>      channels on page 5: 0 1 2 3 4 5 6 7
>>      channels on page 6: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>> 21
>>
>> Create 3 radio interfaces, one per each phy:
>> # iz add wpan-phy0
>> Registered new device ('wpan0') on phy wpan-phy0
>> # iz add wpan-phy1
>> Registered new device ('wpan1') on phy wpan-phy1
>> # iz add wpan-phy2
>> Registered new device ('wpan2') on phy wpan-phy2
>>
>> Set distinct hw addresses:
>> # ip link set wpan0 address de:ad:be:af:ca:fe:ba:be
>> # ip link set wpan1 address ca:fe:ca:fe:ca:fe:ca:fe
>> # ip link set wpan2 address be:be:be:be:be:be:be:be
>>
>> Bring up logical interfaces (by default, one logical interface is associated
>> with each radio):
>> # ifconfig wpan0 up
>> # ifconfig wpan1 up
>> # ifconfig wpan2 up
>>
>> Start wireshark to monitor traffic on the network:
>>
>> # wireshark -i wpan0 -k
>> Start coordinator (you need to do it as root as well):
>>
>> # touch lease
>> # izcoordinator -d 1 -l lease -i wpan0 -p 0x777 -s 1 -c 11 &
>>
> coordinator support isn't supported at the moment.
>
>> If using the mainline kernel, assign short addresses manually using iz set:
>> # iz set wpan1 777 8001 11
>> # iz set wpan2 777 8002 11
>>
>> Start simple chat program in two different consoles/terminals (0x8001 and
>> 0x8002 are the short addresses are received during association):
>> # izchat 777 8001 8002
>> # izchat 777 8002 8001
>>
>> Bring up 6LoWPAN:
>> # ip link add link wpan0 name lowpan0 type lowpan
>> # ip link set lowpan0 up
>>
>> # ip link add link wpan1 name lowpan1 type lowpan
>> # ip link set lowpan1 up
>>
>> # ip link add link wpan2 name lowpan2 type lowpan
>> # ip link set lowpan2 up
>>
>> Check with:
>> # ifconfig lowpan0
>> # ifconfig lowpan1
>> # ifconfig lowpan2
>>
>> You should see the following output:
>> lowpan0   Link encap:UNSPEC  HWaddr
>> DE-AD-BE-AF-CA-FE-BA-BE-00-00-00-00-00-00-00-00
>>            inet6 addr: fe80::dcad:beaf:cafe:babe/64 Scope:Link
>>            UP BROADCAST RUNNING MULTICAST  MTU:1281  Metric:1
>>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>            collisions:0 txqueuelen:0
>>            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>>
>> lowpan1   Link encap:UNSPEC  HWaddr
>> CA-FE-CA-FE-CA-FE-CA-FE-00-00-00-00-00-00-00-00
>>            inet6 addr: fe80::c8fe:cafe:cafe:cafe/64 Scope:Link
>>            UP BROADCAST RUNNING MULTICAST  MTU:1281  Metric:1
>>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>            collisions:0 txqueuelen:0
>>            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>>
>> lowpan2   Link encap:UNSPEC  HWaddr
>> BE-BE-BE-BE-BE-BE-BE-BE-00-00-00-00-00-00-00-00
>>            inet6 addr: fe80::bcbe:bebe:bebe:bebe/64 Scope:Link
>>            UP BROADCAST RUNNING MULTICAST  MTU:1281  Metric:1
>>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>            collisions:0 txqueuelen:0
>>            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>>
>> We can see that Stateless Auto Configuration (SLAC) for the link local
>> address works.
>>
>> Ping between nodes:
>> # ping6 fe80::c8fe:cafe:cafe:cafe%lowpan0
>> # ping6 fe80::bcbe:bebe:bebe:bebe%lowpan0
>> # ping6 fe80::bcbe:bebe:bebe:bebe%lowpan1
>> # ping6 fe80::dcad:beaf:cafe:babe%lowpan1
>> # ping6 fe80::dcad:beaf:cafe:babe%lowpan2
>> # ping6 fe80::c8fe:cafe:cafe:cafe%lowpan2
>>
>>
>> Anyway I have problems pinging the nodes when specifying a ping with payload
>> size greater than 93. For example, pinging lowpan0 from lowpan1:
>>
>> # ping6 -s94 fe80::dcad:beaf:cafe:babe%lowpan1
>>
>> I don't get anything back (no output at all).
>>
>> Running Tshark on lowpan0 (fe80::dcad:beaf:cafe:babe) shows this:
>>
>> sudo tshark -i lowpan0
>> tshark: Lua: Error during loading:
>>   [string "/usr/share/wireshark/init.lua"]:45: dofile has been disabled
>> Running as user "root" and group "root". This could be dangerous.
>> Capturing on lowpan0
>>    0.000000 ca:af:be:ad:dc:00:00:00 -> 00:00:00:80:fe:fe:ca:fe IEEE 802.15.4
>> 64 Beacon, Dst: 00:00:00_80:fe:fe:ca:fe, Src:
>> ca:af:bead:dc:0000:00[Malformed Packet]
>>    0.000363 fe80::dcad:beaf:cafe:babe -> fe80::c8fe:cafe:cafe:cafe ICMPv6 48
>> Neighbor Advertisement fe80::dcad:beaf:cafe:babe (sol)
>>    5.009835 fe80::dcad:beaf:cafe:babe -> fe80::c8fe:cafe:cafe:cafe ICMPv6 64
>> Neighbor Solicitation for fe80::c8fe:cafe:cafe:cafe from
>> de:ad:be:af:ca:fe:ba:be
>>    5.010874 ca:af:be:ad:dc:00:00:00 -> 00:00:00:80:fe:fe:ca:fe IEEE 802.15.4
>> 48 Beacon, Dst: 00:00:00_80:fe:fe:ca:fe, Src: ca:af:bead:dc:0000:00[Packet
>> size limited during capture]
>>   47.019946 ca:af:be:ad:dc:00:00:00 -> 00:00:00:80:fe:fe:ca:fe IEEE 802.15.4
>> 64 Beacon, Dst: 00:00:00_80:fe:fe:ca:fe, Src:
>> ca:af:bead:dc:0000:00[Malformed Packet]
>>   47.020289 fe80::dcad:beaf:cafe:babe -> fe80::c8fe:cafe:cafe:cafe ICMPv6 48
>> Neighbor Advertisement fe80::dcad:beaf:cafe:babe (sol)
>>   52.029831 fe80::dcad:beaf:cafe:babe -> fe80::c8fe:cafe:cafe:cafe ICMPv6 64
>> Neighbor Solicitation for fe80::c8fe:cafe:cafe:cafe from
>> de:ad:be:af:ca:fe:ba:be
>>   52.030435 ca:af:be:ad:dc:00:00:00 -> 00:00:00:80:fe:fe:ca:fe IEEE 802.15.4
>> 48 Beacon, Dst: 00:00:00_80:fe:fe:ca:fe, Src: ca:af:bead:dc:0000:00[Packet
>> size limited during capture]
>>
>> Specifying a ping payload size lesser than or equal to 93 somewhat works and
>> Tshark output looks like this:
>>
>> sudo tshark -i lowpan0
>> tshark: Lua: Error during loading:
>>   [string "/usr/share/wireshark/init.lua"]:45: dofile has been disabled
>> Running as user "root" and group "root". This could be dangerous.
>> Capturing on lowpan0
>>    0.000000 ca:af:be:ad:dc:00:00:00 -> 00:00:00:80:fe:fe:ca:fe IEEE 802.15.4
>> 125 Beacon, Dst: 00:00:00_80:fe:fe:ca:fe, Src: ca:af:bead:dc:0000:00
>>    0.000417 fe80::dcad:beaf:cafe:babe -> fe80::c8fe:cafe:cafe:cafe ICMPv6 125
>> Echo (ping) reply id=0x1147, seq=1
>>    1.001208 ca:af:be:ad:dc:00:00:00 -> 00:00:00:80:fe:fe:ca:fe IEEE 802.15.4
>> 125 Beacon, Dst: 00:00:00_80:fe:fe:ca:fe, Src: ca:af:bead:dc:0000:00
>>    1.001536 fe80::dcad:beaf:cafe:babe -> fe80::c8fe:cafe:cafe:cafe ICMPv6 125
>> Echo (ping) reply id=0x1147, seq=2
>>    2.002675 ca:af:be:ad:dc:00:00:00 -> 00:00:00:80:fe:fe:ca:fe IEEE 802.15.4
>> 125 Beacon, Dst: 00:00:00_80:fe:fe:ca:fe, Src: ca:af:bead:dc:0000:00
>>    2.002997 fe80::dcad:beaf:cafe:babe -> fe80::c8fe:cafe:cafe:cafe ICMPv6 125
>> Echo (ping) reply id=0x1147, seq=3
>>    3.004102 ca:af:be:ad:dc:00:00:00 -> 00:00:00:80:fe:fe:ca:fe IEEE 802.15.4
>> 125 Beacon, Dst: 00:00:00_80:fe:fe:ca:fe, Src: ca:af:bead:dc:0000:00
>>    3.004424 fe80::dcad:beaf:cafe:babe -> fe80::c8fe:cafe:cafe:cafe ICMPv6 125
>> Echo (ping) reply id=0x1147, seq=4
>>    4.005586 ca:af:be:ad:dc:00:00:00 -> 00:00:00:80:fe:fe:ca:fe IEEE 802.15.4
>> 125 Beacon, Dst: 00:00:00_80:fe:fe:ca:fe, Src: ca:af:bead:dc:0000:00
>>    4.006001 fe80::dcad:beaf:cafe:babe -> fe80::c8fe:cafe:cafe:cafe ICMPv6 125
>> Echo (ping) reply id=0x1147, seq=5
>>
> wireshark with lowpan interface is broken.
>
>> Is this a 6lowpan fragmentation issue?
> Looks like but I tested it with current net-next kernel and it works.
> Maybe you did something wrong with merging your rpi with net-next. Try
> it under a qemu vm.
>
> Do you have these patches:
>
> http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=eb06481d69c60f6f9318e935053dce13fe3e8951
>
> and
>
> http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=51263fffadee28c99152fb78a2d41e3d10c9b0b5
>
> but this is in current net-next, there was a little time where this was
> broken.
>
>> Tshark output looks weird expecially decoding IEEE 802.15.4 frames
>> (addresses do not look good and what are those Beacon frames that only
>> appear after started pinging?).
>> Also, ICMPv6 echo requests are not present in the Tshark output.
>>
>> Can anybody try the above instructions and confirm the issue?
>>
> I tested it and it works on my side.
>
> btw. there exists a new mailinglist for this project:
>
> http://vger.kernel.org/vger-lists.html#linux-wpan
>
> - Alex
>
>

