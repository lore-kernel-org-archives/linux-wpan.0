Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:46464 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752152AbbFDLzM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 07:55:12 -0400
Date: Thu, 4 Jun 2015 13:55:09 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [PATCH wpan-tools 1/2] info: add cca mode descriptive text to
 output
Message-ID: <20150604115509.GD3045@probook-6560b>
References: <20150604092036.GA8041@probook-6560b>
 <20150604110113.GA24599@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150604110113.GA24599@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 04, 2015 at 01:01:17PM +0200, Alexander Aring wrote:
> On Thu, Jun 04, 2015 at 11:20:42AM +0200, Christoffer Holmstedt wrote:
> > Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> > ---
> >  src/info.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 62 insertions(+), 18 deletions(-)
> > 
> > diff --git a/src/info.c b/src/info.c
> > index 2434bef6a87f..d2e88febd20c 100644
> > --- a/src/info.c
> > +++ b/src/info.c
> > @@ -146,6 +146,41 @@ static void print_freq_handler(int channel_page, int channel)
> >  	}
> >  }
> >  
> > +static void print_cca_mode_handler(enum nl802154_cca_modes cca_mode,
> > +				   enum nl802154_cca_opts cca_opt)
> > +{
> > +	switch (cca_mode) {
> > +	case NL802154_CCA_ENERGY:
> > +		printf("energy above threshold");
> > +		break;
> > +	case NL802154_CCA_CARRIER:
> > +		printf("carrier sense only");
> > +		break;
> > +	case NL802154_CCA_ENERGY_CARRIER:
> > +		printf("carrier sense with energy above threshold");
> > +		switch (cca_opt) {
> > +		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
> > +			printf(" (logical operator is 'and')");
> > +			break;
> > +		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
> > +			printf(" (logical operator is 'or')");
> > +			break;
> > +		default:
> > +			printf(" (logical operator is unknown)");
> > +		}
> > +		break;
> > +	case NL802154_CCA_ALOHA:
> > +		printf("ALOHA");
> > +		break;
> > +	case NL802154_CCA_UWB_SHR:
> > +		printf("UWB preamble sense based on the SHR of a frame");
> > +		break;
> > +	case NL802154_CCA_UWB_MULTIPEXED:
> > +		printf("UWB preamble sense based on the packet with the multiplexed preamble");
> > +		break;
> > +	}
> > +}
> > +
> 
> mhhh, there exists now two different styles to making some "enum" ->
> string mapping. The first one was (and this is the original way which
> was grabbed from wireless) to have some temp buffer and use sprintf to
> put the string in there.
> 
> This is a more generic way. After calling the function we should use
> printf to printout the string with some format string. You know what I
> mean? We should change this.

I think I do, just like the default case in iftype_name() function in
interface.c and is later on printed out with printf in print_iface_handler() in
interface.c

I will fix that.

> 
> So what I mean is here use in this function sprintf and put the mapping
> string into a local buffer, not directly printf. You can do that after
> calling this function.
> 
> >  static const char *commands[NL802154_CMD_MAX + 1] = {
> >  	[NL802154_CMD_UNSPEC] = "unspec",
> >  	[NL802154_CMD_GET_WPAN_PHY] = "get_wpan_phy",
> > @@ -235,23 +270,14 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
> >  	}
> >  
> >  	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
> > +		enum nl802154_cca_opts cca_opt;
> 
> init this with a invalid value, so default case will occur if not
> NL802154_ATTR_CCA_OPT is there.
> 

Right. I will fix that.

Concerning setting invalid values, for cca_modes we have an enum value for
invalid but for cca_opts we don't. Should I include limits.h and set MAX_INT or
just set a high random int value like 9999?

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
> > +		printf("cca_mode: %d, ", cca_mode);
> > +		print_cca_mode_handler(cca_mode, cca_opt);
> >  		printf("\n");
> 
> - Alex

-- 
Christoffer Holmstedt
