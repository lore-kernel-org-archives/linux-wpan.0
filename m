Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:16457 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753783AbcHYLTE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Aug 2016 07:19:04 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: at86rf233 in Raspberry Pi 3
From: smlng <s@mlng.net>
In-Reply-To: <1472122778.2490.149.camel@newmarch.name>
Date: Thu, 25 Aug 2016 13:12:50 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <F24E93F0-F5EB-4E44-BBFF-81D55BEBAA23@mlng.net>
References: <CAF_bZd2CYeuVpmG_Sb4QKVHtpb7q-WxwhCoXr-4yNoZ1CGvRRg@mail.gmail.com> <C218BF9B-CADB-4AF6-8ADE-795F51A09859@mlng.net> <CAF_bZd370Lxvrq1U0uoiCoLdwVJEABt4X3xNXfpOF_RpBeauCg@mail.gmail.com> <AED49D76-171E-4430-87DC-F4DC52CE909D@mlng.net> <1472122778.2490.149.camel@newmarch.name>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jan Newmarch <jan@newmarch.name>
Cc: Tao Liu <liu3tao@gmail.com>, linux-wpan@vger.kernel.org, "f.mentiplay" <f.mentiplay@gmail.com>

Hey Jan,

the v4.4 Linux-Kernel of latest Raspbian is not working with the =
OpenLabs transceiver. You have to build a custom Kernel, e.g. v4.7 or =
v4.8 as described in [1]. That should do the trick.

Best,
 Sebastian

[1]: =
https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbia=
n-image-with-6LoWPAN-support#4-new-linux-kernels-for-the-pi
> Am 25.08.2016 um 12:59 schrieb Jan Newmarch <jan@newmarch.name>:
>=20
> Hi
>=20
> I'm still struggling to get two RPi 2 B's to ping each other with =
at86rf233 devices. I can see the devices. They can ping themselves but =
they can't ping each other. According to wireshark and dmesg, lots of =
malformed packets.
>=20
> Details:
>=20
> Used raspbian-lite: 2016--6-27-raspbian-jessie-lite
> Upgraded using rpi-update
>=20
> uname -a returns=20
>     Linux raspberrypi 4.4.18-v7+ #905 SMP Fri Aug 19 19:11:00 BST 2016 =
       armv7l GNU/Linux
>=20
> For firmware, /opt/vc/bin/vcgencmd version returns
>     Aug 19 2016 19:51:20=20
>     Copyright (c) 2012 Broadcom
>     version 04cb74d9feb624e2463cde9db466bdce8b9799e9 (clean) (release)
>=20
> Only change made to /boot/config.txt is to add
> dtoverlay=3Dat86rf233
>=20
> dmesg has seen the device
> [    7.597997] at86rf230 spi0.0: Detected at86rf233 chip version 1
>=20
> Decompiling the device tree using  dtc -I fs /proc/device-tree &gt; =
name.dts shows
> at86rf233@0{
>                                 reg =3D <0x0>;
>                                 interrupts =3D &lt;0x17 0x4>;
>                                 compatible =3D "atmel,at86rf233";
>                                 sleep-gpio =3D &lt;0xb 0x19 0x1>;
>                                 xtal-trim =3D [0f];
>                                 spi-max-frequency =3D &lt;0x2dc6c0>;
>                                 reset-gpio =3D &lt;0xb 0x18 0x1>;
>                                 phandle =3D &lt;0x42>;
>                                 interrupt-parent =3D &lt;0xb>;
>                         };
> The SPI frequency is 0x2dc6c0 i.e. 3000000, the default
>=20
> I setup openlabs  Raspberry Pi 802.15.4 radio using
>     iwpan dev wpan0 set pan_id 0xbeef
>     ip link add link wpan0 name lowpan0 type lowpan
>     ifconfig wpan0 up
>     ifconfig lowpan0 up
>=20
> iz list shows the pan id is set
> wpan0 (3)
>     link: IEEE 802.15.4 MAC interface
>     phy phy0
>     hw 22:62:94:95:cd:2e:5a:3a pan 0xbeef short 0xffff
>=20
> iwpan (v0.6) reports
>=20
> $ ./iwpan list
> wpan_phy phy0
> supported channels:
> 	page 0: 11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26=20
> current_page: 0
> current_channel: 13,  2415 MHz
> cca_mode: (1) Energy above threshold
> cca_ed_level: -77
> tx_power: 4
> capabilities:
> 	iftypes: node,monitor=20
> 	channels:
> 		page 0:=20
> 			[11]  2405 MHz, [12]  2410 MHz, [13]  2415 MHz,=20=

> 			[14]  2420 MHz, [15]  2425 MHz, [16]  2430 MHz,=20=

> 			[17]  2435 MHz, [18]  2440 MHz, [19]  2445 MHz,=20=

> 			[20]  2450 MHz, [21]  2455 MHz, [22]  2460 MHz,=20=

> 			[23]  2465 MHz, [24]  2470 MHz, [25]  2475 MHz,=20=

> 			[26]  2480 MHz =20
> 	tx_powers: 4,3.7,3.4,3,2.5,2,1,0,-1,-2,-3,-4,-6,-8,-12,-17=20
> 	cca_ed_levels: =
-91,-89,-87,-85,-83,-81,-79,-77,-75,-73,-71,-69,-67,-65,-63,-61=20
> 	cca_modes:=20
> 		(1) Energy above threshold
> 		(2) Carrier sense only
> 		(3, cca_opt: 0) Carrier sense with energy above =
threshold (logical operator is 'and')
> 		(3, cca_opt: 1) Carrier sense with energy above =
threshold (logical operator is 'or')
> 	min_be: 0,1,2,3,4,5,6,7,8=20
> 	max_be: 3,4,5,6,7,8=20
> 	csma_backoffs: 0,1,2,3,4,5=20
> 	frame_retries: 0,1,2,3,4,5,6,7=20
> 	lbt: false
> Supported commands:
> 	* new_interface
> 	* del_interface
> 	* set_channel
> 	* set_pan_id
> 	* set_short_addr
> 	* set_backoff_exponent
> 	* set_max_csma_backoffs
> 	* set_max_frame_retries
> 	* set_lbt_mode
> 	* set_ackreq_default
> 	* set_tx_power
> 	* set_cca_ed_level
> 	* set_cca_mode
>=20
> ifconfig on first RPi (second one not running yet) shows
> lowpan0   Link encap:UNSPEC  HWaddr =
22-62-94-95-CD-2E-5A-3A-00-00-00-00-00-00-00-00 =20
>           inet6 addr: fe80::2062:9495:cd2e:5a3a/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:18 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1=20
>           RX bytes:0 (0.0 B)  TX bytes:3141 (3.0 KiB)
>=20
> wpan0     Link encap:UNSPEC  HWaddr =
22-62-94-95-CD-2E-5A-3A-00-00-00-00-00-00-00-00 =20
>           UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:34 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:300=20
>           RX bytes:0 (0.0 B)  TX bytes:3133 (3.0 KiB)
> i.e. already transmitted from lowpan0 and wpan0 but nothing received =
(no-one to receive from yet).
>=20
> dmesg shows no errors.
>=20
> Wireshark shows errors already
> <unknown-GBRCMY.png>plus later errors.
>=20
> Now I ping6 the local device
> $ping6 fe80::2062:9495:cd2e:5a3a%lowpan0
> PING fe80::2062:9495:cd2e:5a3a%lowpan0(fe80::2062:9495:cd2e:5a3a) 56 =
data bytes
> 64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=3D1 ttl=3D64 =
time=3D0.257 ms
> 64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=3D2 ttl=3D64 =
time=3D0.205 ms
> 64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=3D3 ttl=3D64 =
time=3D0.183 ms
> 64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=3D4 ttl=3D64 =
time=3D0.179 ms
> 64 bytes from fe80::2062:9495:cd2e:5a3a: icmp_seq=3D5 ttl=3D64 =
time=3D0.182 ms
>=20
> dmesg reports no errors
>=20
> Wireshark is happy
> <unknown-55MMMY.png>
> ifconfig reports more bytes sent, none received
> lowpan0   Link encap:UNSPEC  HWaddr =
22-62-94-95-CD-2E-5A-3A-00-00-00-00-00-00-00-00 =20
>           inet6 addr: fe80::2062:9495:cd2e:5a3a/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1=20
>           RX bytes:0 (0.0 B)  TX bytes:3205 (3.1 KiB)
>=20
> wpan0     Link encap:UNSPEC  HWaddr =
22-62-94-95-CD-2E-5A-3A-00-00-00-00-00-00-00-00 =20
>           UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:35 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:300=20
>           RX bytes:0 (0.0 B)  TX bytes:3176 (3.1 KiB)
>=20
>=20
> Now to add in the second RPi. After setting it up, ifconfig on the =
second RPi shows
> lowpan0   Link encap:UNSPEC  HWaddr =
82-B7-04-8B-DB-57-9E-E1-00-00-00-00-00-00-00-00 =20
>           inet6 addr: fe80::80b7:48b:db57:9ee1/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1=20
>           RX bytes:0 (0.0 B)  TX bytes:3237 (3.1 KiB)
>=20
> wpan0     Link encap:UNSPEC  HWaddr =
82-B7-04-8B-DB-57-9E-E1-00-00-00-00-00-00-00-00 =20
>           UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:35 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:300=20
>           RX bytes:0 (0.0 B)  TX bytes:3208 (3.1 KiB)
>=20
> dmesg shows no errors
>=20
> Wireshark shows errors on this second RPi
> <unknown-NU95LY.png>
> On the first Rpi, wireshark shows NOTHING. On the other hand, dmesg on =
the first RPi shows
> [ 3197.970150] ieee802154: bad frame received (type =3D 0)
> [ 3198.170317] ieee802154: bad frame received (type =3D 0)
> [ 3198.680961] ieee802154: bad frame received (type =3D 0)
> [ 3199.170489] ieee802154: bad frame received (type =3D 0)
> [ 3199.173315] ieee802154: bad frame received (type =3D 0)
> [ 3199.190078] ieee802154: bad frame received (type =3D 0)
> [ 3199.307879] ieee802154: bad frame received (type =3D 0)
> [ 3199.312959] ieee802154: bad frame received (type =3D 0)
> [ 3199.318120] ieee802154: bad frame received (type =3D 0)
> [ 3199.324555] ieee802154: bad frame received (type =3D 0)
> [ 3199.555055] ieee802154: bad frame received (type =3D 0)
>=20
> ifconfig on the first RPi now shows bytes received on wpan0 but not =
making it up to lowpan0=20
> I guess those are the dmesg errors
>> lowpan0   Link encap:UNSPEC  HWaddr =
22-62-94-95-CD-2E-5A-3A-00-00-00-00-00-00-00-00 =20
>>           inet6 addr: fe80::2062:9495:cd2e:5a3a/64 Scope:Link
>>           UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1=20
>>           RX bytes:0 (0.0 B)  TX bytes:3205 (3.1 KiB)
>>=20
>> wpan0     Link encap:UNSPEC  HWaddr =
22-62-94-95-CD-2E-5A-3A-00-00-00-00-00-00-00-00 =20
>>           UP BROADCAST RUNNING NOARP  MTU:123  Metric:1
>>           RX packets:34 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:35 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:300=20
>>           RX bytes:578 (578.0 B)  TX bytes:3176 (3.1 KiB)
>=20
> Finally trying ping6 from the first RPi to to the second.
>=20
>  $ ping6 fe80::80b7:48b:db57:9ee1%lowpan0
> PING fe80::80b7:48b:db57:9ee1%lowpan0(fe80::80b7:48b:db57:9ee1) 56 =
data bytes
> =46rom fe80::2062:9495:cd2e:5a3a icmp_seq=3D1 Destination unreachable: =
Address unreachable
> =46rom fe80::2062:9495:cd2e:5a3a icmp_seq=3D2 Destination unreachable: =
Address unreachable
> =46rom fe80::2062:9495:cd2e:5a3a icmp_seq=3D3 Destination unreachable: =
Address unreachable
> =46rom fe80::2062:9495:cd2e:5a3a icmp_seq=3D4 Destination unreachable: =
Address unreachable
>=20
> ifconfig on the first RPi show bytes transmitted, none received
> ifconfig on the second RPi shows bytes received by wpan0, none made it =
up to lowpan0
>=20
> dmesg on the first RPi shows no more errors
> dmesg on the second RPi shows errors
> [ 3801.036140] ieee802154: bad frame received (type =3D 0)
> [ 3802.031620] ieee802154: bad frame received (type =3D 0)
> [ 3803.031183] ieee802154: bad frame received (type =3D 0)
> [ 3804.041254] ieee802154: bad frame received (type =3D 0)
>=20
> Wireshark on the first RPi shows failure
> <unknown-78X6LY.png>
> Wireshark on the second RPi shows NOTHING (nothing made it up to =
lowpan0)
>=20
> The routing table on the first RPi looks ok
> $ route -A inet6
> Kernel IPv6 routing table
> Destination                    Next Hop                   Flag Met Ref =
Use If
> ::1/128                        ::                         U    256 0   =
  0 lo
> fe80::/64                      ::                         U    256 0   =
  0 eth0
> fe80::/64                      ::                         U    256 1   =
  9 lowpan0
> ::/0                           ::                         !n   -1  1   =
 26 lo
> ::1/128                        ::                         Un   0   5   =
 11 lo
> fe80::2062:9495:cd2e:5a3a/128  ::                         Un   0   3   =
 35 lo
> fe80::f698:e074:cc43:3109/128  ::                         Un   0   1   =
  0 lo
> ff00::/8                       ::                         U    256 3   =
281 eth0
> ff00::/8                       ::                         U    256 1   =
  9 lowpan0
> ::/0                           ::                         !n   -1  1   =
 26 lo
>=20
> The second RPi routing table looks okay too.
>=20
> I have seen comments about setting the SPI rate. The default rate is =
3000000. I'ev used it in all the above.=20
> Resetting it to 1000000 didn't make any difference, nor did 100000, by
> dtoverlay=3Dat86rf233,speed=3D100000
> in /boot/config.txt
>=20
> As you can see, I've tried a lot of things. What do I do now?
>=20
> Regards
>=20
> Jan
> --=20
> Dr Jan Newmarch,
> Head of Higher Education (ICT) @ Box Hill,
> Adjunct Professor @ University of Canberra
>=20
> P 61 3 9286 9971
> M +61 4 0117 0509
> F 61 3 9286 9100
> W www.boxhill.edu.au
> W jan.newmarch.name
> E j.newmarch@boxhill.edu.au
> E jan@newmarch.name
>=20
>=20
>=20
>=20

