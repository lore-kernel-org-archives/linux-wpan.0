Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:35405 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbbFAOAp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 10:00:45 -0400
Received: by wgme6 with SMTP id e6so115195194wgm.2
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 07:00:44 -0700 (PDT)
Date: Mon, 1 Jun 2015 16:00:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: information leak in struct sockaddr_ieee802154 processing
Message-ID: <20150601140036.GD1195@omega>
References: <20150525131712.GP11340@wantstofly.org>
 <20150601134551.GD1897@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150601134551.GD1897@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

On Mon, Jun 01, 2015 at 04:45:51PM +0300, Lennert Buytenhek wrote:
...
> When calling recvmsg(2) on a PF_IEEE802154 SOCK_DGRAM socket, the
> ieee802154 stack constructs a struct sockaddr_ieee802154 on the
> kernel stack without clearing these padding fields, and, depending
> on the addr_type, between four and ten bytes of uncleared kernel
> stack will be copied to userspace.
> 
> We can't just insert two 'u16 __pad's in the right places and zero
> those before copying an address to userspace, as not all architectures
> insert this implicit padding -- from a quick test it seems that avr32,
> cris and m68k don't insert this padding, while every other architecture
> that I have cross compilers for does insert this padding.
> 
> The easiest way to plug the leak is to just memset the whole struct
> sockaddr_ieee802154 before filling in the fields we want to fill in,
> and that's what this patch does.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> ---
>  net/ieee802154/socket.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index 02abef2..b6eacf3 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -731,6 +731,12 @@ static int dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	sock_recv_ts_and_drops(msg, sk, skb);
>  
>  	if (saddr) {
> +		/* Clear the implicit padding in struct sockaddr_ieee802154
> +		 * (16 bits between 'family' and 'addr') and in struct
> +		 * ieee802154_addr_sa (16 bits at the end of the structure).
> +		 */
> +		memset(saddr, 0, sizeof(*saddr));
> +
>  		saddr->family = AF_IEEE802154;
>  		ieee802154_addr_to_sa(&saddr->addr, &mac_cb(skb)->source);
>  		*addr_len = sizeof(*saddr);


go ahead and send patches, I never looked much into the socket code and
there are many things broken which ends in some crazy behaviour. I don't
know if I can say that, when I am the maintainer... but this code need
some rework/cleanup and such things. Marcel already told that we should
look how bluetooth deals with socket code. I am currently search
somebody which wants to cleanup this socket code so proprietary which
fits on top of 802.15.4 can use this in userspace.

I think your note is exact what David Laight notes some years ago on
netdev, but nobody really cared about that issue. See [0]. This was only
an internal handled struct, but David Laight was on the right track by
note this with structs which are used for kernel<->userspace
communication. (What I mean he note the padding stuff but on the wrong
struct. But the correct struct has this issue also.).

Anyway, big THANK YOU for detecting this and making fix. Feel free to
send a patch, but then it's the question "should we fix this patch into
stable", is it really a big security issue?

btw: The address field should be noted as __le16 also for userspace
communication. _When_ the address fields are not really little endian.

- Alex

[0] http://www.spinics.net/lists/netdev/msg275233.html
