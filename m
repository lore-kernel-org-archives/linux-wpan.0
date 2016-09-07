Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53830 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752900AbcIGNuz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 7 Sep 2016 09:50:55 -0400
Subject: Re: Regarding IPSP over GATT Support in blueZ
References: <MAXPR01MB0218AF3FE3A6214F17D9047090ED0@MAXPR01MB0218.INDPRD01.PROD.OUTLOOK.COM>
 <CABBYNZLLpO0TcozFuvorwCZOOAKr=96NJhZBoLxjeUgdM+G2UA@mail.gmail.com>
 <MAXPR01MB0218E7395A5709B7785514FC90E20@MAXPR01MB0218.INDPRD01.PROD.OUTLOOK.COM>
 <CAB_54W4k7MBVSfp07nbhb8ugwCbX1w_DwmUQamqoY6DiVEiD=A@mail.gmail.com>
 <CAB_54W6jaFDqzCwUOqRJsBV5AWU+Fa0OPiXHeUg5UOeT1qFomw@mail.gmail.com>
 <MAXPR01MB02183664D9BD360723CD0B3190F90@MAXPR01MB0218.INDPRD01.PROD.OUTLOOK.COM>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <97c1abb2-4551-7adb-8686-e182494c350c@pengutronix.de>
Date: Wed, 7 Sep 2016 15:50:53 +0200
MIME-Version: 1.0
In-Reply-To: <MAXPR01MB02183664D9BD360723CD0B3190F90@MAXPR01MB0218.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Amith Raghunath <Amith.Raghunath@mindtree.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On 09/06/2016 01:50 PM, Amith Raghunath wrote:
> Hi Alex,
> 
>> 2016-09-04 20:13 GMT+02:00 Alexander Aring <alex.aring@xxxxxxxxx>:
>>>
>>> 2016-09-01 17:49 GMT+02:00 Amith Raghunath <Amith.Raghunath@xxxxxxxxx>:
>>>>
>>>>
>>>> 1. The 6LBR has to forward the packets sent by one node to another node based on the link-local address. Is this scenario supported in the present code base ?
>>>
>>>
>>> so far I know, no.
>>>
> 
> In RFC7668 it states that " 6LNs connected to the same 6LBR have to communicate with each other by
> using the shared prefix used on the subnet."
> It is not the link-local address that was referring to in the earlier query, kindly let me know whether this shared prefix feature and the 6LBR routing mechanism based on this shared prefix is yet to be implemented. I checked the net/bluetooth/6lowpan.c of linux kernel 4.7.1, could not find this feature. This would be required to support the "Isolated Bluetooth LE Network" topology.
> 

Is this not simple run some Router Advertisment Daemon, e.g. radvd on
the 6LBR Node and then putting a PIO into the RA messages. Maybe a ULA
prefix for your $SUBNET? Then you have the routing mechanism based on
your prefix.

Additional you could also add a 6CO to compress the used prefix. See
forked radvd branch [0] which used a non-stable UAPI to provide access
to 6LoWPAN stateful compression.

---

for the link-local case I through it must be possible to access 6LN's
over it's their link-local address. Example

6LN(A) <---> 6LBR <---> 6LN(B)

so it must be possible somehow to have a connection from A to B by using
the link-local address. But RFC7668 says:

"6LN-to-6LN communications using link-local addresses are not possible."

So I think it's simple not possible and you must do the shared prefix
and this is what you want (I think I finally understand), but this is not
the job of 6LoWPAN subsystem - you need to do right IPv6 setup.

- Alex

[0] https://github.com/linux-wpan/radvd/tree/6lowpan
