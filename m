Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:44083 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaIVJ1N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Sep 2014 05:27:13 -0400
Received: by mail-we0-f176.google.com with SMTP id w61so1690065wes.21
        for <linux-wpan@vger.kernel.org>; Mon, 22 Sep 2014 02:27:12 -0700 (PDT)
Date: Mon, 22 Sep 2014 11:27:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v2] 6lowpan: ensure header compression does
 not corrupt ipv6 header
Message-ID: <20140922092705.GA21350@omega>
References: <1411377257-10082-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1411377257-10082-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, marcel@holtmann.org

Hi Simon,

looks fine, only some small changes:

Please make a tag like "ieee802154: 6lowpan: xxxx". "6lowpan:" is for
the generic 6lowpan branch.

On Mon, Sep 22, 2014 at 10:14:17AM +0100, Simon Vincent wrote:
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
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
>  net/ieee802154/6lowpan_rtnl.c | 123 +++++++++++++++++++++++++++++-------------
>  1 file changed, 87 insertions(+), 36 deletions(-)
> 
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index 6591d27..f0e9520 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -71,6 +71,21 @@ struct lowpan_dev_record {
>  	struct list_head list;
>  };
>  
> +/* don't save pan id, it's intra pan */
> +struct lowpan_addr {
> +	__le16 mode;
> +	union lowpan_addr_u {
> +	/* IPv6 needs big endian here */
> +	__be64 extended_addr;
> +	__be16 short_addr;
indent here, one more tab. I mean the full union need more indentation.

Otherwise it looks okay for me.

Also cc Marcel Holtmann next time, he also had some points for
reviewing... and Marcel have more expierence to doing mainline code than
me. I am very happy that he looks on linux-wpan for reviewing stuff.

You don't need to cc Marcel always, I mean here only because he had
issues on your v1.

- Alex
