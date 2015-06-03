Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37242 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbbFCOqf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 10:46:35 -0400
Received: by wifw1 with SMTP id w1so25043388wif.0
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2015 07:46:34 -0700 (PDT)
Date: Wed, 3 Jun 2015 16:46:28 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: information leak in struct sockaddr_ieee802154 processing
Message-ID: <20150603144625.GA744@omega>
References: <20150525131712.GP11340@wantstofly.org>
 <20150601134551.GD1897@wantstofly.org>
 <20150601140036.GD1195@omega>
 <20150603140125.GL1897@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150603140125.GL1897@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

On Wed, Jun 03, 2015 at 05:01:25PM +0300, Lennert Buytenhek wrote:
> On Mon, Jun 01, 2015 at 04:00:41PM +0200, Alexander Aring wrote:
> 
> > [...]
> >
> > I never looked much into the socket code and
> > there are many things broken which ends in some crazy behaviour. I don't
> > know if I can say that, when I am the maintainer... but this code need
> > some rework/cleanup and such things. Marcel already told that we should
> > look how bluetooth deals with socket code. I am currently search
> > somebody which wants to cleanup this socket code so proprietary which
> > fits on top of 802.15.4 can use this in userspace.
> 
> I must admit that I haven't looked at the Bluetooth socket code, but

me too.

> I've noticed for example that the only capability checks done are done
> when setting up crypto state (when setting the WPAN_SECURITY /
> WPAN_SECURITY_LEVEL sockopts on a socket), and there are no permission
> checks done when opening a SOCK_RAW socket, for example.
> 
> Also, SOCK_DGRAM sockets return packets with 802.15.4 headers, just
> like SOCK_RAW does, which seems rather wrong.  There's even a comment
> about this in the socket code:
> 
> 	static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 				 int noblock, int flags, int *addr_len)
> 	{
> 	[...]
> 		/* FIXME: skip headers if necessary ?! */
> 		err = skb_copy_datagram_msg(skb, 0, msg, copied);
> 		if (err)
> 			goto done;
> 
> Unfortunately, this is now enshrined in the userland API/ABI, and
> there's nothing we can do about this now. :(
> 

I know, I put it on my todo list, but hasn't time to fix that. See [0].

"I also noticed that the raw socket don't put the mac header into
 payload..."

> I also don't really understand why the concept of 802.15.4 PANs was
> tied 1:1 to Linux netdevs.
> 
> It seems that this was done because 802.11 does something similar,
> where each ESSID association (in client mode) or ESSID AP instance
> is in itself a Linux netdev, but in that case it makes total sense,
> because each such netdev looks and feels like an "Ethernet" (802.3)
> interface, and presenting e.g. an ESSID association to the kernel
> as its own 802.3 interface massively simplifies integrating this
> with the rest of the OS, even if the mapping isn't 1:1 and some
> things don't work in this mode (for example, you can't generally
> add a wlan interface to a bridge group, while this works fine when
> you do it with any wired ethernet interface).
> 
> For the Ethernet vlan (802.1q) code, it also makes sense to present
> VLAN tagging interfaces (eth0.123) to the kernel as individual 802.3
> interfaces, as, again, the rest of the system software gets to
> interact with an 802.3 interface this way, which most software that
> needs to know about L2 headers already knows how to do.
> 
> But for 802.15.4, there is no benefit from doing this that I can
> think of.  I understand that there is per-PAN MLME state that needs
> to be kept, and that one needs a kernel object to tie this state to,
> but I just don't see why this needs to be a netdev -- and it doesn't
> seem consistent with how the rest of the socket API works.
> 
> And the idea of tying the PAN ID to the interface isn't even applied
> consistently -- if I set wpan0 to be in PAN 0x1234, and then send a
> packet out via wpan0, I still need to explicitly specify the PAN ID
> in the sockaddr (and I can specify a different PAN ID here as far as
> I can see), so the possible argument that creating per-PAN netdevs
> provides a level of abstraction fails to hold as well.

yes, all known that's why there exists an opentask at [1]:

"cleanup/fix 802.15.4 af raw/dgram socket code. We should use bluetooth 
socket code as example." And to not say the source addresses is part of
them.

Send patches.

> 
> Actually, if you look at the 802.15.4 6lowpan code, what it does
> when transmitting a packet is asking the outgoing interface what its
> PAN ID is, and then writing that into the outgoing packet:
> 
> 	static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
> 	{
> 	[...]
> 		sa.pan_id = ieee802154_mlme_ops(real_dev)->get_pan_id(real_dev);
> 
> This just doesn't make sense to me -- it would be like requiring users
> of 802.1q VLAN interfaces to query the outgoing VLAN interface's VLAN
> tag and to insert that tag into outgoing packets themselves, instead
> of having the VLAN interface take care of this by itself.

6LoWPAN connection is "intra-pan" communication only. Which means source
and destionation pan_id are the same.

> 
> The other downside of letting 6lowpan attach directly to an 802.15.4
> interface is that this provides no protection against other 802.15.4
> users (such as userland sockets) grabbing a copy of the 6lowpan
> encoded frames.  To be fair, there is no standardised higher level
> addressing scheme for 802.15.4, as there is no protocol type field
> in the 802.15.4 payload (6lowpan defines an initial payload byte
> designating the higher level protocol, with 00xxxxxx reserved for
> 'not 6lowpan', but this is not a 802.15.4-specified mechanism),

Yes, the current way is to check on this dispatch value which seems that
it is a 6LoWPAN packet. If this is set correctly we try to parse it as
6LoWPAN, if not we drop it currently. Is there something wrong with this
behaviour? I know we need a better handling for the 6LoWPAN parsing
stuff because we assume there that the skb has the right length and such
stuff, but this is part of the whole reimplementation of frame
parsing/generation rework. (then 802.15.4 6lowpan parsing looks like
mac802154 which based on mac80211 and has hopefully more checks agains
if the headers are right).

I don't know what you want to try to saying with the complete ethernet
vlan stuff. You want to try to find some mapping to doing more pan_id
stuff from userspace level, because you can only control them by the
IPv6 sockets?

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01917.html
[1] http://wpan.cakelab.org/
[2] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan/rx.c#L155
