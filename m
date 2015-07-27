Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:34169 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbG0Kba (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 06:31:30 -0400
Received: by lafd3 with SMTP id d3so35796090laf.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 03:31:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150727102121.GC18090@omega>
References: <20150724130747.GA6051@omega>
	<CAPpUg6NouBNDqfsZGYN9h-iuM8TSQD5+NdiqT-1_=1SzS8cacw@mail.gmail.com>
	<55B250E2.7020906@osg.samsung.com>
	<CAPpUg6MdwB_tN8nfDsWPas2rYFhkaue8N9rpSxgt4jPn_W8VYw@mail.gmail.com>
	<CAPpUg6NmUmNFvWMpvOuuB1LanD5r5t1NyugMsFfz=sfYUUgyiA@mail.gmail.com>
	<20150727083202.GA3071@omega>
	<CAPpUg6PO+xLkZLBPp7WCgBoBx78uocJ_WUBez97fbqfiMNMe2w@mail.gmail.com>
	<CAPpUg6Pzyptjv-5ygaz8TqaZMiASKr7PR2j6mxt1SOuKs9bhsw@mail.gmail.com>
	<20150727093018.GB18090@omega>
	<CAPpUg6PBF9mSOkcNRdN-nqKPan+wmD5iQaMBqV0zpVDY+ccE3w@mail.gmail.com>
	<20150727102121.GC18090@omega>
Date: Mon, 27 Jul 2015 12:31:28 +0200
Message-ID: <CAPpUg6PnmbCitPQTL9YsJqPptnykRn_Nq-xbCYk1yegGwDToMQ@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

2015-07-27 12:21 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Mon, Jul 27, 2015 at 12:08:18PM +0200, Baptiste Clenet wrote:
> ...
>>
>> Receiving side:
>> [  176.921637] CID flag is set, increase header with one
>> [  176.931640] NH flag is set, next header carried inline: 02
>> [  176.942502] SAC bit is set. Handle context based source address.
>> [  176.954397]
>> [  176.957352] ieee802154 phy0 wpan0: SAM value 0x3 not supported
>>
>
> Yes this is not what it was transmitted before from the other node.
> That's why I would ask for some sniffing device, somewhere in the lower
> layers mac or phy it will fill your frame with garbage.
>
> I can't tell you now if it's the transmitted node or the receiving node.
> You need to debug it there.
Yeah, I agree.

>
> To ensure the transmitted node don't send garbage I would like to check
> it with some sniffer device. If you see garbage on the sniffer device
> then it's something wrong with the transmitting.
Ok, but I did sniffing with monitor0 on the receiver as I mentioned earlier.
How may I sniff a packet ont the sender? Because I can't set up
lowpan0 on top of monitor0.
How may I sniff on lower layers?

Also, I would add that even if I change the destination IP, I still
receive the message. Shouldn't the transceiver blocks messages which
are not addressed to it?

>
> - Alex



-- 
Baptiste
