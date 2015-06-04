Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34967 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbFDLBY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 07:01:24 -0400
Received: by wgme6 with SMTP id e6so30652490wgm.2
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 04:01:23 -0700 (PDT)
Date: Thu, 4 Jun 2015 13:01:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 1/2] info: add cca mode descriptive text to
 output
Message-ID: <20150604110113.GA24599@omega>
References: <20150604092036.GA8041@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150604092036.GA8041@probook-6560b>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 04, 2015 at 11:20:42AM +0200, Christoffer Holmstedt wrote:
> Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> ---
>  src/info.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 62 insertions(+), 18 deletions(-)
> 
> diff --git a/src/info.c b/src/info.c
> index 2434bef6a87f..d2e88febd20c 100644
> --- a/src/info.c
> +++ b/src/info.c
> @@ -146,6 +146,41 @@ static void print_freq_handler(int channel_page, int channel)
>  	}
>  }
>  
> +static void print_cca_mode_handler(enum nl802154_cca_modes cca_mode,
> +				   enum nl802154_cca_opts cca_opt)
> +{
> +	switch (cca_mode) {
> +	case NL802154_CCA_ENERGY:
> +		printf("energy above threshold");
> +		break;
> +	case NL802154_CCA_CARRIER:
> +		printf("carrier sense only");
> +		break;
> +	case NL802154_CCA_ENERGY_CARRIER:
> +		printf("carrier sense with energy above threshold");
> +		switch (cca_opt) {
> +		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
> +			printf(" (logical operator is 'and')");
> +			break;
> +		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
> +			printf(" (logical operator is 'or')");
> +			break;
> +		default:
> +			printf(" (logical operator is unknown)");
> +		}
> +		break;
> +	case NL802154_CCA_ALOHA:
> +		printf("ALOHA");
> +		break;
> +	case NL802154_CCA_UWB_SHR:
> +		printf("UWB preamble sense based on the SHR of a frame");
> +		break;
> +	case NL802154_CCA_UWB_MULTIPEXED:
> +		printf("UWB preamble sense based on the packet with the multiplexed preamble");
> +		break;
> +	}
> +}
> +

mhhh, there exists now two different styles to making some "enum" ->
string mapping. The first one was (and this is the original way which
was grabbed from wireless) to have some temp buffer and use sprintf to
put the string in there.

This is a more generic way. After calling the function we should use
printf to printout the string with some format string. You know what I
mean? We should change this.

So what I mean is here use in this function sprintf and put the mapping
string into a local buffer, not directly printf. You can do that after
calling this function.

>  static const char *commands[NL802154_CMD_MAX + 1] = {
>  	[NL802154_CMD_UNSPEC] = "unspec",
>  	[NL802154_CMD_GET_WPAN_PHY] = "get_wpan_phy",
> @@ -235,23 +270,14 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
>  	}
>  
>  	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
> +		enum nl802154_cca_opts cca_opt;

init this with a invalid value, so default case will occur if not
NL802154_ATTR_CCA_OPT is there.

> +		if (tb_msg[NL802154_ATTR_CCA_OPT])
> +			cca_opt = nla_get_u32(tb_msg[NL802154_ATTR_CCA_OPT]);
> +
>  		cca_mode = nla_get_u32(tb_msg[NL802154_ATTR_CCA_MODE]);
> -		printf("cca_mode: %d", cca_mode);
> -		if (cca_mode == NL802154_CCA_ENERGY_CARRIER) {
> -			enum nl802154_cca_opts cca_opt;
>  
> -			cca_opt = nla_get_u32(tb_msg[NL802154_ATTR_CCA_OPT]);
> -			switch (cca_opt) {
> -			case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
> -				printf(" logical and ");
> -				break;
> -			case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
> -				printf(" logical or ");
> -				break;
> -			default:
> -				printf(" logical op mode unkown ");
> -			}
> -		}
> +		printf("cca_mode: %d, ", cca_mode);
> +		print_cca_mode_handler(cca_mode, cca_opt);
>  		printf("\n");

- Alex
