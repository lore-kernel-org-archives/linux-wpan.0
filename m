Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33847 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbbFBHGd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 03:06:33 -0400
Received: by wgv5 with SMTP id 5so132098957wgv.1
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 00:06:32 -0700 (PDT)
Date: Tue, 2 Jun 2015 09:06:26 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC wpan-tools] nl802154: export supported commands
Message-ID: <20150602070622.GA1977@omega>
References: <1433223636-22585-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433223636-22585-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Tue, Jun 02, 2015 at 11:10:36AM +0530, Varka Bhadram wrote:
> This patch list the supported commands by the radios.
> Output format is like this.
> ...
> Supported commands:
> 	* new_interface
> 	* del_interface
> 	* set_channel
> 	* set_pan_id
> 	* set_short_addr
> 	* set_tx_power
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  src/Makefile.am |    1 +
>  src/info.c      |    9 +++++++++
>  src/iwpan.h     |    1 +
>  src/nl802154.h  |    2 ++
>  src/util.c      |   35 +++++++++++++++++++++++++++++++++++
>  5 files changed, 48 insertions(+)
>  create mode 100644 src/util.c
> 
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 2d54576..234ff63 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -9,6 +9,7 @@ iwpan_SOURCES = \
>  	interface.c \
>  	phy.c \
>  	mac.c \
> +	util.c \
>  	nl_extras.h \
>  	nl802154.h
>  
> diff --git a/src/info.c b/src/info.c
> index e8f5dda..5b6d3b6 100644
> --- a/src/info.c
> +++ b/src/info.c
> @@ -262,6 +262,15 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
>  		}
>  	}
>  
> +	if (tb_msg[NL802154_ATTR_SUPPORTED_COMMANDS]) {
> +		struct nlattr *nl_cmd;
> +		int rem_cmd;
> +
> +		printf("Supported commands:\n");
> +		nla_for_each_nested(nl_cmd, tb_msg[NL802154_ATTR_SUPPORTED_COMMANDS], rem_cmd)
> +		printf("\t* %s\n", command_name(nla_get_u32(nl_cmd)));

You will be scared now, but nla_for_each_nested is a for-loop. Please
indent the printf right.

> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/src/iwpan.h b/src/iwpan.h
> index 48c4f03..4f026a2 100644
> --- a/src/iwpan.h
> +++ b/src/iwpan.h
> @@ -119,5 +119,6 @@ DECLARE_SECTION(set);
>  DECLARE_SECTION(get);
>  
>  const char *iftype_name(enum nl802154_iftype iftype);
> +const char *command_name(enum nl802154_commands cmd);
>  
>  #endif /* __IWPAN_H */
> diff --git a/src/nl802154.h b/src/nl802154.h
> index 0badebd..6fc231e 100644
> --- a/src/nl802154.h
> +++ b/src/nl802154.h
> @@ -102,6 +102,8 @@ enum nl802154_attrs {
>  
>  	NL802154_ATTR_WPAN_PHY_CAPS,
>  
> +	NL802154_ATTR_SUPPORTED_COMMANDS,
> +
>  	/* add attributes here, update the policy in nl802154.c */
>  
>  	__NL802154_ATTR_AFTER_LAST,
> diff --git a/src/util.c b/src/util.c
> new file mode 100644
> index 0000000..6c5fa67
> --- /dev/null
> +++ b/src/util.c
> @@ -0,0 +1,35 @@
> +#include "iwpan.h"
> +#include "nl802154.h"
> +
> +static const char *commands[NL802154_CMD_MAX + 1] = {
> +	[NL802154_CMD_UNSPEC] = "unspec",
> +	[NL802154_CMD_GET_WPAN_PHY] = "get_wpan_phy",
> +	[NL802154_CMD_SET_WPAN_PHY] = "set_wpan_phy",
> +	[NL802154_CMD_NEW_WPAN_PHY] = "new_wpan_phy",
> +	[NL802154_CMD_DEL_WPAN_PHY] = "del_wpan_phy",
> +	[NL802154_CMD_GET_INTERFACE] = "get_interface",
> +	[NL802154_CMD_SET_INTERFACE] = "set_interface",
> +	[NL802154_CMD_NEW_INTERFACE] = "new_interface",
> +	[NL802154_CMD_DEL_INTERFACE] = "del_interface",
> +	[NL802154_CMD_SET_CHANNEL] = "set_channel",
> +	[NL802154_CMD_SET_PAN_ID] = "set_pan_id",
> +	[NL802154_CMD_SET_SHORT_ADDR] = "set_short_addr",
> +	[NL802154_CMD_SET_TX_POWER] = "set_tx_power",
> +	[NL802154_CMD_SET_CCA_MODE] = "set_cca_mode",
> +	[NL802154_CMD_SET_CCA_ED_LEVEL] = "set_cca_ed_level",
> +	[NL802154_CMD_SET_MAX_FRAME_RETRIES] = "set_max_frame_retries",
> +	[NL802154_CMD_SET_BACKOFF_EXPONENT] = "set_backoff_exponent",
> +	[NL802154_CMD_SET_MAX_CSMA_BACKOFFS] = "set_max_csma_backoffs",
> +	[NL802154_CMD_SET_LBT_MODE] = "set_lbt_mode",
> +};
> +
> +static char cmdbuf[100];
> +
> +const char *command_name(enum nl802154_commands cmd)
> +{
> +	if (cmd <= NL802154_CMD_MAX && commands[cmd])
> +		return commands[cmd];
> +
> +	sprintf(cmdbuf, "Unknown command (%d)", cmd);
> +	return cmdbuf;
> +}

Such file makes only sense when it's used in more than one file. I don't
see this at the moment.

Btw: wireless "iw" used it in two files "info.c" and "event.c".

- Alex
