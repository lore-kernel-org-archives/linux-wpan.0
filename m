Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:32846 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964909AbbEMRgP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 May 2015 13:36:15 -0400
Received: by wgin8 with SMTP id n8so51150052wgi.0
        for <linux-wpan@vger.kernel.org>; Wed, 13 May 2015 10:36:14 -0700 (PDT)
Date: Wed, 13 May 2015 19:36:09 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: cc2520 issue
Message-ID: <20150513173605.GA820@omega>
References: <CAOoq=dTEMhzkjRYhkoz1H_F4FGg1eYGKis-LZR0p5LX-2-ZMYA@mail.gmail.com>
 <20150513164633.10c4d992@ws-entwicklun-18.phytec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150513164633.10c4d992@ws-entwicklun-18.phytec>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Johann Fischer <johann_fischer@posteo.de>
Cc: Karol Poczesny <kpoczesny@gmail.com>, linux-wpan@vger.kernel.org

On Wed, May 13, 2015 at 04:46:33PM +0200, Johann Fischer wrote:
> Hi Karol,
> 
> > Hello all,
> > 
> > I have tested simple ping communication between two devices:
> > 1.) Raspberry Pi with at86rf233 transceiver - (openlab module)
> > and
> > 2.) Raspberry Pi with CC2520 transceiver - my own radio board.
> > 
> > I am able to run the interface and start transmit frames for both
> > nodes, but only node with at86rf233 respond.
> > 
> > Node with CC2520 can send e.g ping message but cannot answer for ping
> > from at86rf233 node and ignore any other requests.
> > 
> 
> As I see, you used a reference Design with 2450BM15B0002 Balun?
> 
> I use also TI's reference design with the Balun and have the same
> problems. Original TI CC2520EM 2.1 Board functions fine.
> I use Kernel 3.19.0.
> 
> The problem appears only after immediately switching from tx to 
> rx mode. (e.g. ping6). Just send or receive is fine.
> 

this smells for me like a missing interframe spacing time. The 802.15.4
standard describes a minimum "waiting" time after reach transmit  ->
interframe spacing time.

I had the same issue in at86rf230 driver while 6LoWPAN fragmentation and
not in CSMA-CA/ARET mode.

The question is always "who do the interframe spacing time" if it's
not the transceiver which do simple a delayed tx completion irq (which
included the interframe spacing time), then this need to be handled by
the upper stack/driver layer.

If the datasheet nothing said about the interframe spacing time, then
it's bad. In my case I asked the atmel support and they told me that the
stack need to handle the interfame spacing time.

Anyway, the mac802154 contains a handling for this, but the driver
doesn't support xmit_async right now and an ugly workaround would be:

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 84b28a0..0d18ca4 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -503,6 +503,11 @@ cc2520_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
        cc2520_cmd_strobe(priv, CC2520_CMD_SFLUSHTX);
        cc2520_cmd_strobe(priv, CC2520_CMD_SRXON);
 
+       if (skb->len > 16)
+               usleep_range(640, 700);
+       else
+               usleep_range(192, 250);
+
        return rc;
 err:
        spin_lock_irqsave(&priv->lock, flags);

Maybe give it a try. If it's working "better" afterwards, then it looks like
the transceiver don't do an interframe spacing time.

Look how at86rf230 deals now with the inteframe spacing time (doesn't
required to do a sleep/delay). See [0], but this requires xmit_async
callback.

To set the symbol_duration in driver is currently a workaround, they are
well defined by 802.15.4 and should be set in upper calls when channel/page
is set. Anyway, this doesn't matter for this kind of transceiver which
always use a symbol_duration of 16 us.

- Alex

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/net/ieee802154/at86rf230.c?id=24ccb9f4f7a3a5a867bbc880019cdb4b41176b63
