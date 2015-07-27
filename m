Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:34330 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbG0JFj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 05:05:39 -0400
Received: by lafd3 with SMTP id d3so34545243laf.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 02:05:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6PO+xLkZLBPp7WCgBoBx78uocJ_WUBez97fbqfiMNMe2w@mail.gmail.com>
References: <CAPpUg6PKMOBkfKWZjVaRKHHFGo+GXb3csewX+1OHg7CieyuVSw@mail.gmail.com>
	<20150724101842.GA7552@omega>
	<CAPpUg6P5SfTPVui=1SzLAk55O63ahH0bH8NHJ68WXPEzfwB=mg@mail.gmail.com>
	<20150724121331.GA7623@omega>
	<CAPpUg6O9weo-qwLUWqhUJc4e9ZMK2-6UKfSU4wvB7byXhELYOA@mail.gmail.com>
	<20150724130747.GA6051@omega>
	<CAPpUg6NouBNDqfsZGYN9h-iuM8TSQD5+NdiqT-1_=1SzS8cacw@mail.gmail.com>
	<55B250E2.7020906@osg.samsung.com>
	<CAPpUg6MdwB_tN8nfDsWPas2rYFhkaue8N9rpSxgt4jPn_W8VYw@mail.gmail.com>
	<CAPpUg6NmUmNFvWMpvOuuB1LanD5r5t1NyugMsFfz=sfYUUgyiA@mail.gmail.com>
	<20150727083202.GA3071@omega>
	<CAPpUg6PO+xLkZLBPp7WCgBoBx78uocJ_WUBez97fbqfiMNMe2w@mail.gmail.com>
Date: Mon, 27 Jul 2015 11:05:37 +0200
Message-ID: <CAPpUg6Pzyptjv-5ygaz8TqaZMiASKr7PR2j6mxt1SOuKs9bhsw@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

2015-07-27 10:58 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> 2015-07-27 10:32 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> Hi,
>>
>> On Mon, Jul 27, 2015 at 10:03:27AM +0200, Baptiste Clenet wrote:
>>> Here is what Wireshark gives me when I ping my board A from another
>>> board B (same kind of board with same image flashed):
>>>
>>> No.     Time           Source                       Destination
>>>    Protocol Length Info
>>> 8 37.192838000   ::6e47:e81e:40bf:d4f3   ff01::ff:3ec7:f187    IGMPv0
>>>  82     Unknown Type:0x00
>>>
>>> Frame 8: 82 bytes on wire (656 bits), 82 bytes captured (656 bits) on
>>> interface 0
>>>     Interface id: 0
>>>     Encapsulation type: Linux cooked-mode capture (25)
>>>     Arrival Time: Jul 24, 2015 15:28:52.786786000 CEST
>>>     [Time shift for this packet: 0.000000000 seconds]
>>>     Epoch Time: 1437744532.786786000 seconds
>>>     [Time delta from previous captured frame: 34.054126000 seconds]
>>>     [Time delta from previous displayed frame: 34.054126000 seconds]
>>>     [Time since reference or first frame: 37.192838000 seconds]
>>>     Frame Number: 8
>>>     Frame Length: 82 bytes (656 bits)
>>>     Capture Length: 82 bytes (656 bits)
>>>     [Frame is marked: False]
>>>     [Frame is ignored: False]
>>>     [Protocols in frame: sll:wpan:6lowpan:ipv6:igmp]
>>>     [Number of per-protocol-data: 1]
>>>     [IEEE 802.15.4 Low-Rate Wireless PAN, key 0]
>>>     [Coloring Rule Name: Routing]
>>>     [Coloring Rule String: hsrp || eigrp || ospf || bgp || cdp || vrrp
>>> || gvrp || igmp || ismp]
>>>
>>> Linux cooked capture
>>>     Packet type: Unicast to another host (3)
>>>     Link-layer address type: 805
>>>     Link-layer address length: 0
>>>     Protocol: IEEE 802.15.4 (0x00f6)
>>>
>>> IEEE 802.15.4 Data, Dst: Broadcast, Src: 6c:47:e81e:40:bfd4:f3
>>>     Frame Control Field: Data (0xc841)
>>>     Sequence Number: 80
>>>     Destination PAN: 0xbeef
>>>     Destination: 0xffff
>>>     Extended Source: 6c:47:e81e:40:bfd4:f3 (6c:47:e8:1e:40:bf:d4:f3)
>>>     FCS: 0xdff3 (Correct)
>>>
>>> 6LoWPAN
>>>     IPHC Header
>>>         011. .... = Pattern: IP header compression (0x03)
>>>         ...1 1... .... .... = Traffic class and flow label: Version,
>>> traffic class, and flow label compressed (0x0003)
>>>         .... .0.. .... .... = Next header: Inline
>>>         .... ..11 .... .... = Hop limit: 255 (0x0003)
>>>         .... .... 1... .... = Context identifier extension: True
>>>         .... .... .1.. .... = Source address compression: Stateful
>>>         .... .... ..11 .... = Source address mode: Compressed (0x0003)
>>>   //it is definitely 3
>>
>> I would do now some "instrumentations of pr_debug/printk/whatever"
>> inside of [0]. Always look for the iphc0/iphc1 if you want you can also
>> send some patches for doing a better a debugging handling there. Then
>> use simple the already introduced pr_debug mechanism.
>
> Here is the results of pr_debug enabled:
> root@OpenWrt:/# ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1
> PING fe80::a8af:ac69:e53e:c7f1(fe80::a8af:ac69:e53e:c7f1) from fe80::6e47:e81e:4
> [  138.949067] IPv6 header dump:
> [  138.949067]  version = 6
> [  138.949067]  length  = 40
> [  138.949067]  nexthdr = 0x3a
> [  138.949067]  hop_lim = 255
> [  138.949067]  dest    = ff02::1:ff3e:c7f1
> [  138.986374] Lowpan compression addr_type 33 source address
> fe80::6e47:e81e:40bf:d473
> [  139.004297] address compression 0 bits
> [  139.014467] source address unicast link-local
> fe80::6e47:e81e:40bf:d473 iphc1 0x30
> compressed to 6 octets.032192] destination address is multicast: : 56 data bytes
>
>
> [  139.050274] header len 9 skb 49
> [  139.056635] iphc0-iphc1 7b-39  //added instrumentation at the end
> of lowpan_header_compress)

Sorry for the previous alignement, better now:
[  139.948257] IPv6 header dump:
[  139.948257]  version = 6
[  139.948257]  length  = 40
[  139.948257]  nexthdr = 0x3a
[  139.948257]  hop_lim = 255
[  139.948257]  dest    = ff02::1:ff3e:c7f1
[  139.983059] Lowpan compression addr_type 33 source address
fe80::6e47:e81e:40bf:d473
[  139.998393] address compression 0 bits
[  140.005808] source address unicast link-local
fe80::6e47:e81e:40bf:d473 iphc1 0x30
[  140.020796] destination address is multicast: compressed to 6 octets

>
>>
>> And I would look into both nodes, for the sending node add
>> instrumentations inside "lowpan_header_compress" for receiving node add
>> instrumentations inside "lowpan_header_decompress".
>>
>>>         .... .... .... 1... = Multicast address compression: True
>>>         .... .... .... .0.. = Destination address compression: Stateless
>>>         .... .... .... ..01 = Destination address mode: 48-bits inline (0x0001)
>>>         0011 .... = Source context identifier: 0x03
>>>         .... 1010 = Destination context identifier: 0x0a
>>>         [Destination context: fe80:: (fe80::)]
>>>     Next header: IGMP (0x02)
>>>     Source: ::6e47:e81e:40bf:d4f3 (::6e47:e81e:40bf:d4f3)
>>>     Destination: ff01::ff:3ec7:f187 (ff01::ff:3ec7:f187)
>>>
>>> Internet Protocol Version 6, Src: ::6e47:e81e:40bf:d4f3
>>> (::6e47:e81e:40bf:d4f3), Dst: ff01::ff:3ec7:f187 (ff01::ff:3ec7:f187)
>>>     0110 .... = Version: 6
>>>     .... 0000 0000 .... .... .... .... .... = Traffic class: 0x00000000
>>>     .... .... .... 0000 0000 0000 0000 0000 = Flowlabel: 0x00000000
>>>     Payload length: 39
>>>     Next header: IGMP (2)
>>>     Hop limit: 255
>>>     Source: ::6e47:e81e:40bf:d4f3 (::6e47:e81e:40bf:d4f3)
>>>     Destination: ff01::ff:3ec7:f187 (ff01::ff:3ec7:f187)
>>>     [Source GeoIP: Unknown]
>>>     [Destination GeoIP: Unknown]
>>>
>>> Internet Group Management Protocol
>>>     [IGMP Version: 0]
>>>     Type: Unknown (0x00)
>>>     Reply Pending: 220
>>>     Header checksum: 0xe700 [incorrect, should be 0x63eb]
>>>     Identifier: 254
>>>     Multicast Address: 128.0.0.0 (128.0.0.0)
>>>     Access Key: 000000a8afac69e5
>>>     Type: Unknown (0x00)
>>>     Data
>>
>>
>> The complete IPv6 Header looks like garbage and does not look like some
>> ICMPv6 ping message.
> Ok, how should it be?
>
>>
>> - Alex
>>
>> [0] http://lxr.free-electrons.com/source/net/6lowpan/iphc.c#L233
>
>
>
> --
> Baptiste



-- 
Baptiste
