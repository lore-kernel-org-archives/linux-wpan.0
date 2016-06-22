Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:49612 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbcFVNid (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 22 Jun 2016 09:38:33 -0400
Subject: Re: [PATCH bluetooth-next 1/2] 6lowpan: ndisc: fix double read unlock
References: <20160621082719.9903-1-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <576A92EA.9020906@osg.samsung.com>
Date: Wed, 22 Jun 2016 15:30:18 +0200
MIME-Version: 1.0
In-Reply-To: <20160621082719.9903-1-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, dan.carpenter@oracle.com

Hello.

On 21/06/16 10:27, Alexander Aring wrote:
> This patch removes a double unlock case to accessing neighbour private
> data.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   net/6lowpan/ndisc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
> index ae1d419..030504e 100644
> --- a/net/6lowpan/ndisc.c
> +++ b/net/6lowpan/ndisc.c
> @@ -135,8 +135,9 @@ static int lowpan_ndisc_opt_addr_space(const struct net_device *dev,
>   			read_unlock_bh(&neigh->lock);
>   			addr_space += __ndisc_opt_addr_space(IEEE802154_SHORT_ADDR_LEN, 0);
>   			*ha = ha_buf;
> +		} else {
> +			read_unlock_bh(&neigh->lock);
>   		}
> -		read_unlock_bh(&neigh->lock);
>   		break;
>   	case NDISC_NEIGHBOUR_ADVERTISEMENT:
>   	case NDISC_NEIGHBOUR_SOLICITATION:

Dan, thanks for finding this one!

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com> regards Stefan Schmidt



