Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33570 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbG0ID3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 04:03:29 -0400
Received: by laah7 with SMTP id h7so44031706laa.0
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 01:03:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPpUg6MdwB_tN8nfDsWPas2rYFhkaue8N9rpSxgt4jPn_W8VYw@mail.gmail.com>
References: <CAPpUg6PNNipdf-kXvy9EOo6_8HtauGXMR0WAjXG_gY82DQEY_g@mail.gmail.com>
	<20150724083106.GA2655@omega>
	<CAPpUg6MGJ6Mevu3NGMf3RqKu7Hxphk7C+WiUwEnJzDa5x56JYg@mail.gmail.com>
	<CAPpUg6M8rOP5mDNmFwcz1-cp=MhDhW1Yw5d2+YPCTy4sY4yGoQ@mail.gmail.com>
	<20150724094804.GA6561@omega>
	<CAPpUg6PKMOBkfKWZjVaRKHHFGo+GXb3csewX+1OHg7CieyuVSw@mail.gmail.com>
	<20150724101842.GA7552@omega>
	<CAPpUg6P5SfTPVui=1SzLAk55O63ahH0bH8NHJ68WXPEzfwB=mg@mail.gmail.com>
	<20150724121331.GA7623@omega>
	<CAPpUg6O9weo-qwLUWqhUJc4e9ZMK2-6UKfSU4wvB7byXhELYOA@mail.gmail.com>
	<20150724130747.GA6051@omega>
	<CAPpUg6NouBNDqfsZGYN9h-iuM8TSQD5+NdiqT-1_=1SzS8cacw@mail.gmail.com>
	<55B250E2.7020906@osg.samsung.com>
	<CAPpUg6MdwB_tN8nfDsWPas2rYFhkaue8N9rpSxgt4jPn_W8VYw@mail.gmail.com>
Date: Mon, 27 Jul 2015 10:03:27 +0200
Message-ID: <CAPpUg6NmUmNFvWMpvOuuB1LanD5r5t1NyugMsFfz=sfYUUgyiA@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Here is what Wireshark gives me when I ping my board A from another
board B (same kind of board with same image flashed):

No.     Time           Source                       Destination
   Protocol Length Info
8 37.192838000   ::6e47:e81e:40bf:d4f3   ff01::ff:3ec7:f187    IGMPv0
 82     Unknown Type:0x00

Frame 8: 82 bytes on wire (656 bits), 82 bytes captured (656 bits) on
interface 0
    Interface id: 0
    Encapsulation type: Linux cooked-mode capture (25)
    Arrival Time: Jul 24, 2015 15:28:52.786786000 CEST
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1437744532.786786000 seconds
    [Time delta from previous captured frame: 34.054126000 seconds]
    [Time delta from previous displayed frame: 34.054126000 seconds]
    [Time since reference or first frame: 37.192838000 seconds]
    Frame Number: 8
    Frame Length: 82 bytes (656 bits)
    Capture Length: 82 bytes (656 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: sll:wpan:6lowpan:ipv6:igmp]
    [Number of per-protocol-data: 1]
    [IEEE 802.15.4 Low-Rate Wireless PAN, key 0]
    [Coloring Rule Name: Routing]
    [Coloring Rule String: hsrp || eigrp || ospf || bgp || cdp || vrrp
|| gvrp || igmp || ismp]

Linux cooked capture
    Packet type: Unicast to another host (3)
    Link-layer address type: 805
    Link-layer address length: 0
    Protocol: IEEE 802.15.4 (0x00f6)

IEEE 802.15.4 Data, Dst: Broadcast, Src: 6c:47:e81e:40:bfd4:f3
    Frame Control Field: Data (0xc841)
    Sequence Number: 80
    Destination PAN: 0xbeef
    Destination: 0xffff
    Extended Source: 6c:47:e81e:40:bfd4:f3 (6c:47:e8:1e:40:bf:d4:f3)
    FCS: 0xdff3 (Correct)

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
  //it is definitely 3
        .... .... .... 1... = Multicast address compression: True
        .... .... .... .0.. = Destination address compression: Stateless
        .... .... .... ..01 = Destination address mode: 48-bits inline (0x0001)
        0011 .... = Source context identifier: 0x03
        .... 1010 = Destination context identifier: 0x0a
        [Destination context: fe80:: (fe80::)]
    Next header: IGMP (0x02)
    Source: ::6e47:e81e:40bf:d4f3 (::6e47:e81e:40bf:d4f3)
    Destination: ff01::ff:3ec7:f187 (ff01::ff:3ec7:f187)

Internet Protocol Version 6, Src: ::6e47:e81e:40bf:d4f3
(::6e47:e81e:40bf:d4f3), Dst: ff01::ff:3ec7:f187 (ff01::ff:3ec7:f187)
    0110 .... = Version: 6
    .... 0000 0000 .... .... .... .... .... = Traffic class: 0x00000000
    .... .... .... 0000 0000 0000 0000 0000 = Flowlabel: 0x00000000
    Payload length: 39
    Next header: IGMP (2)
    Hop limit: 255
    Source: ::6e47:e81e:40bf:d4f3 (::6e47:e81e:40bf:d4f3)
    Destination: ff01::ff:3ec7:f187 (ff01::ff:3ec7:f187)
    [Source GeoIP: Unknown]
    [Destination GeoIP: Unknown]

Internet Group Management Protocol
    [IGMP Version: 0]
    Type: Unknown (0x00)
    Reply Pending: 220
    Header checksum: 0xe700 [incorrect, should be 0x63eb]
    Identifier: 254
    Multicast Address: 128.0.0.0 (128.0.0.0)
    Access Key: 000000a8afac69e5
    Type: Unknown (0x00)
    Data

Which are all the ways to change the SAM value? It is definitely
changed somehow before sending.

2015-07-24 17:14 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
> 2015-07-24 16:51 GMT+02:00 Stefan Schmidt <stefan@osg.samsung.com>:
>> Hello.
>>
>> On 24/07/15 16:45, Baptiste Clenet wrote:
>>>
>>> 2015-07-24 15:07 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>>>>
>>>> On Fri, Jul 24, 2015 at 02:53:52PM +0200, Baptiste Clenet wrote:
>>>> ...
>>>>>
>>>>> Yes if SAC = 1, SAM should be 0 I agree.
>>>>>
>>>>> Is that somehow possible that I send ihpc of 7b39 (taken at the end of
>>>>> lowpan_header_compress) and I receive and iphc of 7bf9 (taken at the
>>>>> begginning of lowpan_header_decompress) every time??
>>>>>
>>>> So far I know that is not possible. I think you need to debug it, do you
>>>> have maybe some kind of monitor interface to see what on the air?
>>>>
>>> Here is what tcpdump gives me when I receive a message:
>>>
>>> 13:15:40.253868   P ethertype Unknown (0x00f6), length 82:
>>>          0x0000:  41c8 13ef beff ff56 7863 ed54 89a7 cffb  A
>>> ......Vxc.T....
>>>          0x0010:  f93a 0201 ff34 1234 8700 a5ee 0000 0000
>>> .:...4.4........
>>>          0x0020:  fe80 0000 0000 0000 1234 1234 1234 1234
>>> .........4.4.4.4
>>>          0x0030:  0102 cfa7 8954 ede3 7856 0000 0000 0000
>>> .....T..xV......
>>>          0x0040:  05c7
>>>
>>> There is neither 7b39 or  7bf9.
>>> Can't use tshark on openwrt.
>>
>>
>> That makes it harder as neccassary for debugging. Either try to use
>> something like netcat to bring the stream to you host and look at it with
>> wireshark or save it as pcap file, transfer it to your host and look at it
>> with wireshark.
>>
>> Doing it like above is really error prone. Why would you make your life
>> harder as you should? :)
>
> Ok, will try with netcat as soon as I can, thanks.
>
>>
>>>
>>> Btw, why can't I add  lowpan0 on top of monitor0?
>>> root@OpenWrt:/# ip link add link monitor0 name lowpan0 type lowpan
>>> RTNETLINK answers: Invalid argument
>>
>>
>> Hmm, why would you want to do that? A monitor interface should give you all
>> the information you need during sniffing. For what do you want to add a
>> lowpan interface on top?
>
> I would like to send IPV6 packet (ping6) through the interface lowpan0.
>
> I think I misunderstood something here about sniffing packet and
> interface. Should I have lowpan monitor interface instead of the wpan
> monitor?
>
>>
>> regards
>> Stefan Schmidt
>
>
>
> --
> Baptiste



-- 
Baptiste
