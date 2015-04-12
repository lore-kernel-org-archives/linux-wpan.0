Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:54883 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbDLReC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 12 Apr 2015 13:34:02 -0400
Date: Sun, 12 Apr 2015 19:33:26 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH wpan-misc] website: add opentask section in developing
Message-ID: <20150412173326.GB11631@bogon.m.sigxcpu.org>
References: <1428481894-19784-1-git-send-email-alex.aring@gmail.com>
 <20150409091625.GA5826@bogon.m.sigxcpu.org>
 <20150412102143.GA984@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150412102143.GA984@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Sun, Apr 12, 2015 at 12:21:44PM +0200, Alexander Aring wrote:
> On Thu, Apr 09, 2015 at 11:16:25AM +0200, Guido Günther wrote:
> > On Wed, Apr 08, 2015 at 10:31:34AM +0200, Alexander Aring wrote:
> > > This patch adds an open task section in developing. So maybe if somebody
> > > has too much time he/she can pick tasks from it and send patches.
> > > 
> > > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > > ---
> > >  website/index.txt | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/website/index.txt b/website/index.txt
> > > index 2f007d5..9cf2ca3 100644
> > > --- a/website/index.txt
> > > +++ b/website/index.txt
> > > @@ -122,6 +122,29 @@ All patches should be send to <linux-wpan@vger.kernel.org> and based on bluetoot
> > >  For wpan-tools checkout the https://github.com/linux-wpan/wpan-tools[wpan-tools] repository. Also send patches to <linux-wpan@vger.kernel.org> for it with a "wpan-tools" tag.
> > >  The same for https://github.com/linux-wpan/wpan-misc[wpan-misc].
> > >  
> > > +Open Tasks
> > > +~~~~~~~~~~
> > > +
> > > +* There is a lot of missing features for enum definition to some string definition in iwpan which can be lookup in 802.1.54 standard. Words say more than numbers...
> > > +** channel/page to frequency
> > > +** cca modes/opts
> > > +** no aret mode for max_frame_retires -1
> > > +** etc
> > > +* Missing features which wireless has and wpan not. Since we based our implementation on wireless we should sync "good patches" from wireless branch.
> > > +** Something like http://www.spinics.net/lists/netdev/msg321088.html[net: nl80211 - pass name_assign_type to rdev_add_virtual_intf()]
> > > +** trace functionality for rdev/driver_ops http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/wireless/rdev-ops.h[rdev-ops.h] and
> > > +http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac80211/driver-ops.h[driver-ops.h]
> > > +** Whatever you want and find
> > > +* rework
> > > +** missing features in nl802154, crypto etc.
> > > +** new frame parsing style in mac802154 and ieee802154 based on mac80211 frame parsing design. Draft is https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c[mac802154 rx] and
> > > +https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/6lowpan/rx.c[6LoWPAN]. crypto need to be done at first, otherwise I can't test it.
> > > +** remove cb context from dev_hard_header and introduce generic header generation functions like https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/header_ops.c#L80[header_ops]. Here too, crypto need to be done at first.
> > > +* systemd
> > > +** add basic functionality for nl802154 and 6lowpan setup in systemd-networkd
> > 
> > ...and network-manager ?
> > 
> 
> ok. I recently send a Patchv2 which also includes the network-manager.
> Also there is an idea to simple add _one_ 6lowpan interface on a wpan
> interface, when ieee802154_6lowpan.ko module is loaded. This is easy to
> implement, question is here: "Is this a good idea or not". If somebody
> maybe we should do this by default and user can also disable this
> handling by module parameter.

It sounds great for 6loWPAN but I don't know what e.g. ZigBee and other
users think about this. Are there any known ones?
Cheers,
 -- Guido
