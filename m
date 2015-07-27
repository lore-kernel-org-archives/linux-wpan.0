Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34696 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbbG0MpH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 08:45:07 -0400
Received: by lafd3 with SMTP id d3so37829050laf.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 05:45:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150727124220.GF18090@omega>
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
Date: Mon, 27 Jul 2015 14:45:05 +0200
Message-ID: <CAPpUg6MDArNF6Rpdv+XgOngFupru+RnEe5ujLgUuMejOmL3Y_w@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

2015-07-27 14:42 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Mon, Jul 27, 2015 at 02:29:09PM +0200, Baptiste Clenet wrote:
>> 2015-07-27 13:30 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> > On Mon, Jul 27, 2015 at 12:52:42PM +0200, Baptiste Clenet wrote:
>> >> 2015-07-27 12:38 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> >> > On Mon, Jul 27, 2015 at 12:31:28PM +0200, Baptiste Clenet wrote:
>> >> >> 2015-07-27 12:21 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> >> >> > On Mon, Jul 27, 2015 at 12:08:18PM +0200, Baptiste Clenet wrote:
>> >> >> > ...
>> >> >> >>
>> >> >> >> Receiving side:
>> >> >> >> [  176.921637] CID flag is set, increase header with one
>> >> >> >> [  176.931640] NH flag is set, next header carried inline: 02
>> >> >> >> [  176.942502] SAC bit is set. Handle context based source address.
>> >> >> >> [  176.954397]
>> >> >> >> [  176.957352] ieee802154 phy0 wpan0: SAM value 0x3 not supported
>> >> >> >>
>> >> >> >
>> >> >> > Yes this is not what it was transmitted before from the other node.
>> >> >> > That's why I would ask for some sniffing device, somewhere in the lower
>> >> >> > layers mac or phy it will fill your frame with garbage.
>> >> >> >
>> >> >> > I can't tell you now if it's the transmitted node or the receiving node.
>> >> >> > You need to debug it there.
>> >> >> Yeah, I agree.
>> >> >>
>> >> >> >
>> >> >> > To ensure the transmitted node don't send garbage I would like to check
>> >> >> > it with some sniffer device. If you see garbage on the sniffer device
>> >> >> > then it's something wrong with the transmitting.
>> >> >> Ok, but I did sniffing with monitor0 on the receiver as I mentioned earlier.
>> >> >> How may I sniff a packet ont the sender? Because I can't set up
>> >> >> lowpan0 on top of monitor0.
>> >> >> How may I sniff on lower layers?
>> >> >>
>> >> >
>> >> > In short:
>> >> >
>> >> > Monitor is just for sniffing, we don't parse any payload data on it. You
>> >> > can't create a lowpan interface on it, please use the L2 interface
>> >> > (wpan0). See [0], you maybe need a third node which running as monitor.
>> >>
>> >> I don't think I've got it, you want me to set up a network of 3 nodes with:
>> >> 1            2             3
>> >> sender   receiver    receiver
>> >> wpan0    wpan0      monitor0
>> >>
>> >> But I will see exactly the same things as earlier.
>> >
>> > You can save the dump (e.g. tshark I think with -w $FILE) somewhere or
>> > doing pipe via ssh, refer [0].
>> OpenWRT doesn't provide tshark.
>> I could use tcpdump instead but there is something I still don't get,
>> sorry. How can I sniff a packet I send? (Sniffing on the sender). If I
>> well-understand, to sniff I need to use monitor0 interface but when I
>> use it I can't use lowpan0 so I can't send ICMP packet and I can't
>> sniff.
>>
>
> This is correct. The transceiver goes into promiscuous mode and in
> short: you cannot operate as node in the same time then.
>
> Then forget that and make some at86rf230 driver debug messages. See
> "print_hex_dump" [0]. Add this add skb->data in at86rf230_xmit and
> at86rf230_rx_read_frame_complete (but after the skb is filled with data,
> otherwise it makes no sense).
>
> This will allow us to see what's the lowest layer is. If the transmit
> side looks correct, but receive side looks weird then I suppose
> something is wrong again with your spi setup.
>
> The reason is that we get the lowest dump of the transmitted and
> received buffer and nobody touched that buffer then.
>
>> >
>> > I don't know what "But I will see exactly the same things as earlier"
>> it means that the receiver will receive the same things as earlier and
>> I have already given to you the details about the message that
>> Wireshark gave me (which comes from the receiver).
>
> Now with these sentence it looks like what I said above. The transmit
> buffer looks correct, but the receive buffer looks completely different.
>
> You cannot debug in upper layers and then say "It's the same whats was
> on the air". Please confirm this by debugging the driver layer and
> dumping the frame buffer on receiving and transmitting, which is the
> lowest layer which we can debug. (Maybe we should add some debug switch
> for that in at86rf230 driver).
>
> If transmit looks correct and the receiving buffer looks completely
> different than what was transmitted before. Then this is not an issue
> with mac802154/6LoWPAN stack. Something is broken then with spi/cable
> connectors/whatever I don't know.
>
Thank you for the clarification :-). I have the feeling that spi does
some magic again...

> - Alex
>
> [0] http://lxr.free-electrons.com/source/include/linux/printk.h#L429



-- 
Baptiste
