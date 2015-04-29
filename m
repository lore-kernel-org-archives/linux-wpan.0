Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:58009 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbbD2Sp7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Apr 2015 14:45:59 -0400
Date: Wed, 29 Apr 2015 20:45:55 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH wpan-next] ieee802154: trace: fix endian convertion
Message-ID: <20150429184555.GA3572@bogon.m.sigxcpu.org>
References: <1430294781-22294-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1430294781-22294-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed, Apr 29, 2015 at 10:06:21AM +0200, Alexander Aring wrote:
> This patch fix endian convertions for extended address and short address
> handling when TP_printk is called.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Guido Günther <agx@sigxcpu.org>
> ---
>  net/ieee802154/trace.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
> index 8ed9f97..5ac25eb 100644
> --- a/net/ieee802154/trace.h
> +++ b/net/ieee802154/trace.h
> @@ -58,7 +58,7 @@ TRACE_EVENT(802154_rdev_add_virtual_intf,
>  	),
>  	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, ea %llx",
>  		  WPAN_PHY_PR_ARG, __get_str(vir_intf_name), __entry->type,
> -		  __entry->extended_addr)
> +		  __le64_to_cpu(__entry->extended_addr))
>  );
>  
>  TRACE_EVENT(802154_rdev_del_virtual_intf,
> @@ -138,7 +138,8 @@ DEFINE_EVENT_PRINT(802154_le16_template, 802154_rdev_set_short_addr,
>  		 __le16 le16arg),
>  	TP_ARGS(wpan_phy, wpan_dev, le16arg),
>  	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT ", sa: 0x%04x",
> -		  WPAN_PHY_PR_ARG, WPAN_DEV_PR_ARG, __entry->le16arg)
> +		  WPAN_PHY_PR_ARG, WPAN_DEV_PR_ARG,
> +		  __le16_to_cpu(__entry->le16arg))
>  );
>  
>  TRACE_EVENT(802154_rdev_set_backoff_exponent,

Argh - missed that one. ACK.
Cheers,
 -- Guido

