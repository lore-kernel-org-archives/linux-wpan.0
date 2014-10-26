Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:60569 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaJZIZj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:25:39 -0400
Received: by mail-la0-f53.google.com with SMTP id mc6so90904lab.12
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:25:37 -0700 (PDT)
Date: Sun, 26 Oct 2014 09:25:31 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 14/15] mac802154: tx: add comment at sync
 xmit callback
Message-ID: <20141026082529.GA18082@omega>
References: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
 <1414311352-908-15-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1414311352-908-15-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hi,

On Sun, Oct 26, 2014 at 09:15:51AM +0100, Alexander Aring wrote:
> This patch adds a warning that xmit_sync callback is deprecated and
> should be removed soon. The 802.15.4 subsystem will not accept synced
> drivers anymore.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  include/net/mac802154.h | 4 ++++
>  net/mac802154/tx.c      | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index 57b1202..942dd53 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -117,6 +117,10 @@ struct ieee802154_hw {
>   *	  synchronous 802.15.4 drivers.
>   *	  This function should return zero or negative errno.
>   *
> + *	  WARNING:
> + *	  This will be deprecated soon. We don't accept synced xmit callbacks
> + *	  drivers anymore.
> + *
>   * xmit_async:
>   *	  Handler that 802.15.4 module calls for each transmitted frame.
>   *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> index 74882c7..402701d 100644
> --- a/net/mac802154/tx.c
> +++ b/net/mac802154/tx.c
> @@ -30,6 +30,7 @@
>  
>  /* IEEE 802.15.4 transceivers can sleep during the xmit session, so process
>   * packets through the workqueue.
> + *

hmpf, didn't see the line insertion here. I will send a v2.

Doing much rebase stuff and at first it was at this position.

- Alex
