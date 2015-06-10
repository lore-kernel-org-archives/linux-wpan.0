Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36578 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbbFJMUP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 08:20:15 -0400
Received: by wigg3 with SMTP id g3so46504781wig.1
        for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 05:20:13 -0700 (PDT)
Date: Wed, 10 Jun 2015 14:17:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v3 wpan-tools 1/3] info: add cca mode descriptive text to
 output
Message-ID: <20150610121712.GA6647@omega>
References: <20150604092001.GA8027@probook-6560b>
 <1433935089-27119-1-git-send-email-christoffer@christofferholmstedt.se>
 <1433935089-27119-2-git-send-email-christoffer@christofferholmstedt.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433935089-27119-2-git-send-email-christoffer@christofferholmstedt.se>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 10, 2015 at 01:18:07PM +0200, Christoffer Holmstedt wrote:
> Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> ---
>  src/info.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/src/info.c b/src/info.c
> index 2434bef6a87f..364c02f718aa 100644
> --- a/src/info.c
> +++ b/src/info.c
> @@ -146,6 +146,41 @@ static void print_freq_handler(int channel_page, int channel)
>  	}
>  }
>  
> +static char cca_mode_buf[100];
> +
> +const char *print_cca_mode_handler(enum nl802154_cca_modes cca_mode,
> +				   enum nl802154_cca_opts cca_opt)
> +{
> +	switch (cca_mode) {
> +	case NL802154_CCA_ENERGY:
> +		return "Energy above threshold";
> +	case NL802154_CCA_CARRIER:
> +		return "Carrier sense only";
> +	case NL802154_CCA_ENERGY_CARRIER:
> +		switch (cca_opt) {
> +		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
> +			return "Carrier sense with energy above threshold (logical operator is 'and')";
> +		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
> +			return "Carrier sense with energy above threshold (logical operator is 'or')";
> +		default:
> +			sprintf(cca_mode_buf,
> +				"Unknown CCA option (%d) for CCA mode (%d)",
> +				cca_opt,
> +				cca_mode);
> +			return cca_mode_buf;
> +		}
> +	case NL802154_CCA_ALOHA:
> +		return "ALOHA";
> +	case NL802154_CCA_UWB_SHR:
> +		return "UWB preamble sense based on the SHR of a frame";
> +	case NL802154_CCA_UWB_MULTIPEXED:
> +		return "UWB preamble sense based on the packet with the multiplexed preamble";
> +	default:
> +		sprintf(cca_mode_buf, "Unknown CCA mode (%d)", cca_mode);
> +		return cca_mode_buf;
> +	}
> +}
> +
>  static const char *commands[NL802154_CMD_MAX + 1] = {
>  	[NL802154_CMD_UNSPEC] = "unspec",
>  	[NL802154_CMD_GET_WPAN_PHY] = "get_wpan_phy",
> @@ -235,23 +270,13 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
>  	}
>  
>  	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
> +		enum nl802154_cca_opts cca_opt = 99;

use:

NL802154_CCA_OPT_ATTR_MAX

should always be invalid. Maybe there exists a better way to evaluate
the tb_msg[NL802154_ATTR_CCA_MODE] first when somewhere is a cca_mode
which have some option (like cca_mode == 3). I don't know how to do it
_exactly_ better now. I am fine with your current solution.

Can you try to add first a patch which updates the nl802154.h from the
kernel "just for syncing" and then replace the cca_mode printout. And
please fixup patch 2 with 1.

Then you have:

1. patch which sync the nl802154 header with the kernel
2. patch which replace the cca modes printout with your implementation.


Current behaviour would have some state in wpan-tools which we
havn't any cca output, this is the case when I apply patch 1 only in your
series.

- Alex
