Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.nordicsemi.no ([194.19.86.146]:43310 "EHLO
	ironport02.nordicsemi.no" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757288AbcASJGC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 19 Jan 2016 04:06:02 -0500
From: "Duda, Lukasz" <Lukasz.Duda@nordicsemi.no>
Subject: RE: [PATCH bluetooth-next 0/2] 6lowpan: stateful compression support
Date: Tue, 19 Jan 2016 09:05:59 +0000
Message-ID: <AB80DA35A7B64E4E98291794926897D9011C354BCD@mbx06.nvlsi.no>
References: <1452459025-13884-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1452459025-13884-1-git-send-email-alex.aring@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "mcr@sandelman.ca" <mcr@sandelman.ca>, "Bakke, Glenn Ruben" <Glenn.Ruben.Bakke@nordicsemi.no>

Hi Alex,

> Hi,
> 
> this contains at first some small fix for the netdev notifier which I deteced
> while hacking 6lowpan stateful compression support.
> 
> I rework the debugfs entry for the stateful compression. Now each context
> entry for a 6LoWPAN contains has his own subdirectory (named as his CID
> value).
> In this subdirectories there exists the following files for manipulating the
> context entry:
> 
>  - active: If the context belongs to the table or not.
>  - compression: the compression flag according rfc6775.
>  - prefix: ipv6 prefix in xxxx:xxxx:....:xxxx form.
>  - prefix_lenght: the length of the ipv6 prefix.
> 
> This offers a setting per property instead doing remember the full context and
> doing echo "$FULL_CONTEXT_INFORMATION" > ctx_table.
> 
> These file should be prepared to move into the sysfs directory when it seems
> to running fine.
> 
> There exist one file "show" inside $LOWPAN_IFACE/contexts/. This file is for a
> "pretty-printout" for the current context table. I use the same format-string
> like RIOT-OS, example:
> 
> cid|prefix                                     |C
> -------------------------------------------------
>   0|                                 2001::/64 |1
>   1|                                2001::1/128|1
>   2|                                2001::5/128|1
>   7|                                 2002::/64 |1
> 
> 
> difference here is that RIOT shows the lifetime, but I currently see no sense to
> handle the lifetime in kernelspace.
> 
> Also I added support to clean the context table when doing a "ifdown". The
> reason is that IPv6 interface will also drop all address information while doing
> a ifdown and a 6LoWPAN should not use previous context information after
> ifup again.
> 
> - Alex
> 
> Alexander Aring (2):
>   6lowpan: iphc: add support for stateful compression
>   ieee802154: 6lowpan: fix return of netdev notifier
> 
>  include/net/6lowpan.h         |  31 ++++
>  net/6lowpan/core.c            |  39 +++-
>  net/6lowpan/debugfs.c         | 247 +++++++++++++++++++++++++
>  net/6lowpan/iphc.c            | 420
> ++++++++++++++++++++++++++++++++++++------
>  net/ieee802154/6lowpan/core.c |   7 +-
>  5 files changed, 682 insertions(+), 62 deletions(-)
> 
> --
> 2.6.1

Thanks for the great work you have done!

I have tested the latest stateful compression module, and it works very
well! One note is that the "C" flag, in the debugfs entry "show", list
active state instead of compression state. However this is a minor and I
will highlight it in the PATCH 1/2 mail.

The context table was set up with 2 entries, using CID 0 and 15:

cid|prefix                                     |C
-------------------------------------------------
  0|                             2001:db8::/64 |1
 15|                            2001:db8::1/128|1

Device setup:

Linux computer (bt0)
 - Address: 2001:db8::1/64

Device A
 - CID 0, compression ON
 - CID 15, compression OFF
 - Address: 2001:db8::MAC/64
 
Device B
 - CID 0, compression ON
 - CID 15, compression OFF
 - Address: 2001:db8::MAC/64
 
Device C
 - No CIDs
 - Address: 2001:db8::MAC/64
 
Scenario 1:
ping6 <A> -s 0 -c 1 
TX: Full compression of source and dest 
RX: Full compression of source and dest

Scenario 2: 
ping6 <B> -s 0 -c 1
TX: Full compression of source and dest
RX: Compression of source, half compression of dest (bt0)

Scenario 3: 
- Disable CID
echo 0 > /sys/kernel/debug/6lowpan/bt0/contexts/0/active
echo 0 > /sys/kernel/debug/6lowpan/bt0/contexts/15/active

ping6 <C> -s 0 -c 1
TX: No compression
RX: No compression

Scenario 4:
- Adjust prefix length on CID 0 to prefix_len 32.
echo 32 > /sys/kernel/debug/6lowpan/bt0/contexts/0/prefix_len
echo 1 > /sys/kernel/debug/6lowpan/bt0/contexts/0/active
echo 1 > /sys/kernel/debug/6lowpan/bt0/contexts/15/active

ping6 <A> -s 0 -c 1
TX: Full compression of source and dest
RX: Full compression of source and dest

Regards,
Lukasz
