Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728006AbeL1ILQ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 28 Dec 2018 03:11:16 -0500
Subject: Netlink userspace tools for LoRa(WAN), FSK, Sigfox, BLE, etc. (was:
 [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module)
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
 <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg4TGCaNUbq=_kFqmF5VNFR6rWHVBwO_5Fprt0u3m1O9g@mail.gmail.com>
 <CAJuUDwuYnuOs=7bs4h77XufqXLSWnZHVocR7vPYA1eor2HG+Cg@mail.gmail.com>
 <CAC=mGzgk0uSZRzE5NJ=FrLwaAkT3yYLb5j-0oFpouZ0YKFhtWQ@mail.gmail.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <f676c877-ba52-9171-c994-5a5e3735f45c@suse.de>
Date: Fri, 28 Dec 2018 09:11:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAC=mGzgk0uSZRzE5NJ=FrLwaAkT3yYLb5j-0oFpouZ0YKFhtWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ben Whitten <Ben.Whitten@lairdtech.com>, "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi Xue Liu,

Am 20.12.18 um 17:00 schrieb Jian-Hong Pan:
>> where can I find your current source code for these patches. I would
>> like to add netlink support based on them and at the same time to make
>> a user tool.
> 
> I am developing the patches based on Andreas' LoRa repository [1]
> You can apply the patches upon the "lora-next" branch.
> 
> I also wrote some testing programs.  But they are dirty now.

You can also find some of my testing code (test.c, nltest.c) here:

https://github.com/afaerber/lora-modules

I had envisioned nltest.c to evolve into a loraconfig tool for nllora
and then a lorawanconfig tool for nllorawan etc.


Jiri recently raised whether we might combine all that into a single
lpwanconfig tool. Tricky is that many of these technologies appear to
overlap (cf. slides 24 and 35 ff.).

https://events.linuxfoundation.org/wp-content/uploads/2017/12/ELCE2018_LoRa_final_Andreas-Farber.pdf

For instance, FSK/OOK are not really LPWAN technologies but are found on
LoRa chips and in LoRaWAN; but FSK also overlaps with 802.15.4 AFAIU,
which I guess already has its own userspace tool?

For Sigfox I'm not yet sure whether they need a socket interface at all?
Overlap here is the MM002 LoRa module (single antenna).

For NB-IoT the main trick appears to be getting the module out of reset,
and it might just get exposed as a tty, similar to what was proposed for
GNSS a while ago? Not sure how standard NB-IoT AT commands are, I only
have access to one (BC95) chipset so far. Haven't seen NB-IoT combined
with any other LPWAN technology yet, so we're hopefully safe for now
keeping it separate...

MIOTY appears to rely on SDR hardware, which seems to lack mainline
kernel drivers in the first place? Fraunhofer IIS (MP3) raises my doubts
of whether this'll be GPL-friendy, given that there's hardly any public
documentation beyond the ETSI TS-UNB specification, nor any code.

Weightless appeared to require SIG membership for implementations. There
did appear to be one AT command interface wrapping an implementation,
but I haven't had access to such hardware and, again, one is dangerous.

I couldn't quite figure out how BLE packets would fit in here: Would we
need to implement an HCI layer ourselves and use hciconfig on top? Or is
there any less work-intensive path to just push BLE PDU packets out our
radio if delivered to our netdev? For the 2.4 GHz SX128x LoRa modules
BLE is just another mode to switch to; for RF1276TS and RM186 it'll be a
secondary radio (i.e., separate netdev).

So not sure how many we can or want to shoehorn into a single tool...
A loraconfig tool handling both LoRa and LoRaWAN might be a good start,
plus switching to/from FSK, OOK, FLRC modes?

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
