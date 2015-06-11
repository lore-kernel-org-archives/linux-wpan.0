Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47767 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932441AbbFKLOZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 11 Jun 2015 07:14:25 -0400
Date: Thu, 11 Jun 2015 13:14:12 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [PATCH v4 wpan-tools] info: update CCA mode and CCA options
 output
Message-ID: <20150611111402.GA8823@arazu>
References: <20150610121712.GA6647@omega>
 <1433941675-4629-1-git-send-email-christoffer@christofferholmstedt.se>
 <20150611101416.GC972@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150611101416.GC972@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 11, 2015 at 12:14:20PM +0200, Alexander Aring wrote:
> On Wed, Jun 10, 2015 at 03:07:55PM +0200, Christoffer Holmstedt wrote:
> > Instead of printing out CCA mode and CCA options in integers descriptive
> > text is now printed to the user when "iwpan list" is run.
> > 
> > Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> 
> I would apply this patch now. This is the nearest solution which I would
> ack. Reason see below. Tell me if you are fine with that.
> 

So v4 rather than v5?

(I will prepare version 6).

> 
> > ---
> > I think I got all the changes right now as requested.
> > 
> > Changes v3 -> v4:
> > * Sent "nl802154: fix misspelled enum" patch separately (already merged).
> > * Did a "fixup" of remaining two patches so it is only one now.
> > * Changed "random" value of 99 to NL802154_CCA_OPT_ATTR_MAX.
> > 
> > Changes v2 -> v3:
> > * Fixed misspelled enum in nl802154
> > 
> > Changes v1 -> v2:
> > * cca_mode number is removed from "current cca_mode", only text is printed as
> > an example:
> > 
> >         cca_mode: Energy above threshold
> >         was
> >         cca_mode: 1, Energy above threshold
> > 
> 
> The reason why we have the helper function is too have the look and feel
> everywhere the same for the one enum definition.
> 

I agree.

> > * Changed "enum" to string mapping in print_cca_mode_handler. Instead of
> > printing out the strings in the function I return a tempbuf that is formatted
> > by the caller.
> > 
> > * Added default value to cca_opt when printing current cca_mode and cca_opt. It
> > is set to the "random" value of 99 as the enum only has 2 values, is this a
> > proper solution? (or should we use limits.h with MAX_INT perhaps?)
> > 
> > 
> >  src/info.c | 100 +++++++++++++++++++++++++++++++++++++------------------------
> >  1 file changed, 61 insertions(+), 39 deletions(-)
> > 
> > diff --git a/src/info.c b/src/info.c
> > index 2434bef6a87f..9b0780df0262 100644
> > --- a/src/info.c
> > +++ b/src/info.c
> > @@ -146,6 +146,41 @@ static void print_freq_handler(int channel_page, int channel)
> >  	}
> >  }
> >  
> > +static char cca_mode_buf[100];
> > +
> > +const char *print_cca_mode_handler(enum nl802154_cca_modes cca_mode,
> > +				   enum nl802154_cca_opts cca_opt)
> > +{
> > +	switch (cca_mode) {
> > +	case NL802154_CCA_ENERGY:
> > +		return "Energy above threshold";
> 
> Don't add the enum numbers afterwards, do that here with sprintf and
> return the cca_mode_buf. Like you did that for the default case of
> cca_opt.
> 
> Example:
> 
> You do afterwards:
> printf("\n\t\t(%d) %s"....);
> 
> then simple do a:
> 
> sprintf(cca_mode_buf, "(%d) %s", cca_mode, "Energy above threshold");
> return cca_mode_buf;
> 
> If you _really_ like to remove the cca_mode _number_ (in case of current
> cca), then make some bool argument with_numbers and change the format string
> here.
> 

Yea, that is a much better solution. I will update with another patch but will
leave the optional exclusion of cca_mode integer for the future.

> > +	case NL802154_CCA_CARRIER:
> > +		return "Carrier sense only";
> > +	case NL802154_CCA_ENERGY_CARRIER:
> > +		switch (cca_opt) {
> > +		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
> > +			return "Carrier sense with energy above threshold (logical operator is 'and')";
> > +		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
> > +			return "Carrier sense with energy above threshold (logical operator is 'or')";
> > +		default:
> > +			sprintf(cca_mode_buf,
> > +				"Unknown CCA option (%d) for CCA mode (%d)",
> > +				cca_opt,
> > +				cca_mode);
> > +			return cca_mode_buf;
> > +		}
> > +	case NL802154_CCA_ALOHA:
> > +		return "ALOHA";
> > +	case NL802154_CCA_UWB_SHR:
> > +		return "UWB preamble sense based on the SHR of a frame";
> > +	case NL802154_CCA_UWB_MULTIPLEXED:
> > +		return "UWB preamble sense based on the packet with the multiplexed preamble";
> > +	default:
> > +		sprintf(cca_mode_buf, "Unknown CCA mode (%d)", cca_mode);
> > +		return cca_mode_buf;
> > +	}
> > +}
> > +
> >  static const char *commands[NL802154_CMD_MAX + 1] = {
> >  	[NL802154_CMD_UNSPEC] = "unspec",
> >  	[NL802154_CMD_GET_WPAN_PHY] = "get_wpan_phy",
> > @@ -235,23 +270,13 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
> >  	}
> >  
> >  	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
> > +		enum nl802154_cca_opts cca_opt = NL802154_CCA_OPT_ATTR_MAX;
> > +		if (tb_msg[NL802154_ATTR_CCA_OPT])
> > +			cca_opt = nla_get_u32(tb_msg[NL802154_ATTR_CCA_OPT]);
> > +
> >  		cca_mode = nla_get_u32(tb_msg[NL802154_ATTR_CCA_MODE]);
> > -		printf("cca_mode: %d", cca_mode);
> > -		if (cca_mode == NL802154_CCA_ENERGY_CARRIER) {
> > -			enum nl802154_cca_opts cca_opt;
> >  
> > -			cca_opt = nla_get_u32(tb_msg[NL802154_ATTR_CCA_OPT]);
> > -			switch (cca_opt) {
> > -			case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
> > -				printf(" logical and ");
> > -				break;
> > -			case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
> > -				printf(" logical or ");
> > -				break;
> > -			default:
> > -				printf(" logical op mode unkown ");
> > -			}
> > -		}
> > +		printf("cca_mode: %s", print_cca_mode_handler(cca_mode, cca_opt));
> >  		printf("\n");
> >  	}
> >  
> > @@ -361,33 +386,30 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
> >  			printf("\tcca_modes: ");
> >  			nla_for_each_nested(nl_cca_modes,
> >  					    tb_caps[NL802154_CAP_ATTR_CCA_MODES],
> > -					    rem_cca_modes)
> > -				printf("%d,", nla_type(nl_cca_modes));
> > -			/* TODO */
> > -			printf("\b \n");
> > -		}
> > -
> > -		if (tb_caps[NL802154_CAP_ATTR_CCA_OPTS]) {
> > -			struct nlattr *nl_cca_opts;
> > -			int rem_cca_opts;
> > -
> > -			printf("\tcca_opts: ");
> > -			nla_for_each_nested(nl_cca_opts,
> > -					    tb_caps[NL802154_CAP_ATTR_CCA_OPTS],
> > -					    rem_cca_opts) {
> > -				printf("%d", nla_type(nl_cca_opts));
> > -				switch (nla_type(nl_cca_opts)) {
> > -				case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
> > -				case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
> > -					printf("(cca_mode: 3),");
> > -					break;
> > -				default:
> > -					printf("unkown\n");
> > -					break;
> > +					    rem_cca_modes) {
> > +				if (nla_type(nl_cca_modes) != NL802154_CCA_ENERGY_CARRIER) {
> > +					printf("\n\t\t(%d) %s",
> > +						nla_type(nl_cca_modes),
> > +						print_cca_mode_handler(nla_type(nl_cca_modes), 0));
> > +				} else {
> > +					if (tb_caps[NL802154_CAP_ATTR_CCA_OPTS]) {
> > +						struct nlattr *nl_cca_opts;
> > +						int rem_cca_opts;
> > +
> > +						nla_for_each_nested(nl_cca_opts,
> > +								    tb_caps[NL802154_CAP_ATTR_CCA_OPTS],
> > +								    rem_cca_opts) {
> > +
> > +							printf("\n\t\t(%d, cca_opt: %d) %s",
> > +								nla_type(nl_cca_modes),
> > +								nla_type(nl_cca_opts),
> > +								print_cca_mode_handler(nla_type(nl_cca_modes), nla_type(nl_cca_opts)));
> 
> Replace this one then with:
> 
> printf("\n\t\t%s", print_cca_mode_handler(nla_type(nl_cca_modes), nla_type(nl_cca_opts)));
> 
> no special handling is needed here anymore for NL802154_CCA_ENERGY_CARRIER.
> 
> - Alex

True. Will do that.

-- 
Christoffer Holmstedt
