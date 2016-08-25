Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35193 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbcHYLRT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Aug 2016 07:17:19 -0400
Received: by mail-pa0-f48.google.com with SMTP id hb8so16241224pac.2
        for <linux-wpan@vger.kernel.org>; Thu, 25 Aug 2016 04:17:18 -0700 (PDT)
Received: from desktop ([103.232.159.187])
        by smtp.gmail.com with ESMTPSA id 191sm20153468pfx.68.2016.08.25.04.09.16
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2016 04:09:17 -0700 (PDT)
Message-ID: <1472123410.2490.156.camel@newmarch.name>
Subject: [Fwd: Re: at86rf233 in Raspberry Pi 3]
From: Jan Newmarch <jan@newmarch.name>
Date: Thu, 25 Aug 2016 21:10:10 +1000
References: <1472122778.2490.149.camel@newmarch.name>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi

I'm still struggling to get two RPi 2 B's to ping each other
with at86rf233 devices. I can see the devices. They can ping themselves
but they can't ping each other. According to wireshark and dmesg, lots
of malformed packets.

Details:

Used raspbian-lite: 2016--6-27-raspbian-jessie-lite
Upgraded using rpi-update

uname -a returns 
    Linux raspberrypi 4.4.18-v7+ #905 SMP Fri Aug 19 19:11:00 BST 2016
       armv7l GNU/Linux

For firmware, /opt/vc/bin/vcgencmd version returns
    Aug 19 2016 19:51:20 
    Copyright (c) 2012 Broadcom
    version 04cb74d9feb624e2463cde9db466bdce8b9799e9 (clean) (release)

Only change made to /boot/config.txt is to add
dtoverlay=at86rf233

dmesg has seen the device
[    7.597997] at86rf230 spi0.0: Detected at86rf233 chip version 1

Decompiling the device tree using  dtc -I fs /proc/device-tree &gt;
name.dts shows
at86rf233@0{
                                reg = <0x0>;
                                interrupts = &lt;0x17 0x4>;
                                compatible = "atmel,at86rf233";
                                sleep-gpio = &lt;0xb 0x19 0x1>;
                                xtal-trim = [0f];
                                spi-max-frequency = &lt;0x2dc6c0>;
                                reset-gpio = &lt;0xb 0x18 0x1>;
                                phandle = &lt;0x42>;
                                interrupt-parent = &lt;0xb>;
                        };
The SPI frequency is 0x2dc6c0 i.e. 3000000, the default

I setup openlabs  Raspberry Pi 802.15.4 radio using
    iwpan dev wpan0 set pan_id 0xbeef
    ip link add link wpan0 name lowpan0 type lowpan
    ifconfig wpan0 up
    ifconfig lowpan0 up

iz list shows the pan id is set
wpan0 (3)
    link: IEEE 802.15.4 MAC interface
    phy phy0
    hw 22:62:94:95:cd:2e:5a:3a pan 0xbeef short 0xffff

iwpan (v0.6) reports

$ ./iwpan list
wpan_phy phy0
supported channels:
	page 0: 11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26 
current_page: 0
current_channel: 13,  2415 MHz
cca_mode: (1) Energy above threshold
cca_ed_level: -77
tx_power: 4
capabilities:
	iftypes: node,monitor 
	channels:
		page 0: 
			[11]  2405 MHz, [12]  2410 MHz, [13]  2415
MHz, 
			[14]  2420 MHz, [15]  2425 MHz, [16]  2430
MHz, 
			[17]  2435 MHz, [18]  2440 MHz, [19]  2445
MHz, 
			[20]  2450 MHz, [21]  2455 MHz, [22]  2460
MHz, 
			[23]  2465 MHz, [24]  2470 MHz, [25]  2475
MHz, 
			[26]  2480 MHz  
	tx_powers: 4,3.7,3.4,3,2.5,2,1,0,-1,-2,-3,-4,-6,-8,-12,-17 
	cca_ed_levels: -91,-89,-87,-85,-83,-81,-79,-77,-75,-73,-71,-
69,-67,-65,-63,-61 
	cca_modes: 
		(1) Energy above threshold
		(2) Carrier sense only
		(3, cca_opt: 0) Carrier sense with energy above
threshold (logical operator is 'and')
		(3, cca_opt: 1) Carrier sense with energy above
threshold (logical operator is 'or')
	min_be: 0,1,2,3,4,5,6,7,8 
	max_be: 3,4,5,6,7,8 
	csma_backoffs: 0,1,2,3,4,5 
	frame_retries: 0,1,2,3,4,5,6,7 
	lbt: false
Supported commands:
	* new_interface
	* del_interface
	* set_channel
	* set_pan_id
	* set_short_addr
	* set_backoff_exponent
	* set_max_csma_backoffs
	* set_max_frame_retries
	* set_lbt_mode
	* set_ackreq_default
	* set_tx_power
	* set_cca_ed_level
	* set_cca_mode

ifconfig on first RPi (second one not running yet) shows
lowpan0   Link encap:UNSPEC  HWaddr 22-62-94-95-CD-2E-5A-3A-00-00-00-
00-00-00-00-00  
          inet6 addr: fe80::2062:9495:cd2e:5a3a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:18 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:3141 (3.0 KiB)

wpan0     Link encap:UNSPEC  HWaddr 22-62-94-95-CD-2E-5A-3A-00-00-00-
00-00-00-00-00  
          UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:34 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300 
          RX bytes:0 (0.0 B)  TX bytes:3133 (3.0 KiB)
i.e. already transmitted from lowpan0 and wpan0 but nothing received
(no-one to receive from yet).

dmesg shows no errors.

Wireshark shows errors already [image removed for mailing list]
plus later errors.

Now I ping6 the local device
$ping6 fe80::2062:9495:cd2e:5a3a%lowpan0
PING fe80::2062:9495:cd2e:5a3a%lowpan0(fe80::2062:9495:cd2e:5a3a) 56
data bytes
64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=1 ttl=64 time=0.257
ms
64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=2 ttl=64 time=0.205
ms
64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=3 ttl=64 time=0.183
ms
64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=4 ttl=64 time=0.179
ms
64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=5 ttl=64 time=0.182
ms

dmesg reports no errors

Wireshark is happy

ifconfig reports more bytes sent, none received
lowpan0   Link encap:UNSPEC  HWaddr 22-62-94-95-CD-2E-5A-3A-00-00-00-
00-00-00-00-00  
          inet6 addr: fe80::2062:9495:cd2e:5a3a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:3205 (3.1 KiB)

wpan0     Link encap:UNSPEC  HWaddr 22-62-94-95-CD-2E-5A-3A-00-00-00-
00-00-00-00-00  
          UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:35 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300 
          RX bytes:0 (0.0 B)  TX bytes:3176 (3.1 KiB)


Now to add in the second RPi. After setting it up, ifconfig on the
second RPi shows
lowpan0   Link encap:UNSPEC  HWaddr 82-B7-04-8B-DB-57-9E-E1-00-00-00-
00-00-00-00-00  
          inet6 addr: fe80::80b7:48b:db57:9ee1/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:3237 (3.1 KiB)

wpan0     Link encap:UNSPEC  HWaddr 82-B7-04-8B-DB-57-9E-E1-00-00-00-
00-00-00-00-00  
          UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:35 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300 
          RX bytes:0 (0.0 B)  TX bytes:3208 (3.1 KiB)

dmesg shows no errors

Wireshark shows errors on this second RPi [image removed for mailing
list]

On the first Rpi, wireshark shows NOTHING. On the other hand, dmesg on
the first RPi shows
[ 3197.970150] ieee802154: bad frame received (type = 0)
[ 3198.170317] ieee802154: bad frame received (type = 0)
[ 3198.680961] ieee802154: bad frame received (type = 0)
[ 3199.170489] ieee802154: bad frame received (type = 0)
[ 3199.173315] ieee802154: bad frame received (type = 0)
[ 3199.190078] ieee802154: bad frame received (type = 0)
[ 3199.307879] ieee802154: bad frame received (type = 0)
[ 3199.312959] ieee802154: bad frame received (type = 0)
[ 3199.318120] ieee802154: bad frame received (type = 0)
[ 3199.324555] ieee802154: bad frame received (type = 0)
[ 3199.555055] ieee802154: bad frame received (type = 0)

ifconfig on the first RPi now shows bytes received on wpan0 but not
making it up to lowpan0 
I guess those are the dmesg errors
> lowpan0   Link encap:UNSPEC  HWaddr 22-62-94-95-CD-2E-5A-3A-00-00-00-
> 00-00-00-00-00  
>           inet6 addr: fe80::2062:9495:cd2e:5a3a/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1 
>           RX bytes:0 (0.0 B)  TX bytes:3205 (3.1 KiB)
> 
> wpan0     Link encap:UNSPEC  HWaddr 22-62-94-95-CD-2E-5A-3A-00-00-00-
> 00-00-00-00-00  
>           UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
>           RX packets:34 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:35 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:300 
>           RX bytes:578 (578.0 B)  TX bytes:3176 (3.1 KiB)
Finally trying ping6 from the first RPi to to the second.

 $ ping6 fe80::80b7:48b:db57:9ee1%lowpan0
PING fe80::80b7:48b:db57:9ee1%lowpan0(fe80::80b7:48b:db57:9ee1) 56 data
bytes
 From fe80::2062:9495:cd2e:5a3a icmp_seq=1 Destination unreachable:
Address unreachable
 From fe80::2062:9495:cd2e:5a3a icmp_seq=2 Destination unreachable:
Address unreachable
 From fe80::2062:9495:cd2e:5a3a icmp_seq=3 Destination unreachable:
Address unreachable
 From fe80::2062:9495:cd2e:5a3a icmp_seq=4 Destination unreachable:
Address unreachable

ifconfig on the first RPi show bytes transmitted, none received
ifconfig on the second RPi shows bytes received by wpan0, none made it
up to lowpan0

dmesg on the first RPi shows no more errors
dmesg on the second RPi shows errors
[ 3801.036140] ieee802154: bad frame received (type = 0)
[ 3802.031620] ieee802154: bad frame received (type = 0)
[ 3803.031183] ieee802154: bad frame received (type = 0)
[ 3804.041254] ieee802154: bad frame received (type = 0)

Wireshark on the first RPi shows failure [image removed for mailing
list]

Wireshark on the second RPi shows NOTHING (nothing made it up to
lowpan0)

The routing table on the first RPi looks ok
$ route -A inet6
Kernel IPv6 routing table
Destination                    Next Hop                   Flag Met Ref
Use If
::1/128                        ::                         U    256
0     0 lo
fe80::/64                      ::                         U    256
0     0 eth0
fe80::/64                      ::                         U    256
1     9 lowpan0
::/0                           ::                         !n   -
1  1    26 lo
::1/128                        ::                         Un   0   5   
 11 lo
fe80::2062:9495:cd2e:5a3a/128  ::                         Un   0   3   
 35 lo
fe80::f698:e074:cc43:3109/128  ::                         Un   0   1   
  0 lo
ff00::/8                       ::                         U    256
3   281 eth0
ff00::/8                       ::                         U    256
1     9 lowpan0
::/0                           ::                         !n   -
1  1    26 lo

The second RPi routing table looks okay too.

I have seen comments about setting the SPI rate. The default rate is
3000000. I'ev used it in all the above. 
Resetting it to 1000000 didn't make any difference, nor did 100000, by
dtoverlay=at86rf233,speed=100000
in /boot/config.txt

As you can see, I've tried a lot of things. What do I do now?

Regards

Jan
-- 
Dr Jan Newmarch,
Head of Higher Education (ICT) @ Box Hill,
Adjunct Professor @ University of Canberra

P 61 3 9286 9971
M +61 4 0117 0509
F 61 3 9286 9100
W www.boxhill.edu.au
W jan.newmarch.name
E j.newmarch@boxhill.edu.au
E jan@newmarch.name



