Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:39761 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbbCBO3l (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Mar 2015 09:29:41 -0500
Received: by widex7 with SMTP id ex7so15275626wid.4
        for <linux-wpan@vger.kernel.org>; Mon, 02 Mar 2015 06:29:40 -0800 (PST)
Date: Mon, 2 Mar 2015 15:29:36 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/3] ieee802154: 6lowpan: fix ARPHRD to
 ARPHRD_6LOWPAN
Message-ID: <20150302142933.GB2314@omega>
References: <1425305405-30706-1-git-send-email-alex.aring@gmail.com>
 <1425305405-30706-2-git-send-email-alex.aring@gmail.com>
 <54F470D2.30703@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54F470D2.30703@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Marc,

On Mon, Mar 02, 2015 at 03:16:50PM +0100, Marc Kleine-Budde wrote:
> On 03/02/2015 03:10 PM, Alexander Aring wrote:
> > Currently there exists two interface types with ARPHRD_IEEE802154. These
> > are the 802.15.4 interfaces and 802.15.4 6LoWPAN interfaces. This is
> > more a bug because some userspace applications checks on this value like
> > wireshark. This occurs that wireshark will always try to parse a lowpan
> > interface as 802.15.4 frames. With ARPHRD_6LOWPAN wireshark will parse
> > it as IPv6 frames which is correct.
> > 
> > Much applications checks on this value to readout the EUI64 mac address
> > which should be the same for ARPHRD_6LOWPAN. BTLE 6LoWPAN and ieee802154
> > 6LoWPAN will share now the same ARPHRD.
> 
> Does this have effects on libpcap/tcpdump and/or wireshark?
> 

The define ARPHRD_6LOWPAN is UAPI. It has effects on every application
which checks on the previous type ARPHRD_IEEE802154, but we can't still
longer use the same type for two interfaces which should be different.

Examples from my previous mail which was marked as RFC:

A little list of applications which need to update afterwards this
patch:

 - radvd [0]
 - unstrung [1]

[0] https://github.com/reubenhwk/radvd/blob/master/device-linux.c#L82
[1] https://github.com/mcr/unstrung/blob/5e7c4060730ab4f81ddcd75657d87ec78da91bd6/lib/libndmgmt/netlink.cpp#L358

These examples checks for EUI64 address which should be the same for
ARPHRD_6LOWPAN.

It would be problematic to check which is the underlaying interface
(It's 802.15.4 or BTLE) but I am sure we can get this information
somewhere else or via NETDEV devtype (SET_NETDEV_DEVTYPE).


For your exactly question, I think libpcap evaluate this. See:

https://github.com/the-tcpdump-group/libpcap/blob/master/pcap-linux.c#L3052

but I am not sure, in this example the change to ARPHRD_6LOWPAN is
correct because the interface doesn't have 802.15.4 frames, it's plain
IPv6 and upper without L2 information.

Somewhere is also an ARPHRD_IEEE802154_MONITOR type, which is also not
necessary by 802.15.4 frame. We should do it like the wireless monitor
implementation which set's some special flags to indenticate monitors.

But this is already UAPI, we can't delete it and now this should life in
UAPI headers forever. :-)

Does this answer your question?

- Alex
