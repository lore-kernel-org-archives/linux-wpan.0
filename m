Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:45616 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751239AbbFAICb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 04:02:31 -0400
Date: Mon, 1 Jun 2015 10:02:28 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [RFC wpan-tools] info: add frequency output to channel listing
Message-ID: <20150601080228.GB3435@probook-6560b>
References: <20150529121556.GA7422@raspberrypi>
 <20150531113732.GA1476@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150531113732.GA1476@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Sun, May 31, 2015 at 01:37:35PM +0200, Alexander Aring wrote:
> Hi,
> 
> On Fri, May 29, 2015 at 12:16:03PM +0000, Christoffer Holmstedt wrote:
> > Add the frequency to the channel numbers output when
> > running "iwpan list". The output now looks like this:
> > 
> > 	supported channels:
> > 		page 0:
> > 			[11] 2405 MHz
> > 			[12] 2410 MHz
> > 			[13] 2415 MHz
> > 			[14] 2420 MHz
> > 			[15] 2425 MHz
> > 			[16] 2430 MHz
> > 			[17] 2435 MHz
> > 			[18] 2440 MHz
> > 			[19] 2445 MHz
> > 			[20] 2450 MHz
> > 			[21] 2455 MHz
> > 			[22] 2460 MHz
> > 			[23] 2465 MHz
> > 			[24] 2470 MHz
> > 			[25] 2475 MHz
> > 			[26] 2480 MHz
> > 	current_page: 0
> > 
> 
> I think to have the information which frequency it is - is a very nice
> feature for the userspace software. So I of course like to have a
> feature like this.

Good ;)

> 
> I tested it with the fakelb driver which have a lot of supported
> channels according to the page. The channel listing will be 117 lines,
> so fakelb is here a special case, but maybe we can do ~3 frequencies per
> line sperarated with comma and a tab. After ~3 frequencies then starts a
> newline again.
> 
> Example:
> 
> 		page 0:
> 			[11] 2405 MHz,	[12] 2410 MHz,	[13] 2415 MHz,
> 			[14] 2420 MHz,	[15] 2425 MHz,	[16] 2430 MHz,
> 			[17] 2435 MHz,	[18] 2440 MHz,	[19] 2445 MHz,
> 			....
> 
> (normally, it should something which fits in 80 chars terminal width)
> 
> don't know if this is the best idea. Or we introduce some verbose output
> option. 

Right. I started printing them out one by one without linebreaks but the
alignment didn't work out very well (hard to read) so I skipped that solution.
I will try your idea to do 3 or perhaps even 4 or 5 channels per line with
alignment.

> 
> > 	current_channel: 13 (2415 MHz)
> 
> This is very nice. :-)
> 
> Also I detected that I get a lot of:
> 
> 
> 	page 1:
>                 [0]  MHz 
>                 [1]  MHz 
>                 [2]  MHz 
>                 [3]  MHz 
>                 [4]  MHz 
>                 [5]  MHz 
>                 [6]  MHz 
>                 [7]  MHz 
>                 [8]  MHz 
>                 [9]  MHz 
>                 [10]  MHz
> 
> with the fakelb driver. I suppose this is only because you implemented
> page 0 only. Maybe do a "[0] unknown MHz", here? Just added the wort
> "unknown".

Correct, only page 0 so far, "unknown" looks like a good addition. I will use
"fakelb" to test future improvements (frequencies that I otherwise can't test).

> 
> 
> Another note is that this should be implemented to the new channel/page
> attr style which is part of the phy capabilities [0]. Currently there exists
> two implementations to get the supported channel/page attributes. The
> one which you implemented is obsolete and exists to deal with old kernel
> versions only. We will remove it in the next releases. So please use the
> capability output at [0] for channel dump.
> (There I did no format string fail. :-))

aha, that's why channels were listed twice in iwpan output.

> 
> > Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> > ---
> > Just added implementation for channel page 0 but wanted to know if I'm on the
> > right track here. Any feedback concerning visual output and implementation
> > is appreciated.
> > 
> >  src/info.c |   43 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 40 insertions(+), 3 deletions(-)
> > 
> > diff --git a/src/info.c b/src/info.c
> > index e8f5dda8da94..86e4dc4e4a14 100644
> > --- a/src/info.c
> > +++ b/src/info.c
> > @@ -23,6 +23,33 @@ static void print_minmax_handler(int min, int max)
> >  	printf("\b \n");
> >  }
> >  
> > +static void print_freq(int page, int channel)
> > +{
> > +	float freq = 0;
> > +
> > +	switch (page) {
> > +	case 0:
> > +		if (channel == 0) {
> > +			freq = 868.3;
> > +			printf("%.1f", freq);
> > +			break;
> > +		}
> > +		else if (channel > 0 && channel < 11) {
> > +			freq = 906 + 2 * (channel - 1);
> > +		}
> > +		else {
> > +			freq = 2405 + 5 * (channel - 11);
> > +		}
> > +		printf("%.0f", freq);
> > +		break;
> > +	default:
> > +		/* Unknown page */
> > +		break;
> > +	}
> > +
> > +
> > +}
> > +
> >  static int print_phy_handler(struct nl_msg *msg, void *arg)
> >  {
> >  	struct nlattr *tb_msg[NL802154_ATTR_MAX + 1];
> > @@ -54,10 +81,14 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
> >  				    rem_page) {
> >  			channel = nla_get_u32(nl_page);
> >  			if (channel) {
> > -				printf("\tpage %d: ", page, channel);
> 
> mhh, this looks wrong right now. The format string describes only one
> argument, but we have "page, channel" there. There must be page only.
> Can you send a fix for this?

Yea, I was thinking about that it looked like a leftover from some refactoring
but didn't dig into the git history. I will send a patch during the day.

> 
> - Alex
> 
> [0] https://github.com/linux-wpan/wpan-tools/blob/master/src/info.c#L147

-- 
Christoffer Holmstedt
