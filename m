Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35209 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbbFSIEo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Jun 2015 04:04:44 -0400
Received: by wgbhy7 with SMTP id hy7so82921135wgb.2
        for <linux-wpan@vger.kernel.org>; Fri, 19 Jun 2015 01:04:43 -0700 (PDT)
Date: Fri, 19 Jun 2015 10:04:40 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 2/3] wpan-ping: unify src and dst address
 handling
Message-ID: <20150619080436.GC867@omega>
References: <1434666459-27827-1-git-send-email-stefan@osg.samsung.com>
 <1434666459-27827-3-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1434666459-27827-3-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Jun 19, 2015 at 12:27:38AM +0200, Stefan Schmidt wrote:
> Instead of having parts of the sockaddr struct parsed and kept in different
> places we put it all in the correct struct from the start now. All local
> information for the src address are requested over netlink while the dst
> address is parsed from the commandline. As the PAN ID has to be the same we
> take this also from netlink for dst.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  wpan-ping/wpan-ping.c | 86 +++++++++++++++++++++++----------------------------
>  1 file changed, 38 insertions(+), 48 deletions(-)
> 
> diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
> index d3f44f1..5432bfa 100644
> --- a/wpan-ping/wpan-ping.c
> +++ b/wpan-ping/wpan-ping.c
> @@ -86,16 +86,13 @@ static const struct option perf_long_opts[] = {
>  struct config {
>  	char packet_len;
>  	unsigned short packets;
> -	uint16_t dst_addr;
> -	uint16_t short_addr;
> -	uint16_t pan_id;
> -	uint8_t dst_extended[IEEE802154_ADDR_LEN];
> -	uint8_t src_extended[IEEE802154_ADDR_LEN];
>  	bool extended;
>  	bool server;
>  	char *interface;
>  	struct nl_sock *nl_sock;
>  	int nl802154_id;
> +	struct sockaddr_ieee802154 src;
> +	struct sockaddr_ieee802154 dst;
>  };
>  
>  extern char *optarg;
> @@ -168,10 +165,17 @@ static int nl_msg_cb(struct nl_msg* msg, void* arg)
>  	    || !attrs[NL802154_ATTR_EXTENDED_ADDR])
>  		return NL_SKIP;
>  
> -	conf->short_addr = nla_get_u16(attrs[NL802154_ATTR_SHORT_ADDR]);
> -	conf->pan_id = nla_get_u16(attrs[NL802154_ATTR_PAN_ID]);
> -	temp = htobe64(nla_get_u64(attrs[NL802154_ATTR_EXTENDED_ADDR]));
> -	memcpy(&conf->src_extended, &temp, IEEE802154_ADDR_LEN);
> +	conf->src.family = AF_IEEE802154;
> +	conf->src.addr.pan_id = conf->dst.addr.pan_id = nla_get_u16(attrs[NL802154_ATTR_PAN_ID]);
> +
> +	if (!conf->extended) {
> +		conf->src.addr.addr_type = IEEE802154_ADDR_SHORT;
> +		conf->src.addr.short_addr = nla_get_u16(attrs[NL802154_ATTR_SHORT_ADDR]);
> +	} else {
> +		conf->src.addr.addr_type = IEEE802154_ADDR_LONG;
> +		temp = htobe64(nla_get_u64(attrs[NL802154_ATTR_EXTENDED_ADDR]));
> +		memcpy(&conf->src.addr.hwaddr, &temp, IEEE802154_ADDR_LEN);
> +	}

I think what you do here is to get the src address, because _currently_
the DGRAM sockets of af_802154 need to specify the source address for
creating socket. This is some behaviour which Lennert already mentioned,
that this behaviour has no architecture. The kernel already know the
source address and can put it into the payload for DGRAM sockets.

Nevertheless what I really want to say is the bytordering. Please
remeber that the nl802154 for addresses is in little endian (like the
mac byte order). The DGRAM sockets are in host byte order.

I also already mentioned that this is really confusing and we should
decide later (maybe for next nl802154 upgrade cycle) to decide that we
should have only one behaviour.

Setting the mac address over ip:

"ip link set dev interface address XX:XX:XX:XX:XX:XX"

will require big endian (I suppose a2n ist address to network byte order
which big endian). See [0].


So now it's really confusing, because over "generic ip interface" you
will get big endian. Over nl802154 it's little endian and DGRAM is host
byteorder.

There are maybe reasons for let the nl802154 for MAC settings (which is
the address) in little endian, because the ip stuff do the same for the
network byteorder. It's hard to decide what we should do now, but at the
moment I agree it's confusing and we should open a new thread to talking
about.

The most users have little endian machines, so changing the nl802154
stuff from le to host-byteorder should not make big different, except
if we have big endian users. I know ARM has the possibility to run big
endian, but I saw never somebody which really runs linux on big endian
ARM.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/ip/iplink.c#n426
