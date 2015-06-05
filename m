Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35376 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbFEL5M (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 07:57:12 -0400
Received: by pdbnf5 with SMTP id nf5so52258540pdb.2
        for <linux-wpan@vger.kernel.org>; Fri, 05 Jun 2015 04:57:11 -0700 (PDT)
Message-ID: <55718E7E.1060701@gmail.com>
Date: Fri, 05 Jun 2015 17:26:46 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-tools] treewide: replace wireless with wpan
References: <1433504605-5242-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433504605-5242-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On 06/05/2015 05:13 PM, Alexander Aring wrote:

> This patch replaced several wireless string with wpan. This behaviour
> was simpled copied from wireless iw tool and it hasn't been renamed to
> wpan.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   src/info.c      | 4 ++--
>   src/interface.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/info.c b/src/info.c
> index 2434bef..8afeeb7 100644
> --- a/src/info.c
> +++ b/src/info.c
> @@ -459,7 +459,7 @@ static int handle_info(struct nl802154_state *state,
>   }
>   
>   __COMMAND(NULL, info, "info", NULL, NL802154_CMD_GET_WPAN_PHY, 0, 0, CIB_PHY, handle_info,
> -	  "Show capabilities for the specified wireless device.", NULL);
> +	  "Show capabilities for the specified wpan device.", NULL);
>   TOPLEVEL(list, NULL, NL802154_CMD_GET_WPAN_PHY, NLM_F_DUMP, CIB_NONE, handle_info,
> -	 "List all wireless devices and their capabilities.");
> +	 "List all wpan devices and their capabilities.");
>   TOPLEVEL(phy, NULL, NL802154_CMD_GET_WPAN_PHY, NLM_F_DUMP, CIB_NONE, handle_info, NULL);
> diff --git a/src/interface.c b/src/interface.c
> index 647247b..c67077b 100644
> --- a/src/interface.c
> +++ b/src/interface.c
> @@ -252,4 +252,4 @@ static int handle_dev_dump(struct nl802154_state *state,
>   	return 0;
>   }
>   TOPLEVEL(dev, NULL, NL802154_CMD_GET_INTERFACE, NLM_F_DUMP, CIB_NONE, handle_dev_dump,
> -	 "List all network interfaces for wireless hardware.");
> +	 "List all network interfaces for wpan hardware.");

We also have some typo in usage:

root@beaglebone:~# iwpan help
Usage:	iwpan [options] command
Options:
	--debug		enable netlink debugging
	--version	show version (0.4)
Commands:
	phy <phyname> set channel <page> <channel>
	phy <phyname> set tx_power <dBm>
	phy <phyname> set cca_mode <mode|3 <1|0>>
	phy <phyname> set cca_ed_level <level>
	dev <devname> set pan_id <pan_id>
	dev <devname> set short_addr <short_addr>
	dev <devname> set max_frame_retries <retries>
	dev <devname> set backoff_exponents <min_be> <max_be>
	dev <devname> set max_csma_backoffs <backoffs>
	dev <devname> set lbt <1|0>
...
Commands that use the netdev ('dev') can also be given the
'wdev' instead to identify the device.
...

Here it should be *wpan_dev*. And *iwpan* is not supporting
this command.

I used some thing like this:

root@beaglebone:~# iwpan wdev wpan0 info
Usage:	iwpan [options] command
Options:
	--debug		enable netlink debugging
	--version	show version (0.4)
Commands:
	phy <phyname> set channel <page> <channel>
	phy <phyname> set tx_power <dBm>
	phy <phyname> set cca_mode <mode|3 <1|0>>
	phy <phyname> set cca_ed_level <level>
...

Thanks.

-- 
Varka Bhadram

