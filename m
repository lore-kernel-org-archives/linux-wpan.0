Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38413 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbIJHig (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Sep 2015 03:38:36 -0400
Received: by wiclk2 with SMTP id lk2so12285545wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 10 Sep 2015 00:38:35 -0700 (PDT)
Date: Thu, 10 Sep 2015 09:38:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/2] ieee802154: iface: fix header parse
 buffer overflow
Message-ID: <20150910073817.GA6360@omega>
References: <1441825780-6461-1-git-send-email-alex.aring@gmail.com>
 <1441825780-6461-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1441825780-6461-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hi,

On Wed, Sep 09, 2015 at 09:09:40PM +0200, Alexander Aring wrote:
> This patch fixes a buffer overflow for header_parse callback. This
> callback is used by net/packet/af_packet.c which calls:
> 
> sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
> 
> The "sll->sll_addr" is an array of eight bytes, but the size of struct
> ieee802154_addr is more than eight bytes long. I got funny mac header
> overwrites while dumping with wireshark/tcpdump.
> 
> I suppose with this function we can do filtering stuff by source
> address, so we do if extended address then copy the full address and
> "sll->sll_addr" is eight bytes long. If short address we copy a
> combination with "pan_id+short_addr", the "sll->sll_addr" should be four
> then. In case of none, we do nothing and "sll->sll_addr" returns zero.
> This should provide some unique address matching mechanism.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  include/linux/ieee802154.h |  2 ++
>  net/mac802154/iface.c      | 26 +++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> index db01492..7b1a28a 100644
> --- a/include/linux/ieee802154.h
> +++ b/include/linux/ieee802154.h
> @@ -37,6 +37,8 @@
>  #define IEEE802154_ADDR_SHORT_UNSPEC	0xfffe
>  
>  #define IEEE802154_EXTENDED_ADDR_LEN	8
> +#define IEEE802154_SHORT_ADDR_LEN	2
> +#define IEEE802154_PAN_ID_LEN		2
>  
>  #define IEEE802154_LIFS_PERIOD		40
>  #define IEEE802154_SIFS_PERIOD		12
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index ed26952..87e4183 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -427,15 +427,35 @@ static int
>  mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
>  {
>  	struct ieee802154_hdr hdr;
> -	struct ieee802154_addr *addr = (struct ieee802154_addr *)haddr;
> +	int pos = 0;
>  
>  	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0) {
>  		pr_debug("malformed packet\n");
>  		return 0;
>  	}
>  
> -	*addr = hdr.source;
> -	return sizeof(*addr);
> +	switch (hdr.source.mode) {
> +	case IEEE802154_ADDR_LONG:
> +		memcpy(haddr + pos, &hdr.source.extended_addr,
> +		       IEEE802154_EXTENDED_ADDR_LEN);
> +		pos += IEEE802154_EXTENDED_ADDR_LEN;
> +		break;
> +	case IEEE802154_ADDR_SHORT:
> +		memcpy(haddr + pos, &hdr.source.pan_id,
> +		       IEEE802154_PAN_ID_LEN);
> +		pos += IEEE802154_PAN_ID_LEN;
> +		memcpy(haddr + pos, &hdr.source.short_addr,
> +		       IEEE802154_SHORT_ADDR_LEN);
> +		pos += IEEE802154_SHORT_ADDR_LEN;
> +		break;
> +	case IEEE802154_ADDR_NONE:
> +		/* fall-through */
> +
> +	default:
> +		break;
> +	}
> +
> +	return pos;
>  }
>  
>  static struct header_ops mac802154_header_ops = {

Maybe it's better to replace the full mac802154_header_ops structure,
see [0] to:

static struct header_ops mac802154_header_ops = {
	.create         = mac802154_header_create,
};

The API for the "parse" callback simple doesn't fit into 802.15.4 address
cases. The above solution "might" work to get an unique source address
information, for whatever libpcap uses that, but requires that libpcap
knows the format what we meaning there:

len -> addr_type
8 -> extended_addr (le64)
4 -> pan_id+short_addr (le16+le16)
0 -> none

This requires some userspace api changes and "maybe" also applications
which uses libpcap.

We can "simple" remove this callback and I suppose that we simple
doesn't provide the source address then. See [1] and [2].


For the "create" callback we should replace it with a function which
returns simple "-EOPNOTSUPP". It's is also used by af_packet.c and
horrible broken, because this callback assumes the "right" information
inside "skb->cb". There are only given by 802.15.4 upper layer protocols
and not for net core api upper layer foo like af_packet.

Also we should not do .create = NULL, because af_packet.c thinks that
the mac header will be created "somehow" afterwards. Then simple forbid
this option for now. For sending DGRAM packets it should use af_802154
then.

What we should provide are own "ieee802154_header_ops" for the wpan_dev
which contains header creation function pointers which are 802.15.4
specific. Upper layers can call them then like dev_hard_header. And of
course remove of skb->cb information.

- Alex

[0] http://lxr.free-electrons.com/source/net/mac802154/iface.c#L430
[1] http://lxr.free-electrons.com/source/include/linux/netdevice.h#L2421
[2] http://lxr.free-electrons.com/source/net/packet/af_packet.c#L1919
