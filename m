Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36500 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbFKHmV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Jun 2015 03:42:21 -0400
Received: by wgbgq6 with SMTP id gq6so49665071wgb.3
        for <linux-wpan@vger.kernel.org>; Thu, 11 Jun 2015 00:42:20 -0700 (PDT)
Date: Thu, 11 Jun 2015 09:42:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 wpan-tools] info: update CCA mode and CCA options
 output
Message-ID: <20150611074206.GA972@omega>
References: <20150610121712.GA6647@omega>
 <1433941675-4629-1-git-send-email-christoffer@christofferholmstedt.se>
 <20150610134530.GC6647@omega>
 <20150611061633.GA2792@arazu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150611061633.GA2792@arazu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 11, 2015 at 08:16:33AM +0200, Christoffer Holmstedt wrote:
> On Wed, Jun 10, 2015 at 03:45:31PM +0200, Alexander Aring wrote:
> > On Wed, Jun 10, 2015 at 03:07:55PM +0200, Christoffer Holmstedt wrote:
> > > Instead of printing out CCA mode and CCA options in integers descriptive
> > > text is now printed to the user when "iwpan list" is run.
> > > 
> > > Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> > > ---
> > > I think I got all the changes right now as requested.
> > > 
> > > Changes v3 -> v4:
> > > * Sent "nl802154: fix misspelled enum" patch separately (already merged).
> > > * Did a "fixup" of remaining two patches so it is only one now.
> > > * Changed "random" value of 99 to NL802154_CCA_OPT_ATTR_MAX.
> ...cut...
> > > +	case NL802154_CCA_UWB_SHR:
> > > +		return "UWB preamble sense based on the SHR of a frame";
> > > +	case NL802154_CCA_UWB_MULTIPLEXED:
> > > +		return "UWB preamble sense based on the packet with the multiplexed preamble";
> > > +	default:
> > > +		sprintf(cca_mode_buf, "Unknown CCA mode (%d)", cca_mode);
> > > +		return cca_mode_buf;
> > > +	}
> > > +}
> > > +
> > 
> > sorry, I see this now. Why not simple making this return values void of
> > this function and doing instead of:
> > 
> 
> No need to say sorry, I appreciate all the feedback I can get. I hope I can
> return the favor in the future when I know the code base a little bit more.
> 
> > return "Carrier sense with energy above threshold (logical operator is
> > 'or')";
> > 
> > a:
> > 
> > sprintf(cca_mode_buf, "%s", "Carrier sense with energy above threshold
> > (logical operator is 'or')");
> > and always use the cca_mode_buf afterwards for printing.
> > Is this possible?
> > 
> Yes it is possible, I just prepared a patch for the change (haven't sent it to
> the list yet), will send it later today. One question first, should the
> declaration of the "cca_mode_buf" (file scope) be put at the top of the file or
> just above the helper function using it?
> 
> > 
> > Then you can directly use the parameters for baking the cca_mode string,
> > like:
> > sprintf(cca_mode, "mode %d, %s", cca_mode, "cca mode description");
> > 
> > After calling that function you can call:
> > printf("additional stuff %s\n", cca_mode_buf);
> > 
> > 
> > The function print_cca_mode_handler should be a helper function only to
> > place the cca description inside the cca_mode_buf and it can be used
> > until the next call of print_cca_mode_handler by printf or something
> > else.
> > 
> > - Alex
> 
> This new solution makes much more sense to me. The first implementation was
> inspired by *iftype_name() from interface.c, perhaps that should be refactored
> as well.
> 

then better maybe would be to leave the return value as "const char *"
there and returning the buffer. Just if you need to "bake" some string
with an format string, then use the temp buffer and build your string and
return the buffer.

If it's just a "const char *" then just 'return "foobar";'  but this
isn't your case here because you want to put some numbers in there, for
cca handling.

It's just:
The return of the temporary buffer allows us to use the helper printout
functionality also from another c-file when the buffer is declared as
static buffer.

- Alex
