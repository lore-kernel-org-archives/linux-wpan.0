Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17908 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753599AbaJMPLA (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 13 Oct 2014 11:11:00 -0400
Message-ID: <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC
 decompression.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 13 Oct 2014 18:09:14 +0300
In-Reply-To: <543BE816.80304@xsilon.com>
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>
			 <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
		 <1413200959.2705.90.camel@jrissane-mobl.ger.corp.intel.com>
		 <543BCF44.1030001@xsilon.com>
	 <1413211468.2705.104.camel@jrissane-mobl.ger.corp.intel.com>
	 <543BE816.80304@xsilon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com

Hi Martin,

On ma, 2014-10-13 at 15:56 +0100, Martin Townsend wrote:
> Hi Jukka,
> 
> Does this patch help?

Unfortunately no, I still see inconsistent lock state. It would probably
have been too easy :)

> 
> ---
>  net/bluetooth/l2cap_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b6f9777..fb7b2ff 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5494,6 +5494,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
>  	if (credits > max_credits) {
>  		BT_ERR("LE credits overflow");
>  		l2cap_send_disconn_req(chan, ECONNRESET);
> +		l2cap_chan_unlock(chan);
>  
>  		/* Return 0 so that we don't trigger an unnecessary
>  		 * command reject packet.


Cheers,
Jukka


