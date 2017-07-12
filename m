Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36467 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753006AbdGLPvW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Jul 2017 11:51:22 -0400
Received: by mail-wr0-f173.google.com with SMTP id c11so38917714wrc.3
        for <linux-wpan@vger.kernel.org>; Wed, 12 Jul 2017 08:51:21 -0700 (PDT)
Date: Wed, 12 Jul 2017 17:51:11 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Applications on wpan-linux
Message-ID: <20170712155110.itv5gqc4ohnh5lrz@omega>
References: <CAJuUDws4t0mSS4mONnXs=b9QLF28w9CTfQE-+2QKMnHg8_5HmA@mail.gmail.com>
 <b3e88cdb-59f7-5915-6abe-36c5b6cfc8ef@osg.samsung.com>
 <28959.1499804094@dooku.sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28959.1499804094@dooku.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On Tue, Jul 11, 2017 at 04:14:54PM -0400, Michael Richardson wrote:
> 
> {cleaning my inbox}
> 
> Stefan Schmidt <stefan@osg.samsung.com> wrote:
>     > If I understand this correctly you want to send out beacons to announce
>     > a 15.4 network and do basic PAN coordinator tasks like handing out
>     > short addresses and keeping track of devices within the PAN. Is that
>     > correct?
> 
>     > We do not have this functionality right now. All communication is
>     > ad-hoc and based knowing network parameters like channel, etc.
> 
> I feel that perhaps linux-wpan@ is not a focused enough group to actually get
> this work done.  Perhaps we simply lack a bit of common marketing?
> Maybe a silly single page web site with the ubiquitous "fork me on github"
> banner.  Maybe that already exists and is poorly marketed such that I don't
> even know about it.
> 

About marketing: I think we need to make some tutorial for RIOT/Contiki
to build e.g. a broder router. All others IoT MCU OS's make their own
Border Router solution and feed their IPv6 Stack on $MCU_IOT_OS over
SLIP and they do marketing with that.

What already happen is that people which using such stuff reports BUGs
to linux-wpan, because they think they actually using Linux 6LoWPAN
which they don't do. :(

Making everything in a state that a simple raspbian can be turned into a
RPL Border Router for Contiki/RIOT OS would be marketing enough I think.
We just need to remove the barriers which we have now, then write wiki
page and propagate it. Not an easy work...

>     > Various steps are needed to get to the functionality you are looking
>     > for. 1) Add support for MAC command frames for network management, 2)
>     > add support for beacon frames 3) expose a netlink UAPI to act as a PAN
>     > coordinator and 4) a coordinator daemon in userspace.
> 
> At this point, I don't quite recall the summary of solutions that we came
> home from NetDev with.  I meant to watch the video to learn what we said :-)
> 

did we talked about that @netdev? :-) We talked mostly about RPL, but
coordinator stuff? In the early days of IEEE 802.15.4 (with sourceforge
kernel stuff which never came into mainline) we hat some _basic_
assoc/deassoc coordinator functionality. With a userspace daemon which
knows which short addresses was still available etc. In short: It was
very orianted to hostapd e.g. 802.11 to run an access point.

I am not so an expert for that, but all MLME-ops (algorithmn to do
assoc/deassoc described by 802.15.4) can be triggered then by a netlink
cmd. E.g. MLME-SCAN (similar to 802.11) can be handled very asynchronous
with START/STOP/ABORT and netlink EVENT callback if some $COORDINATOR
was found.

I think MLME-SCAN would be a _really_ simple MLME-ops where we can start
and lookup architecture from 802.11. Now I need just a 802.15.4 stack
which supports coordinator so I can test it. :-) (Maybe some HardMAC
transceiver?). I don't have any hardware here which can run a
coordinator supported 802.15.4 stack, but maybe we don't need it and just
lookup the 802.15.4 spec for now...

- Alex
