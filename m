Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47397 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754006AbbFJJRU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 05:17:20 -0400
Date: Wed, 10 Jun 2015 11:17:12 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: Re: [PATCH bluetooth-next] nl802154: fix misspelled enum
Message-ID: <20150610091712.GA22796@arazu>
References: <1433927039-21975-1-git-send-email-christoffer@christofferholmstedt.se>
 <ED2DD65D-D01C-4A4D-8BE6-23E997E686FE@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED2DD65D-D01C-4A4D-8BE6-23E997E686FE@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 10, 2015 at 11:12:48AM +0200, Marcel Holtmann wrote:
> Hi Christoffer,
> 
> > Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> > ---
> > include/net/nl802154.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> > index 6fc231e60920..b796561188d6 100644
> > --- a/include/net/nl802154.h
> > +++ b/include/net/nl802154.h
> > @@ -199,7 +199,7 @@ enum nl802154_cca_modes {
> > 	NL802154_CCA_ENERGY_CARRIER,
> > 	NL802154_CCA_ALOHA,
> > 	NL802154_CCA_UWB_SHR,
> > -	NL802154_CCA_UWB_MULTIPEXED,
> > +	NL802154_CCA_UWB_MULTIPLEXED,
> > 
> > 	/* keep last */
> > 	__NL802154_CCA_ATTR_AFTER_LAST,
> 
> I went ahead and applied this to bluetooth-tree. In case we actually have a user with the wrong name, we need to add a backwards compatible define to allow the wrong name. However for now, lets see if this has been used at all.
> 
> Regards
> 
> Marcel
> 

Ok, thanks.

Regards
-- 
Christoffer Holmstedt
