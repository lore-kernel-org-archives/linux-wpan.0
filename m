Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32823 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbbFJJX4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 05:23:56 -0400
Received: by wiwd19 with SMTP id d19so41921167wiw.0
        for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 02:23:55 -0700 (PDT)
Date: Wed, 10 Jun 2015 11:23:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] nl802154: fix misspelled enum
Message-ID: <20150610092351.GC947@omega>
References: <1433927039-21975-1-git-send-email-christoffer@christofferholmstedt.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433927039-21975-1-git-send-email-christoffer@christofferholmstedt.se>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: christoffer@christofferholmstedt.se
Cc: linux-wpan@vger.kernel.org

On Wed, Jun 10, 2015 at 11:03:59AM +0200, christoffer@christofferholmstedt.se wrote:
> From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> 
> Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
> ---
>  include/net/nl802154.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> index 6fc231e60920..b796561188d6 100644
> --- a/include/net/nl802154.h
> +++ b/include/net/nl802154.h
> @@ -199,7 +199,7 @@ enum nl802154_cca_modes {
>  	NL802154_CCA_ENERGY_CARRIER,
>  	NL802154_CCA_ALOHA,
>  	NL802154_CCA_UWB_SHR,
> -	NL802154_CCA_UWB_MULTIPEXED,
> +	NL802154_CCA_UWB_MULTIPLEXED,
>  

What's about to fixing the comment as well? 0:-)

- Alex
