Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:35576 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbbG0Pz3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 11:55:29 -0400
Received: by lahh5 with SMTP id h5so51774415lah.2
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 08:55:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6OZaGXCXi-K8vW01jtrYbD1ZSHdWCK+FSuAKr-WgQWrEg@mail.gmail.com>
References: <CAPpUg6PO+xLkZLBPp7WCgBoBx78uocJ_WUBez97fbqfiMNMe2w@mail.gmail.com>
	<CAPpUg6Pzyptjv-5ygaz8TqaZMiASKr7PR2j6mxt1SOuKs9bhsw@mail.gmail.com>
	<20150727093018.GB18090@omega>
	<CAPpUg6PBF9mSOkcNRdN-nqKPan+wmD5iQaMBqV0zpVDY+ccE3w@mail.gmail.com>
	<20150727102121.GC18090@omega>
	<CAPpUg6PnmbCitPQTL9YsJqPptnykRn_Nq-xbCYk1yegGwDToMQ@mail.gmail.com>
	<20150727103822.GD18090@omega>
	<CAPpUg6N0K-w_F0My0Wivi7W8MfYee-YSTr=8q2iDuFXFznQbtQ@mail.gmail.com>
	<20150727113054.GE18090@omega>
	<CAPpUg6OLEBfrMx6mA8ZptM-ohqhgbxS-V151hMP4O=61fQMTCw@mail.gmail.com>
	<20150727124220.GF18090@omega>
	<CAPpUg6MDArNF6Rpdv+XgOngFupru+RnEe5ujLgUuMejOmL3Y_w@mail.gmail.com>
	<CAPpUg6OZaGXCXi-K8vW01jtrYbD1ZSHdWCK+FSuAKr-WgQWrEg@mail.gmail.com>
Date: Mon, 27 Jul 2015 17:55:27 +0200
Message-ID: <CAPpUg6OxkeS4T1vkmdhcL4xYvCp7e-k+SkO2gvxxUOYV6t1qVw@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

2015-07-27 17:13 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
>>> Then forget that and make some at86rf230 driver debug messages. See
>>> "print_hex_dump" [0]. Add this add skb->data in at86rf230_xmit and
>>> at86rf230_rx_read_frame_complete (but after the skb is filled with data,
>>> otherwise it makes no sense).
>>>
>>> This will allow us to see what's the lowest layer is. If the transmit
>>> side looks correct, but receive side looks weird then I suppose
>>> something is wrong again with your spi setup.
>>>
>>> The reason is that we get the lowest dump of the transmitted and
>>> received buffer and nobody touched that buffer then.
>
> I dump the packet in at86rf230_xmit and
> at86rf230_rx_read_frame_complete (just before
> ieee802154_rx_irqsafe(lp->hw, skb, lqi)). This is wireshark analyse of
> the two packets. The first one is correct and comes from the sender,
> the second is from the receiver (I manually created the hex dump file)
> which is wrong! So something seem to occur when the frame goes to the
> transceiver.
> Those dump was created with :
> root@OpenWrt:/#ieee802154_rx_irqsafe(lp->hw, skb, lqi);
>
> No.     Time           Source                Destination
> Protocol Length Info
>       1 0.000000000    fe80::335d:7cf9:67f5:1017 ff02::1:ff3e:c7f1
> ICMPv6   64     Neighbor Solicitation for fe80::a8af:ac69:e53e:c7f1
> from 31:5d:7c:f9:67:f5:10:17
>
> Frame 1: 64 bytes on wire (512 bits), 64 bytes captured (512 bits) on
> interface 0
>     Interface id: 0
>     Packet flags: 0x00000000
>         .... .... .... .... .... .... .... ..00 = Direction: Not
> available (0x00000000)
>         .... .... .... .... .... .... ...0 00.. = Reception type: Not
> specified (0)
>         .... .... .... .... .... ...0 000. .... = FCS length: 0
>         .... .... .... .... 0000 000. .... .... = Reserved: 0
>         .... ...0 .... .... .... .... .... .... = CRC error: Not set
>         .... ..0. .... .... .... .... .... .... = Packet too long error: Not set
>         .... .0.. .... .... .... .... .... .... = Packet too short
> error: Not set
>         .... 0... .... .... .... .... .... .... = Wrong interframe gap
> error: Not set
>         ...0 .... .... .... .... .... .... .... = Unaligned frame error: Not set
>         ..0. .... .... .... .... .... .... .... = Start frame
> delimiter error: Not set
>         .0.. .... .... .... .... .... .... .... = Preamble error: Not set
>         0... .... .... .... .... .... .... .... = Symbol error: Not set
>     Encapsulation type: IEEE 802.15.4 Wireless PAN with FCS not present (127)
>     Arrival Time: Jul 25, 2015 00:54:17.000000000 CEST
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1437778457.000000000 seconds
>     [Time delta from previous captured frame: 0.000000000 seconds]
>     [Time delta from previous displayed frame: 0.000000000 seconds]
>     [Time since reference or first frame: 0.000000000 seconds]
>     Frame Number: 1
>     Frame Length: 64 bytes (512 bits)
>     Capture Length: 64 bytes (512 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     [Protocols in frame: wpan:6lowpan:ipv6:icmpv6]
>     [Number of per-protocol-data: 1]
>     [IEEE 802.15.4 Low-Rate Wireless PAN, key 0]
>     [Coloring Rule Name: ICMP]
>     [Coloring Rule String: icmp || icmpv6]
>
> IEEE 802.15.4 Data, Dst: Broadcast, Src: 31:5d:7cf9:67:f510:17
>     Frame Control Field: Data (0xc841)
>         .... .... .... .001 = Frame Type: Data (0x0001)
>         .... .... .... 0... = Security Enabled: False
>         .... .... ...0 .... = Frame Pending: False
>         .... .... ..0. .... = Acknowledge Request: False
>         .... .... .1.. .... = Intra-PAN: True
>         .... 10.. .... .... = Destination Addressing Mode: Short/16-bit (0x0002)
>         ..00 .... .... .... = Frame Version: 0
>         11.. .... .... .... = Source Addressing Mode: Long/64-bit (0x0003)
>     Sequence Number: 212
>     Destination PAN: 0xbeef
>     Destination: 0xffff
>     Extended Source: 31:5d:7cf9:67:f510:17 (31:5d:7c:f9:67:f5:10:17)
>
> 6LoWPAN
>     IPHC Header
>         011. .... = Pattern: IP header compression (0x03)
>         ...1 1... .... .... = Traffic class and flow label: Version,
> traffic class, and flow label compressed (0x0003)
>         .... .0.. .... .... = Next header: Inline
>         .... ..11 .... .... = Hop limit: 255 (0x0003)
>         .... .... 0... .... = Context identifier extension: False
>         .... .... .0.. .... = Source address compression: Stateless
>         .... .... ..11 .... = Source address mode: Compressed (0x0003)
>         .... .... .... 1... = Multicast address compression: True
>         .... .... .... .0.. = Destination address compression: Stateless
>         .... .... .... ..01 = Destination address mode: 48-bits inline (0x0001)
>         [Source context: fe80:: (fe80::)]
>         [Destination context: fe80:: (fe80::)]
>     Next header: ICMPv6 (0x3a)
>     Source: fe80::335d:7cf9:67f5:1017 (fe80::335d:7cf9:67f5:1017)
>     Destination: ff02::1:ff3e:c7f1 (ff02::1:ff3e:c7f1)
>
> Internet Protocol Version 6, Src: fe80::335d:7cf9:67f5:1017
> (fe80::335d:7cf9:67f5:1017), Dst: ff02::1:ff3e:c7f1
> (ff02::1:ff3e:c7f1)
>     0110 .... = Version: 6
>         [0110 .... = This field makes the filter "ip.version == 6" possible: 6]
>     .... 0000 0000 .... .... .... .... .... = Traffic class: 0x00000000
>         .... 0000 00.. .... .... .... .... .... = Differentiated
> Services Field: Default (0x00000000)
>         .... .... ..0. .... .... .... .... .... = ECN-Capable
> Transport (ECT): Not set
>         .... .... ...0 .... .... .... .... .... = ECN-CE: Not set
>     .... .... .... 0000 0000 0000 0000 0000 = Flowlabel: 0x00000000
>     Payload length: 40
>     Next header: ICMPv6 (58)
>     Hop limit: 255
>     Source: fe80::335d:7cf9:67f5:1017 (fe80::335d:7cf9:67f5:1017)
>     Destination: ff02::1:ff3e:c7f1 (ff02::1:ff3e:c7f1)
>     [Source GeoIP: Unknown]
>     [Destination GeoIP: Unknown]
>
> Internet Control Message Protocol v6
>     Type: Neighbor Solicitation (135)
>     Code: 0
>     Checksum: 0x6354 [correct]
>     Reserved: 00000000
>     Target Address: fe80::a8af:ac69:e53e:c7f1 (fe80::a8af:ac69:e53e:c7f1)
>     ICMPv6 Option (Source link-layer address : 31:5d:7c:f9:67:f5:10:17)
>         Type: Source link-layer address (1)
>         Length: 2 (16 bytes)
>         Link-layer address: 31:5d:7cf9:67:f510:17 (31:5d:7c:f9:67:f5:10:17)
>         Padding
>
>
>
> No.     Time           Source                Destination
> Protocol Length Info
>       2 0.000001000    f1:5d:7c:f9:e7:f5:10:f7 Broadcast
> IEEE 802.15.4 66     Data, Dst: Broadcast, Src: f1:5d:7cf9:e7:f510:f7
>
> Frame 2: 66 bytes on wire (528 bits), 66 bytes captured (528 bits) on
> interface 0
>     Interface id: 0
>     Packet flags: 0x00000000
>         .... .... .... .... .... .... .... ..00 = Direction: Not
> available (0x00000000)
>         .... .... .... .... .... .... ...0 00.. = Reception type: Not
> specified (0)
>         .... .... .... .... .... ...0 000. .... = FCS length: 0
>         .... .... .... .... 0000 000. .... .... = Reserved: 0
>         .... ...0 .... .... .... .... .... .... = CRC error: Not set
>         .... ..0. .... .... .... .... .... .... = Packet too long error: Not set
>         .... .0.. .... .... .... .... .... .... = Packet too short
> error: Not set
>         .... 0... .... .... .... .... .... .... = Wrong interframe gap
> error: Not set
>         ...0 .... .... .... .... .... .... .... = Unaligned frame error: Not set
>         ..0. .... .... .... .... .... .... .... = Start frame
> delimiter error: Not set
>         .0.. .... .... .... .... .... .... .... = Preamble error: Not set
>         0... .... .... .... .... .... .... .... = Symbol error: Not set
>     Encapsulation type: IEEE 802.15.4 Wireless PAN with FCS not present (127)
>     Arrival Time: Jul 25, 2015 00:54:17.000001000 CEST
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1437778457.000001000 seconds
>     [Time delta from previous captured frame: 0.000001000 seconds]
>     [Time delta from previous displayed frame: 0.000001000 seconds]
>     [Time since reference or first frame: 0.000001000 seconds]
>     Frame Number: 2
>     Frame Length: 66 bytes (528 bits)
>     Capture Length: 66 bytes (528 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     [Protocols in frame: wpan:data]
>     [Number of per-protocol-data: 1]
>     [IEEE 802.15.4 Low-Rate Wireless PAN, key 0]
>
> IEEE 802.15.4 Data, Dst: Broadcast, Src: f1:5d:7cf9:e7:f510:f7
>     Frame Control Field: Data (0xc841)
>         .... .... .... .001 = Frame Type: Data (0x0001)
>         .... .... .... 0... = Security Enabled: False
>         .... .... ...0 .... = Frame Pending: False
>         .... .... ..0. .... = Acknowledge Request: False
>         .... .... .1.. .... = Intra-PAN: True
>         .... 10.. .... .... = Destination Addressing Mode: Short/16-bit (0x0002)
>         ..00 .... .... .... = Frame Version: 0
>         11.. .... .... .... = Source Addressing Mode: Long/64-bit (0x0003)
>     Sequence Number: 252
>     Destination PAN: 0xbeef
>     Destination: 0xffff
>     Extended Source: f1:5d:7cf9:e7:f510:f7 (f1:5d:7c:f9:e7:f5:10:f7)
> Data (51 bytes)
>
> 0000  fb f9 3a 02 01 ff 3e c7 f1 87 00 63 54 00 00 00   ..:...>....cT...
> 0010  00 fe 80 00 00 00 00 00 00 a8 af ac 69 e5 3e c7   ............i.>.
> 0020  f1 ff 02 31 dd 7c f9 e7 f5 10 17 00 00 00 00 00   ...1.|..........
> 0030  00 5c 4c                                          .\L
>     Data: fbf93a0201ff3ec7f18700635400000000fe800000000000...
>     [Length: 51]
>
>
> --
> Baptiste


I've observed something, if I don't dump the sending packet, I receive
a different one on the receiver:
No.     Time           Source                Destination
Protocol Length Info
      1 0.000001000    ::639:10d1:8b6d:141e  ff01::ff:3ec7:f187
IGMPv0   66     Unknown Type:0x00

Frame 1: 66 bytes on wire (528 bits), 66 bytes captured (528 bits) on
interface 0
    Interface id: 0
    Packet flags: 0x00000000
        .... .... .... .... .... .... .... ..00 = Direction: Not
available (0x00000000)
        .... .... .... .... .... .... ...0 00.. = Reception type: Not
specified (0)
        .... .... .... .... .... ...0 000. .... = FCS length: 0
        .... .... .... .... 0000 000. .... .... = Reserved: 0
        .... ...0 .... .... .... .... .... .... = CRC error: Not set
        .... ..0. .... .... .... .... .... .... = Packet too long error: Not set
        .... .0.. .... .... .... .... .... .... = Packet too short
error: Not set
        .... 0... .... .... .... .... .... .... = Wrong interframe gap
error: Not set
        ...0 .... .... .... .... .... .... .... = Unaligned frame error: Not set
        ..0. .... .... .... .... .... .... .... = Start frame
delimiter error: Not set
        .0.. .... .... .... .... .... .... .... = Preamble error: Not set
        0... .... .... .... .... .... .... .... = Symbol error: Not set
    Encapsulation type: IEEE 802.15.4 Wireless PAN with FCS not present (127)
    Arrival Time: Jul 25, 2015 01:41:02.000001000 CEST
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1437781262.000001000 seconds
    [Time delta from previous captured frame: 0.000001000 seconds]
    [Time delta from previous displayed frame: 0.000001000 seconds]
    [Time since reference or first frame: 0.000001000 seconds]
    Frame Number: 1
    Frame Length: 66 bytes (528 bits)
    Capture Length: 66 bytes (528 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: wpan:6lowpan:ipv6:igmp]
    [Number of per-protocol-data: 1]
    [IEEE 802.15.4 Low-Rate Wireless PAN, key 0]
    [Coloring Rule Name: Routing]
    [Coloring Rule String: hsrp || eigrp || ospf || bgp || cdp || vrrp
|| gvrp || igmp || ismp]
IEEE 802.15.4 Data, Dst: Broadcast, Src: 04:39:10d1:8b:6d14:1e
    Frame Control Field: Data (0xc841)
        .... .... .... .001 = Frame Type: Data (0x0001)
        .... .... .... 0... = Security Enabled: False
        .... .... ...0 .... = Frame Pending: False
        .... .... ..0. .... = Acknowledge Request: False
        .... .... .1.. .... = Intra-PAN: True
        .... 10.. .... .... = Destination Addressing Mode: Short/16-bit (0x0002)
        ..00 .... .... .... = Frame Version: 0
        11.. .... .... .... = Source Addressing Mode: Long/64-bit (0x0003)
    Sequence Number: 132
    Destination PAN: 0xbeef
    Destination: 0xffff
    Extended Source: 04:39:10d1:8b:6d14:1e (04:39:10:d1:8b:6d:14:1e)
6LoWPAN
    IPHC Header
        011. .... = Pattern: IP header compression (0x03)
        ...1 1... .... .... = Traffic class and flow label: Version,
traffic class, and flow label compressed (0x0003)
        .... .0.. .... .... = Next header: Inline
        .... ..11 .... .... = Hop limit: 255 (0x0003)
        .... .... 1... .... = Context identifier extension: True
        .... .... .1.. .... = Source address compression: Stateful
        .... .... ..11 .... = Source address mode: Compressed (0x0003)
        .... .... .... 1... = Multicast address compression: True
        .... .... .... .0.. = Destination address compression: Stateless
        .... .... .... ..01 = Destination address mode: 48-bits inline (0x0001)
        0011 .... = Source context identifier: 0x03
        .... 1010 = Destination context identifier: 0x0a
        [Destination context: fe80:: (fe80::)]
    Next header: IGMP (0x02)
    Source: ::639:10d1:8b6d:141e (::639:10d1:8b6d:141e)
    Destination: ff01::ff:3ec7:f187 (ff01::ff:3ec7:f187)
Internet Protocol Version 6, Src: ::639:10d1:8b6d:141e
(::639:10d1:8b6d:141e), Dst: ff01::ff:3ec7:f187 (ff01::ff:3ec7:f187)
    0110 .... = Version: 6
        [0110 .... = This field makes the filter "ip.version == 6" possible: 6]
    .... 0000 0000 .... .... .... .... .... = Traffic class: 0x00000000
        .... 0000 00.. .... .... .... .... .... = Differentiated
Services Field: Default (0x00000000)
        .... .... ..0. .... .... .... .... .... = ECN-Capable
Transport (ECT): Not set
        .... .... ...0 .... .... .... .... .... = ECN-CE: Not set
    .... .... .... 0000 0000 0000 0000 0000 = Flowlabel: 0x00000000
    Payload length: 41
    Next header: IGMP (2)
    Hop limit: 255
    Source: ::639:10d1:8b6d:141e (::639:10d1:8b6d:141e)
    Destination: ff01::ff:3ec7:f187 (ff01::ff:3ec7:f187)
    [Source GeoIP: Unknown]
    [Destination GeoIP: Unknown]
Internet Group Management Protocol
    [IGMP Version: 0]
    Type: Unknown (0x00)
    Reply Pending: 70
    Header checksum: 0xef00 [incorrect, should be 0x6481]
    Identifier: 254
    Multicast Address: 128.0.0.0 (128.0.0.0)
    Access Key: 000000a8afac69e5
    Type: Unknown (0x00)
    Data

-- 
Baptiste
