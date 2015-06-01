Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:45505 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750890AbbFAGMx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 02:12:53 -0400
Date: Mon, 1 Jun 2015 08:12:44 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [RFC wpan-tools] info: add frequency output to channel listing
Message-ID: <20150601061244.GA3435@probook-6560b>
References: <20150529121556.GA7422@raspberrypi>
 <20150531122448.GB1476@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150531122448.GB1476@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Sun, May 31, 2015 at 02:24:49PM +0200, Alexander Aring wrote:
> On Fri, May 29, 2015 at 12:16:03PM +0000, Christoffer Holmstedt wrote:
> >  
> >  	if (tb_msg[NL802154_ATTR_CHANNEL])
> > -		printf("current_channel: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
> > +	{
> > +		unsigned char curr_channel;
> > +		curr_channel = nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]);
> > +		printf("current_channel: %d (", curr_channel);
> > +		print_freq(nla_get_u8(tb_msg[NL802154_ATTR_PAGE]), curr_channel);
> 
> Also this is problematic, because we don't check before if
> tb_msg[NL802154_ATTR_PAGE] isn't null.
> 
> When you like to use this value there, the easiest way would be:
> 
> if (tb_msg[NL802154_ATTR_CHANNEL] && tb_msg[NL802154_ATTR_PAGE])
> 
> instead of
> 
> if (tb_msg[NL802154_ATTR_CHANNEL]) above.
> 
> - Alex

Of course, will fix that.

-- 
Christoffer Holmstedt
