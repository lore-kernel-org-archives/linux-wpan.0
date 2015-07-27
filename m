Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33010 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbbG0M3L (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 08:29:11 -0400
Received: by lbbyj8 with SMTP id yj8so52294874lbb.0
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 05:29:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150727113054.GE18090@omega>
References: <CAPpUg6NmUmNFvWMpvOuuB1LanD5r5t1NyugMsFfz=sfYUUgyiA@mail.gmail.com>
	<20150727083202.GA3071@omega>
	<CAPpUg6PO+xLkZLBPp7WCgBoBx78uocJ_WUBez97fbqfiMNMe2w@mail.gmail.com>
	<CAPpUg6Pzyptjv-5ygaz8TqaZMiASKr7PR2j6mxt1SOuKs9bhsw@mail.gmail.com>
	<20150727093018.GB18090@omega>
	<CAPpUg6PBF9mSOkcNRdN-nqKPan+wmD5iQaMBqV0zpVDY+ccE3w@mail.gmail.com>
	<20150727102121.GC18090@omega>
	<CAPpUg6PnmbCitPQTL9YsJqPptnykRn_Nq-xbCYk1yegGwDToMQ@mail.gmail.com>
	<20150727103822.GD18090@omega>
	<CAPpUg6N0K-w_F0My0Wivi7W8MfYee-YSTr=8q2iDuFXFznQbtQ@mail.gmail.com>
	<20150727113054.GE18090@omega>
Date: Mon, 27 Jul 2015 14:29:09 +0200
Message-ID: <CAPpUg6OLEBfrMx6mA8ZptM-ohqhgbxS-V151hMP4O=61fQMTCw@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

2015-07-27 13:30 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Mon, Jul 27, 2015 at 12:52:42PM +0200, Baptiste Clenet wrote:
>> 2015-07-27 12:38 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> > On Mon, Jul 27, 2015 at 12:31:28PM +0200, Baptiste Clenet wrote:
>> >> 2015-07-27 12:21 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> >> > On Mon, Jul 27, 2015 at 12:08:18PM +0200, Baptiste Clenet wrote:
>> >> > ...
>> >> >>
>> >> >> Receiving side:
>> >> >> [  176.921637] CID flag is set, increase header with one
>> >> >> [  176.931640] NH flag is set, next header carried inline: 02
>> >> >> [  176.942502] SAC bit is set. Handle context based source address.
>> >> >> [  176.954397]
>> >> >> [  176.957352] ieee802154 phy0 wpan0: SAM value 0x3 not supported
>> >> >>
>> >> >
>> >> > Yes this is not what it was transmitted before from the other node.
>> >> > That's why I would ask for some sniffing device, somewhere in the lower
>> >> > layers mac or phy it will fill your frame with garbage.
>> >> >
>> >> > I can't tell you now if it's the transmitted node or the receiving node.
>> >> > You need to debug it there.
>> >> Yeah, I agree.
>> >>
>> >> >
>> >> > To ensure the transmitted node don't send garbage I would like to check
>> >> > it with some sniffer device. If you see garbage on the sniffer device
>> >> > then it's something wrong with the transmitting.
>> >> Ok, but I did sniffing with monitor0 on the receiver as I mentioned earlier.
>> >> How may I sniff a packet ont the sender? Because I can't set up
>> >> lowpan0 on top of monitor0.
>> >> How may I sniff on lower layers?
>> >>
>> >
>> > In short:
>> >
>> > Monitor is just for sniffing, we don't parse any payload data on it. You
>> > can't create a lowpan interface on it, please use the L2 interface
>> > (wpan0). See [0], you maybe need a third node which running as monitor.
>>
>> I don't think I've got it, you want me to set up a network of 3 nodes with:
>> 1            2             3
>> sender   receiver    receiver
>> wpan0    wpan0      monitor0
>>
>> But I will see exactly the same things as earlier.
>
> You can save the dump (e.g. tshark I think with -w $FILE) somewhere or
> doing pipe via ssh, refer [0].
OpenWRT doesn't provide tshark.
I could use tcpdump instead but there is something I still don't get,
sorry. How can I sniff a packet I send? (Sniffing on the sender). If I
well-understand, to sniff I need to use monitor0 interface but when I
use it I can't use lowpan0 so I can't send ICMP packet and I can't
sniff.

>
> I don't know what "But I will see exactly the same things as earlier"
it means that the receiver will receive the same things as earlier and
I have already given to you the details about the message that
Wireshark gave me (which comes from the receiver).
> I
> don't know now if the sender transmit correct things and the receiver do
> some garbage then OR the sender already transmit incorrect data.
>
> When you have such dump file you can easily open this dump with
> wireshark, wireshark will autodetect the 6LoWPAN header then from the
> wpan interface and shows "hopefully" correct 6LoWPAN decompressed data
> (IPv6) which should be the same like what lowpan interface shows.
Yes, just need the dump now :-)

>
>> And I won't sniff phy layer.
>>
>
> Yes, we all don't want to decode the phy layer manually. :D I don't have
> the equipment and knowledge for doing this.
>
> - Alex
>
> [0] http://wpan.cakelab.org/#_sniffing



-- 
Baptiste
