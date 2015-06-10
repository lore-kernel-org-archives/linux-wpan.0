Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:45272 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933403AbbFJJMv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 05:12:51 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] nl802154: fix misspelled enum
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433927039-21975-1-git-send-email-christoffer@christofferholmstedt.se>
Date: Wed, 10 Jun 2015 11:12:48 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <ED2DD65D-D01C-4A4D-8BE6-23E997E686FE@holtmann.org>
References: <1433927039-21975-1-git-send-email-christoffer@christofferholmstedt.se>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: christoffer@christofferholmstedt.se
Cc: linux-wpan@vger.kernel.org

Hi Christoffer,

> Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> ---
> include/net/nl802154.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> index 6fc231e60920..b796561188d6 100644
> --- a/include/net/nl802154.h
> +++ b/include/net/nl802154.h
> @@ -199,7 +199,7 @@ enum nl802154_cca_modes {
> 	NL802154_CCA_ENERGY_CARRIER,
> 	NL802154_CCA_ALOHA,
> 	NL802154_CCA_UWB_SHR,
> -	NL802154_CCA_UWB_MULTIPEXED,
> +	NL802154_CCA_UWB_MULTIPLEXED,
> 
> 	/* keep last */
> 	__NL802154_CCA_ATTR_AFTER_LAST,

I went ahead and applied this to bluetooth-tree. In case we actually have a user with the wrong name, we need to add a backwards compatible define to allow the wrong name. However for now, lets see if this has been used at all.

Regards

Marcel

