Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34856 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbDLVwE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 12 Apr 2015 17:52:04 -0400
Received: by widdi4 with SMTP id di4so51350657wid.0
        for <linux-wpan@vger.kernel.org>; Sun, 12 Apr 2015 14:52:02 -0700 (PDT)
Date: Sun, 12 Apr 2015 23:51:51 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc] website: add opentask section in developing
Message-ID: <20150412215149.GA1046@omega>
References: <1428481894-19784-1-git-send-email-alex.aring@gmail.com>
 <20150409091625.GA5826@bogon.m.sigxcpu.org>
 <20150412102143.GA984@omega>
 <20150412173326.GB11631@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150412173326.GB11631@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-wpan@vger.kernel.org

On Sun, Apr 12, 2015 at 07:33:26PM +0200, Guido Günther wrote:
> On Sun, Apr 12, 2015 at 12:21:44PM +0200, Alexander Aring wrote:
> > On Thu, Apr 09, 2015 at 11:16:25AM +0200, Guido Günther wrote:
> > > On Wed, Apr 08, 2015 at 10:31:34AM +0200, Alexander Aring wrote:
> > > > This patch adds an open task section in developing. So maybe if somebody
> > > > has too much time he/she can pick tasks from it and send patches.
> > > > 
> > > > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > > > ---
> > > >  website/index.txt | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/website/index.txt b/website/index.txt
> > > > index 2f007d5..9cf2ca3 100644
> > > > --- a/website/index.txt
> > > > +++ b/website/index.txt
> > > > @@ -122,6 +122,29 @@ All patches should be send to <linux-wpan@vger.kernel.org> and based on bluetoot
> > > >  For wpan-tools checkout the https://github.com/linux-wpan/wpan-tools[wpan-tools] repository. Also send patches to <linux-wpan@vger.kernel.org> for it with a "wpan-tools" tag.
> > > >  The same for https://github.com/linux-wpan/wpan-misc[wpan-misc].
> > > >  
> > > > +Open Tasks
> > > > +~~~~~~~~~~
> > > > +
> > > > +* There is a lot of missing features for enum definition to some string definition in iwpan which can be lookup in 802.1.54 standard. Words say more than numbers...
> > > > +** channel/page to frequency
> > > > +** cca modes/opts
> > > > +** no aret mode for max_frame_retires -1
> > > > +** etc
> > > > +* Missing features which wireless has and wpan not. Since we based our implementation on wireless we should sync "good patches" from wireless branch.
> > > > +** Something like http://www.spinics.net/lists/netdev/msg321088.html[net: nl80211 - pass name_assign_type to rdev_add_virtual_intf()]
> > > > +** trace functionality for rdev/driver_ops http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/wireless/rdev-ops.h[rdev-ops.h] and
> > > > +http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac80211/driver-ops.h[driver-ops.h]
> > > > +** Whatever you want and find
> > > > +* rework
> > > > +** missing features in nl802154, crypto etc.
> > > > +** new frame parsing style in mac802154 and ieee802154 based on mac80211 frame parsing design. Draft is https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/rx.c[mac802154 rx] and
> > > > +https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/6lowpan/rx.c[6LoWPAN]. crypto need to be done at first, otherwise I can't test it.
> > > > +** remove cb context from dev_hard_header and introduce generic header generation functions like https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/ieee802154/header_ops.c#L80[header_ops]. Here too, crypto need to be done at first.
> > > > +* systemd
> > > > +** add basic functionality for nl802154 and 6lowpan setup in systemd-networkd
> > > 
> > > ...and network-manager ?
> > > 
> > 
> > ok. I recently send a Patchv2 which also includes the network-manager.
> > Also there is an idea to simple add _one_ 6lowpan interface on a wpan
> > interface, when ieee802154_6lowpan.ko module is loaded. This is easy to
> > implement, question is here: "Is this a good idea or not". If somebody
> > maybe we should do this by default and user can also disable this
> > handling by module parameter.
> 
> It sounds great for 6loWPAN but I don't know what e.g. ZigBee and other
> users think about this. Are there any known ones?

I don't know ZigBee users, the full mac functionality is currently not
available. There is still much to do. Also if you think "then I will use
simple RAW sockets" that doesn't work at the moment, no support for all
parsing frametypes and coordinator iftype should be activated and set
the address filtering option on phy which allow "coordinator address
filtering on phy".

btw.
A "coordinator" iftype exists and I planed to activate this interface
after removing the old netlink interface stuff. Then a coordinator
interface would be set the "phy address filtering" for coordinator parsing
like a coordinator and not like a "node", this differs. But this is a
little issue which is in my mind right now, there is of course more
complicated stuff.



The other users: there may some exists... because there are already
questions for using the RAW/DGRAM sockets for 802.15.4. But real
commercial products? No, I don't know commercial products which using
the raw/dgram sockets.



To the question what ZigBee users and others users think about this:

If they don't like it then they should not load ieee802154_6lowpan.ko
module, put it on blacklisted modules or should deactivate the auto
interface generation while interface up via module parameter.

Current behaviour is that `ip add link ... type lowpan` will load
automatically the ieee802154_6lowpan.ko, so I think the most users would
add the ieee802154_6lowpan as automatically module which should load at
bootime. Or the ieee802154 subsystem will try to request the module
while loading ieee802154 subsystem module, which is maybe better. So
there is no need to setup some 6LoWPAN connection (In case of what we
support right now) when probing of 802.15.4 is successful. Okay the user
need to setup some pan_id (must), etc (optional if using phy/driver defaults).

- Alex
