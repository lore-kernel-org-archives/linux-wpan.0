Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33743 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbH1Hxc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 28 Aug 2015 03:53:32 -0400
Received: by wieo17 with SMTP id o17so6268448wie.0
        for <linux-wpan@vger.kernel.org>; Fri, 28 Aug 2015 00:53:31 -0700 (PDT)
Date: Fri, 28 Aug 2015 09:53:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 16/21] mrf24j40: add csma params support
Message-ID: <20150828075328.GB6297@omega>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-17-git-send-email-alex.aring@gmail.com>
 <55DF14D3.2030700@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55DF14D3.2030700@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

On Thu, Aug 27, 2015 at 03:46:59PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 13/08/15 14:22, Alexander Aring wrote:
> >This patch adds supports to change the CSMA parameters. The datasheet
> >doesn't say anything about max_be value. Seems not configurable and we
> >assume the 802.15.4 default. But this value must exists because there is
> >a min_be value.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  drivers/net/ieee802154/mrf24j40.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> >index e992bff..fdb0b84 100644
> >--- a/drivers/net/ieee802154/mrf24j40.c
> >+++ b/drivers/net/ieee802154/mrf24j40.c
> >@@ -769,6 +769,26 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
> >  	return spi_async(devrec->spi, &devrec->rx_msg);
> >  }
> >+static int
> >+mrf24j40_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be,
> >+		     u8 retries)
> >+{
> >+	struct mrf24j40 *devrec = hw->priv;
> >+	u8 val;
> >+
> >+	/* datasheet doesn't say anything about max_be, but we have min_be
> >+	 * So we assume the max_be default.
> >+	 */
> >+	WARN_ON(max_be != 5);
> Hmm, the WARN_ON here should never trigger as long as no change is made to
> the driver, right? You advertise min_maxbe and max_maxbe both to 5 below and
> this is the only value that could come from userspace. Maybe remove the
> WARN_ON here and move the comment below?
> 

ok. I will remove it, it should never happen yes. Of course also move
the comment to the range limits.

- Alex
