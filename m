Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30214 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933039AbbFVHbr (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 22 Jun 2015 03:31:47 -0400
Message-ID: <1434958303.2794.26.camel@linux.intel.com>
Subject: Re: [PATCH bluetooth-next] 6lowpan: add request for ipv6 module
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 22 Jun 2015 10:31:43 +0300
In-Reply-To: <1434899479-22310-1-git-send-email-alex.aring@gmail.com>
References: <1434899479-22310-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

On su, 2015-06-21 at 17:11 +0200, Alexander Aring wrote:
> The iphc module depends on CONFIG_IPV6, because it's not very useful to
> build the module without IPv6 support. Recently an user reported about
> issues for setting an IPv6 address to a 6LoWPAN interface. The issues
> was solved by modprobe the ipv6 module before. To avoid such user issues
> we try to request the ipv6 module when the 6LoWPAN module is loaded.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/6lowpan/iphc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 94a375c..9055d7b 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -613,6 +613,8 @@ EXPORT_SYMBOL_GPL(lowpan_header_compress);
>  
>  static int __init lowpan_module_init(void)
>  {
> +	request_module_nowait("ipv6");
> +
>  	request_module_nowait("nhc_dest");
>  	request_module_nowait("nhc_fragment");
>  	request_module_nowait("nhc_hop");


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>



Cheers,
Jukka


--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
