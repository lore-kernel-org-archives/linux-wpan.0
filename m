Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56396 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755423AbbHFRux (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 6 Aug 2015 13:50:53 -0400
Subject: Re: [PATCH wpan-tools] mac: add handling for ackreq default handling
References: <1438772472-9646-1-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55C39E7A.8050306@osg.samsung.com>
Date: Thu, 6 Aug 2015 19:50:50 +0200
MIME-Version: 1.0
In-Reply-To: <1438772472-9646-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 05/08/15 13:01, Alexander Aring wrote:
> This patch adds support to change the ack request default handling,
> which indicates the default behaviour for the acknowledge request bit
> of 802.15.4 frames.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   src/interface.c |  2 ++
>   src/mac.c       | 28 ++++++++++++++++++++++++++++
>   src/nl802154.h  |  4 ++++
>   3 files changed, 34 insertions(+)
>
> diff --git a/src/interface.c b/src/interface.c
> index 647247b..85d40a8 100644
> --- a/src/interface.c
> +++ b/src/interface.c
> @@ -223,6 +223,8 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
>   		printf("%s\tmax_csma_backoffs %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_MAX_CSMA_BACKOFFS]));
>   	if (tb_msg[NL802154_ATTR_LBT_MODE])
>   		printf("%s\tlbt %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_LBT_MODE]));
> +	if (tb_msg[NL802154_ATTR_ACKREQ_DEFAULT])
> +		printf("%s\tackreq_default %d\n", indent, nla_get_u8(tb_msg[NL802154_ATTR_ACKREQ_DEFAULT]));
>   
>   	return NL_SKIP;
>   }
> diff --git a/src/mac.c b/src/mac.c
> index 703d09f..76db58f 100644
> --- a/src/mac.c
> +++ b/src/mac.c
> @@ -185,3 +185,31 @@ nla_put_failure:
>   }
>   COMMAND(set, lbt, "<1|0>",
>   	NL802154_CMD_SET_LBT_MODE, 0, CIB_NETDEV, handle_lbt_mode, NULL);
> +
> +static int handle_ackreq_default(struct nl802154_state *state,
> +				 struct nl_cb *cb,
> +				 struct nl_msg *msg,
> +				 int argc, char **argv,
> +				 enum id_input id)
> +{
> +	unsigned long ackreq;
> +	char *end;
> +
> +	if (argc < 1)
> +		return 1;
> +
> +	/* ACKREQ_DEFAULT */
> +	ackreq = strtoul(argv[0], &end, 0);
> +	if (*end != '\0')
> +		return 1;
> +
> +	NLA_PUT_U8(msg, NL802154_ATTR_ACKREQ_DEFAULT, ackreq);
> +
> +	return 0;
> +
> +nla_put_failure:
> +	return -ENOBUFS;
> +}
> +COMMAND(set, ackreq_default, "<1|0>",
> +	NL802154_CMD_SET_ACKREQ_DEFAULT, 0, CIB_NETDEV, handle_ackreq_default,
> +	NULL);
> diff --git a/src/nl802154.h b/src/nl802154.h
> index b0ab530..cf2713d 100644
> --- a/src/nl802154.h
> +++ b/src/nl802154.h
> @@ -52,6 +52,8 @@ enum nl802154_commands {
>   
>   	NL802154_CMD_SET_LBT_MODE,
>   
> +	NL802154_CMD_SET_ACKREQ_DEFAULT,
> +
>   	/* add new commands above here */
>   
>   	/* used to define NL802154_CMD_MAX below */
> @@ -104,6 +106,8 @@ enum nl802154_attrs {
>   
>   	NL802154_ATTR_SUPPORTED_COMMANDS,
>   
> +	NL802154_ATTR_ACKREQ_DEFAULT,
> +
>   	/* add attributes here, update the policy in nl802154.c */
>   
>   	__NL802154_ATTR_AFTER_LAST,

Tested this against the kernel patches.

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt
