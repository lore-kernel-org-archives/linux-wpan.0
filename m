Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:43824 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaIXMSu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 08:18:50 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH bluetooth-next 4/4] ieee802154: 6lowpan: ensure header compression does not corrupt ipv6 header
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411554093-14976-5-git-send-email-alex.aring@gmail.com>
Date: Wed, 24 Sep 2014 14:18:52 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <4472A049-A0BA-4E19-B788-5292749AD916@holtmann.org>
References: <1411554093-14976-1-git-send-email-alex.aring@gmail.com> <1411554093-14976-5-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Simon Vincent <simon.vincent@xsilon.com>

Hi Alex,

> The 6lowpan ipv6 header compression was causing problems for other interfaces
> that expected a ipv6 header to still be in place, as we were replacing the
> ipv6 header with a compressed version. This happened if you sent a packet to a
> multicast address as the packet would be output on 802.15.4, ethernet, and also
> be sent to the loopback interface. The skb data was shared between these
> interfaces so all interfaces ended up with a compressed ipv6 header.
> The solution is to ensure that before we do any header compression we are not
> sharing the skb or skb data with any other interface. If we are then we must
> take a copy of the skb and skb data before modifying the ipv6 header.
> The only place we can copy the skb is inside the xmit function so we don't
> leave dangling references to skb.
> This patch moves all the header compression to inside the xmit function. Very
> little code has been changed it has mostly been moved from lowpan_header_create
> to lowpan_xmit. At the top of the xmit function we now check if the skb is
> shared and if so copy it. In lowpan_header_create all we do now is store the
> source and destination addresses for use later when we compress the header.

so I added a two empty lines here to make this text a bit more easier on the eyes when reading it. Also in the future I would propose to keep it a 72 chars and not try to max out the 80 chars width. The reason is so that git log displays properly in a 80 chars terminal.

> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan_rtnl.c | 125 ++++++++++++++++++++++++++++++------------
> 1 file changed, 89 insertions(+), 36 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index 5e788cd..78cb206 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -71,20 +71,42 @@ struct lowpan_dev_record {
> 	struct list_head list;
> };
> 
> +/* don't save pan id, it's intra pan */
> +struct lowpan_addr {
> +	u8 mode;
> +	union lowpan_addr_u {

I changed this into union { since there is no reason to name the union here.

> +		/* IPv6 needs big endian here */
> +		__be64 extended_addr;
> +		__be16 short_addr;
> +	} u;
> +};

Regards

Marcel

