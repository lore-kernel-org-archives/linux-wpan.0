Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38784 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbbDLWW5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 12 Apr 2015 18:22:57 -0400
Received: by wiun10 with SMTP id n10so47876134wiu.1
        for <linux-wpan@vger.kernel.org>; Sun, 12 Apr 2015 15:22:56 -0700 (PDT)
Date: Mon, 13 Apr 2015 00:22:53 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 wpan-misc] website: add opentask section in developing
Message-ID: <20150412222252.GB1046@omega>
References: <1428833788-3391-1-git-send-email-alex.aring@gmail.com>
 <20150412173120.GA11631@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150412173120.GA11631@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

On Sun, Apr 12, 2015 at 07:31:20PM +0200, Guido Günther wrote:
> On Sun, Apr 12, 2015 at 12:16:28PM +0200, Alexander Aring wrote:
> > This patch adds an open task section in developing. So maybe if somebody
> > has too much time he/she can pick tasks from it and send patches.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> >  - fix 802.1.54 to 802.15.4
> >  - fix ". crypto" to ". Crypto"
> >  - add network-manager entry
> >  - add socket cleanup/fix entry
> > 
> >  website/index.txt | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/website/index.txt b/website/index.txt
> > index 2f007d5..0a135e2 100644
> > --- a/website/index.txt
> > +++ b/website/index.txt
> > @@ -122,6 +122,31 @@ All patches should be send to <linux-wpan@vger.kernel.org> and based on bluetoot
> >  For wpan-tools checkout the https://github.com/linux-wpan/wpan-tools[wpan-tools] repository. Also send patches to <linux-wpan@vger.kernel.org> for it with a "wpan-tools" tag.
> >  The same for https://github.com/linux-wpan/wpan-misc[wpan-misc].
> >  
> > +Open Tasks
> > +~~~~~~~~~~
> > +
> > +* There is a lot of missing features for enum definition to some string definition in iwpan which can be lookup in 802.15.4 standard. Words say more than numbers...
> > +** channel/page to frequency
> > +** cca modes/opts
> > +** no aret mode for max_frame_retires -1
> > +** etc
> > +* Missing features which wireless has and wpan not. Since we based our implementation on wireless we should sync "good patches" from wireless branch.
> > +** Something like http://www.spinics.net/lists/netdev/msg321088.html[net: nl80211 - pass name_assign_type to rdev_add_virtual_intf()]
> > +** trace functionality for rdev/driver_ops http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/wireless/rdev-ops.h[rdev-ops.h] and
> > +http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac80211/driver-ops.h[driver-ops.h]
> > +** Whatever you want and find
> > +* rework
> > +** missing features in nl802154, crypto etc.
> > +** new frame parsing style in mac802154 and ieee802154 based on mac80211 frame parsing design. Draft is https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c[mac802154 rx] and
> > +https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/6lowpan/rx.c[6LoWPAN]. Crypto need to be done at first, otherwise I can't test it.
> > +** remove cb context from dev_hard_header and introduce generic header generation functions like https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/header_ops.c#L80[header_ops]. Here too, crypto need to be done at first.
> > +* systemd
> > +** add basic functionality for nl802154 and 6lowpan setup in systemd-networkd
> > +* network-manager
> > +* devicetree extended addr setting, draft is here http://www.spinics.net/lists/linux-wpan/msg01503.html[ieee802154: add usual way to get extended address via device tree]
> > +* RPL? - not our job, need to go through ipv6 netdev community, but we should do something to have a "started" mainline solution.
> > +* cleanup/fix 802.15.4 af raw/dgram socket code. We should use bluetooth socket code as example.
> > +
> 
> ACK, very helpful.
> 

not my idea, Marcel told me that bluetooth has same paradigms and I
should take a look how bluetooth deals with that.

I think the current behaviour should the same, which is:

 - RAW frames (build mac headers in userspace without FCS(FCS should be
               configureable if added or not, but I am fine with basic
	       support without one for the first step))
 - DGRAM frames (802.15.4 dataframes)

 (not a socket, but I will explain how to deal with mlme here)
 - MLME-ops (triggered by some nl802154 cmds, which doing mac layer
	     stuff, so you can use DGRAM sockets and for the rest nl802154
	     cmds for access mac layer). In theory it should everything
	     possible over raw-frames of course, but DGRAM/MLME should
	     be a more abtracted layer, to access mac. Then RAW sockets
	     exists if you really want to do some exotic things in the
	     network.

what we should lookup is more how bluetooth deals with socketopts and
such things for dealing bits inside mac frame control header, etc. and
the general architecture.


The linux-wpan project will be more and more a wireless subsystem which
grabbing code from two others wireless subsystems. ;-)

> As a follow up I'd be nice to know what's missing on the interop side
> (e.g. to talk to contiki or what else exists) - in case anybody knows
> this already.

This depends on what contiki uses. For 6LoWPAN this is more complicated.

6LoWPAN is used by bluetooth and 802.15.4, in general they share the IPv6
Header Compression format (the code in net/6lowpan). This is not fully
supported right now (e.g. stateful address compression). Also there exists
some RFC's outside for improve neighbour discovery for L2 without multicast
support, etc... also to support short address with 6LoWPAN will be funny
(but not impossible). I don't have the priority to add support for all
them now. My first priority is to finish the rework stuff which I have
planed and remove the old stuff.

I think it's good to begin a list of what we need to support in 6LoWPAN
and what's not. For the generic 6LoWPAN this list will should also be
shared with the bluetooth community. This is mostly IPHC stuff and
6LoWPAN stuff which operates in L3 and I think this is the most
interested part. I think we should start some new website for that or
something else. There is also planed a userspace tool for setting
compression options for IPHC stuff (which is not possible to configure
right now). I will open a new ml thread to start some discussion about that
,also with the bluetooth community.

- Alex
