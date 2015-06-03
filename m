Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35675 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbFCHZu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 03:25:50 -0400
Received: by wgme6 with SMTP id e6so1346206wgm.2
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2015 00:25:48 -0700 (PDT)
Date: Wed, 3 Jun 2015 09:25:46 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: information leak in struct sockaddr_ieee802154 processing
Message-ID: <20150603072543.GD731@omega>
References: <20150525131712.GP11340@wantstofly.org>
 <20150601134551.GD1897@wantstofly.org>
 <20150601140036.GD1195@omega>
 <20150603064547.GI1897@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150603064547.GI1897@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 03, 2015 at 09:45:47AM +0300, Lennert Buytenhek wrote:
> On Mon, Jun 01, 2015 at 04:00:41PM +0200, Alexander Aring wrote:
> 
> > Hi Lennert,
> 
> Hi!
> 
> 
> > > When calling recvmsg(2) on a PF_IEEE802154 SOCK_DGRAM socket, the
> > > ieee802154 stack constructs a struct sockaddr_ieee802154 on the
> > > kernel stack without clearing these padding fields, and, depending
> > > on the addr_type, between four and ten bytes of uncleared kernel
> > > stack will be copied to userspace.
> > > 
> > > We can't just insert two 'u16 __pad's in the right places and zero
> > > those before copying an address to userspace, as not all architectures
> > > insert this implicit padding -- from a quick test it seems that avr32,
> > > cris and m68k don't insert this padding, while every other architecture
> > > that I have cross compilers for does insert this padding.
> > > 
> > > The easiest way to plug the leak is to just memset the whole struct
> > > sockaddr_ieee802154 before filling in the fields we want to fill in,
> > > and that's what this patch does.
> > > 
> > > Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> > > ---
> > >  net/ieee802154/socket.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> > > index 02abef2..b6eacf3 100644
> > > --- a/net/ieee802154/socket.c
> > > +++ b/net/ieee802154/socket.c
> > > @@ -731,6 +731,12 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > >  	sock_recv_ts_and_drops(msg, sk, skb);
> > >  
> > >  	if (saddr) {
> > > +		/* Clear the implicit padding in struct sockaddr_ieee802154
> > > +		 * (16 bits between 'family' and 'addr') and in struct
> > > +		 * ieee802154_addr_sa (16 bits at the end of the structure).
> > > +		 */
> > > +		memset(saddr, 0, sizeof(*saddr));
> > > +
> > >  		saddr->family = AF_IEEE802154;
> > >  		ieee802154_addr_to_sa(&saddr->addr, &mac_cb(skb)->source);
> > >  		*addr_len = sizeof(*saddr);
> > 
> > go ahead and send patches,
> 
> OK, can I submit this with your ACK?
> 

yes.

> 
> > I never looked much into the socket code and
> > there are many things broken which ends in some crazy behaviour. I don't
> > know if I can say that, when I am the maintainer... but this code need
> > some rework/cleanup and such things. Marcel already told that we should
> > look how bluetooth deals with socket code. I am currently search
> > somebody which wants to cleanup this socket code so proprietary which
> > fits on top of 802.15.4 can use this in userspace.
> 
> I'm looking at cleaning this up -- I went through the zigbee specs
> to figure out what I think a userspace interface needs to provide,
> but, I don't have a zigbee stack to test with or against.
> 

ok. There are also some other ToDo's like frame parsing to support the
full parsing functionality. (This parsing is only for checking if the
frame is correct, again I already worked on the same parsing style like
mac80211 and we should follow this as example).

> 
> > I think your note is exact what David Laight notes some years ago on
> > netdev, but nobody really cared about that issue. See [0]. This was only
> > an internal handled struct, but David Laight was on the right track by
> > note this with structs which are used for kernel<->userspace
> > communication. (What I mean he note the padding stuff but on the wrong
> > struct. But the correct struct has this issue also.).
> 
> ACK.
> 
> 
> > Anyway, big THANK YOU for detecting this and making fix. Feel free to
> > send a patch, but then it's the question "should we fix this patch into
> > stable", is it really a big security issue?
> 
> :-)  I think it's probably worth cc'ing stable@, as the fix
> addresses a real issue, and is minimally intrusive and is unlikely
> to break anything.
> 

ok.

> 
> > btw: The address field should be noted as __le16 also for userspace
> > communication. _When_ the address fields are not really little endian.
> 
> As far as I understand, in sockaddr_ieee802154:
> 
> * sa_family (sa_family_t) is always in CPU (host) byte order, as
>   the sa_family member of struct sockaddr is always treated as being
>   in host byte order
> 
> * addr.addr_type (int) is treated as being in host byte order in the
>   kernel, with direct comparisons against IEEE802154_ADDR_SHORT and
>   IEEE802154_ADDR_LONG in various places without any byteswapping.
> 
> * addr.pan_id (u16) is treated as being in host byte order, as there
>   is a (in my opinion incorrect ;-)) cpu_to_le16() conversion done on
>   it when copying the value into the kernel, and a le16_to_cpu() when
>   copying it out of the kernel.
> 
> * addr.short_addr (u16), same thing here, this looks like a host byte
>   order value, as cpu_to_le16() conversion is done when the value
>   enters the kernel, and le16_to_cpu() when being copied back to
>   userspace.
> 
> * addr.hwaddr[IEEE802154_ADDR_LEN] (u8) has the OUI bytes first.
> 
> In other words, I don't think that there are any struct
> sockaddr_ieee802154 member fields that should have the __le16 type
> -- or did I miss something?

No, then we do this in host byte order. I think, I did this wrong in
nl802154, we do that in little endian there, since the netlink
operations supports nla_get_le64 stuff, etc.

If we do that in host byte order here now, then we should also do the
same byteordering stuff in nl802154 for kernel<->userspace. Otherwise
it's just confusing how do deal with interface sockets and then nl802154
interface. Do you agree here?

Maybe we will grab all nl802154 into some list and doing some cut at
kernel version x.y.

- Alex
