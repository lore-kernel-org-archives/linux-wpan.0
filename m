Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38821 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933805AbbFJNpf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 09:45:35 -0400
Received: by wibdq8 with SMTP id dq8so48024725wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 06:45:34 -0700 (PDT)
Date: Wed, 10 Jun 2015 15:45:31 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 wpan-tools] info: update CCA mode and CCA options
 output
Message-ID: <20150610134530.GC6647@omega>
References: <20150610121712.GA6647@omega>
 <1433941675-4629-1-git-send-email-christoffer@christofferholmstedt.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433941675-4629-1-git-send-email-christoffer@christofferholmstedt.se>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 10, 2015 at 03:07:55PM +0200, Christoffer Holmstedt wrote:
> Instead of printing out CCA mode and CCA options in integers descriptive
> text is now printed to the user when "iwpan list" is run.
> 
> Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> ---
> I think I got all the changes right now as requested.
> 
> Changes v3 -> v4:
> * Sent "nl802154: fix misspelled enum" patch separately (already merged).
> * Did a "fixup" of remaining two patches so it is only one now.
> * Changed "random" value of 99 to NL802154_CCA_OPT_ATTR_MAX.
> 
> Changes v2 -> v3:
> * Fixed misspelled enum in nl802154
> 
> Changes v1 -> v2:
> * cca_mode number is removed from "current cca_mode", only text is printed as
> an example:
> 
>         cca_mode: Energy above threshold
>         was
>         cca_mode: 1, Energy above threshold
> 
> * Changed "enum" to string mapping in print_cca_mode_handler. Instead of
> printing out the strings in the function I return a tempbuf that is formatted
> by the caller.
> 
> * Added default value to cca_opt when printing current cca_mode and cca_opt. It
> is set to the "random" value of 99 as the enum only has 2 values, is this a
> proper solution? (or should we use limits.h with MAX_INT perhaps?)
> 
> 
>  src/info.c | 100 +++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 61 insertions(+), 39 deletions(-)
> 
> diff --git a/src/info.c b/src/info.c
> index 2434bef6a87f..9b0780df0262 100644
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
> +	case NL802154_CCA_UWB_MULTIPLEXED:
> +		return "UWB preamble sense based on the packet with the multiplexed preamble";
> +	default:
> +		sprintf(cca_mode_buf, "Unknown CCA mode (%d)", cca_mode);
> +		return cca_mode_buf;
> +	}
> +}
> +

sorry, I see this now. Why not simple making this return values void of
this function and doing instead of:

return "Carrier sense with energy above threshold (logical operator is
'or')";

a:

sprintf(cca_mode_buf, "%s", "Carrier sense with energy above threshold
(logical operator is 'or')");



and always use the cca_mode_buf afterwards for printing.
Is this possible?


Then you can directly use the parameters for baking the cca_mode string,
like:
sprintf(cca_mode, "mode %d, %s", cca_mode, "cca mode description");

After calling that function you can call:
printf("additional stuff %s\n", cca_mode_buf);


The function print_cca_mode_handler should be a helper function only to
place the cca description inside the cca_mode_buf and it can be used
until the next call of print_cca_mode_handler by printf or something
else.

- Alex
