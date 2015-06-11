Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47670 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751090AbbFKIN7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 11 Jun 2015 04:13:59 -0400
Date: Thu, 11 Jun 2015 10:13:50 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [PATCH v4 wpan-tools] info: update CCA mode and CCA options
 output
Message-ID: <20150611081350.GA5265@arazu>
References: <20150610121712.GA6647@omega>
 <1433941675-4629-1-git-send-email-christoffer@christofferholmstedt.se>
 <20150610134530.GC6647@omega>
 <20150611061633.GA2792@arazu>
 <20150611074206.GA972@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150611074206.GA972@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Jun 11, 2015 at 09:42:10AM +0200, Alexander Aring wrote:
> On Thu, Jun 11, 2015 at 08:16:33AM +0200, Christoffer Holmstedt wrote:
> > On Wed, Jun 10, 2015 at 03:45:31PM +0200, Alexander Aring wrote:
...cut...
> > > 
> > > The function print_cca_mode_handler should be a helper function only to
> > > place the cca description inside the cca_mode_buf and it can be used
> > > until the next call of print_cca_mode_handler by printf or something
> > > else.
> > > 
> > > - Alex
> > 
> > This new solution makes much more sense to me. The first implementation was
> > inspired by *iftype_name() from interface.c, perhaps that should be refactored
> > as well.
> > 
> 
> then better maybe would be to leave the return value as "const char *"
> there and returning the buffer. Just if you need to "bake" some string
> with an format string, then use the temp buffer and build your string and
> return the buffer.
> 
> If it's just a "const char *" then just 'return "foobar";'  but this
> isn't your case here because you want to put some numbers in there, for
> cca handling.
> 
> It's just:
> The return of the temporary buffer allows us to use the helper printout
> functionality also from another c-file when the buffer is declared as
> static buffer.
> 
> - Alex

aah, yes accessing the value from other files.

Not sure about the first two paragraphs though...a patch is coming up (separate
email) for info.c and if needed interface.c can be discussed yet in another
thread.

-- 
Christoffer Holmstedt
