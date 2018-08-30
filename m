Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:56536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeH3Lzk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Aug 2018 07:55:40 -0400
Date: Thu, 30 Aug 2018 10:54:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ieee802154: mcr20a: read out of bounds in
 mcr20a_set_channel()
Message-ID: <20180830075421.czsb5pa5b2vygp2m@mwanda>
References: <20180829144923.6p2omsbe2s343wea@kili.mountain>
 <CAJuUDwtjRi0HnR95uaFp4zviSC7Yrs68o8jsK1nY6jWu6909bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuUDwtjRi0HnR95uaFp4zviSC7Yrs68o8jsK1nY6jWu6909bg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: "alex. aring" <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Aug 29, 2018 at 07:50:51PM +0200, Xue Liu wrote:
> Hello Dan,
> 
> 
> On Wed, 29 Aug 2018 at 16:49, Dan Carpenter <dan.carpenter@oracle.com>
> wrote:
> 
> > The "channel" variable can be any u8 value.  We need to make sure we
> > don't read outside of the PLL_INT[] or PLL_FRAC[] arrays.
> >
> I think the “channel” variable can not be any u8 value. This values is
> already checked before set_channel function is called.
> https://github.com/torvalds/linux/blob/master/net/ieee802154/nl802154.c#L978

Oh...  Hm...  I should have reviewed more carefully.  This patch isn't
correct.  But there may still be a bug.  What Smatch is worried about is
the other call tree:

ieee802154_start_req() calls (struct ieee802154_mlme_ops)->start_req
  -> mac802154_mlme_start_req()
     -> mac802154_dev_set_page_channel()
        -> drv_set_channel() calls local->ops->set_channel(&local->hw, page, channel);
           -> mcr20a_set_channel()

So maybe we could move the check from nl802154_set_channel() to
drv_set_channel() so channel is checked on both call trees.

regards,
dan carpenter
