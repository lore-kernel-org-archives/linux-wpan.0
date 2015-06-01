Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:44146 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbbFAHhy (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 1 Jun 2015 03:37:54 -0400
Message-ID: <556C0BCD.5010408@osg.samsung.com>
Date: Mon, 01 Jun 2015 09:37:49 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154: trace: fix name for extended
 address
References: <1433133238-16056-1-git-send-email-varkab@cdac.in> <1433133238-16056-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1433133238-16056-3-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hello.

On 01/06/15 06:33, Varka Bhadram wrote:
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   net/ieee802154/trace.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
> index b4295fd..9b5eefc 100644
> --- a/net/ieee802154/trace.h
> +++ b/net/ieee802154/trace.h
> @@ -56,7 +56,7 @@ TRACE_EVENT(802154_rdev_add_virtual_intf,
>   		__entry->type = type;
>   		__entry->extended_addr = extended_addr;
>   	),
> -	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, ea %llx",
> +	TP_printk(WPAN_PHY_PR_FMT ", virtual intf name: %s, type: %d, extended addr: %llx",
>   		  WPAN_PHY_PR_ARG, __get_str(vir_intf_name), __entry->type,
>   		  __le64_to_cpu(__entry->extended_addr))
>   );
Please merge this with the third patch. Its really the same line and 
fixes the output and format specifier. I don't see a need to have two 
patches for this.

regards
Stefan Schmidt
