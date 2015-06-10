Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47419 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933509AbbFJJdr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 05:33:47 -0400
Date: Wed, 10 Jun 2015 11:33:42 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [PATCH bluetooth-next] nl802154: fix misspelled enum
Message-ID: <20150610093342.GB22796@arazu>
References: <1433927039-21975-1-git-send-email-christoffer@christofferholmstedt.se>
 <20150610092351.GC947@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150610092351.GC947@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 10, 2015 at 11:23:52AM +0200, Alexander Aring wrote:
> On Wed, Jun 10, 2015 at 11:03:59AM +0200, christoffer@christofferholmstedt.se wrote:
> > From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> > 
> > Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> > ---
> >  include/net/nl802154.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> > index 6fc231e60920..b796561188d6 100644
> > --- a/include/net/nl802154.h
> > +++ b/include/net/nl802154.h
> > @@ -199,7 +199,7 @@ enum nl802154_cca_modes {
> >  	NL802154_CCA_ENERGY_CARRIER,
> >  	NL802154_CCA_ALOHA,
> >  	NL802154_CCA_UWB_SHR,
> > -	NL802154_CCA_UWB_MULTIPEXED,
> > +	NL802154_CCA_UWB_MULTIPLEXED,
> >  
> 
> What's about to fixing the comment as well? 0:-)
> 
> - Alex

Bummer, missed that one...first something to eat for lunch then another patch
;)

-- 
Christoffer Holmstedt
