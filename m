Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:37833 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeL1Ptp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 28 Dec 2018 10:49:45 -0500
Received: by mail-io1-f68.google.com with SMTP id g8so5664305iok.4
        for <linux-wpan@vger.kernel.org>; Fri, 28 Dec 2018 07:49:45 -0800 (PST)
Date: Fri, 28 Dec 2018 10:49:41 -0500
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: Netlink userspace tools for LoRa(WAN), FSK, Sigfox, BLE, etc.
 (was: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module)
Message-ID: <20181228154941.v7lvsh43kjqqowe7@x220t>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
 <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg4TGCaNUbq=_kFqmF5VNFR6rWHVBwO_5Fprt0u3m1O9g@mail.gmail.com>
 <CAJuUDwuYnuOs=7bs4h77XufqXLSWnZHVocR7vPYA1eor2HG+Cg@mail.gmail.com>
 <CAC=mGzgk0uSZRzE5NJ=FrLwaAkT3yYLb5j-0oFpouZ0YKFhtWQ@mail.gmail.com>
 <f676c877-ba52-9171-c994-5a5e3735f45c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f676c877-ba52-9171-c994-5a5e3735f45c@suse.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc: Xue Liu <liuxuenetmail@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ben Whitten <Ben.Whitten@lairdtech.com>, "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On Fri, Dec 28, 2018 at 09:11:11AM +0100, Andreas Färber wrote:
...
> 
> For instance, FSK/OOK are not really LPWAN technologies but are found on
> LoRa chips and in LoRaWAN; but FSK also overlaps with 802.15.4 AFAIU,
> which I guess already has its own userspace tool?
> 

as to clarify that, our userspace tool is based on the wireless iw tool.
If you are tight to nl802154/nl80211 I would recommend it to do the
same, it's well tested code.

Original idea was to put our userspace tool as part of iw, we decided to
fork iw for now with still have the possibility to merge with iw
together when the IEEE 802.15.4 becomes more stable, if wireless
community agree's to that.

- Alex
