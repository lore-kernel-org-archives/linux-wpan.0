Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43338 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934814AbcKDOYO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Nov 2016 10:24:14 -0400
Subject: Re: [PATCH v3 0/3] ieee802154: Add support for Cascoda CA8210
References: <20161103155100.8400-1-h.morris@cascoda.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <5f7971af-26d2-86a3-6117-1484e0886758@pengutronix.de>
Date: Fri, 4 Nov 2016 15:24:09 +0100
MIME-Version: 1.0
In-Reply-To: <20161103155100.8400-1-h.morris@cascoda.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, stefan@osg.samsung.com, Harry Morris <h.morris@cascoda.com>


Hi,

On 11/03/2016 04:50 PM, harrymorris12@gmail.com wrote:
> From: Harry Morris <h.morris@cascoda.com>
> 
> This patchset adds a new device driver, documentation and build support for
> Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
> http://www.cascoda.com/products/ca-821x/
> 

I never get 1/3 on the linux-wpan mailinglist, I don't see them also on
[0]. Maybe there is something wrong at your mail configuration? I guess
the mail is simple too big. Don't know actually what's the size limit
is...

btw: I see the mail on my other mail account (gmail one, please use
aar@pengutronix.de) that you use the old "db" values - we switched to
mbm which is simple 3 dbm == 300 dbm.

This allows fine granularity dbm value -> 802.15.4 spec describes it as
signed integer, but e.g. at86rf230 also support 1.7 dbm stuff.

E.g.

ca8210_hw->phy->transmit_power = 8;

whould be:

ca8210_hw->phy->transmit_power = 800;

See [1]. Please also check on which seems that this is missing:

lp->hw->phy->supported.cca_ed_levels = at86rf23x_ed_levels;
lp->hw->phy->supported.cca_ed_levels_size = ARRAY_SIZE(at86rf23x_ed_levels);

the same for tx_powers and tx_powers_size if you support set_tx_power.
Also begin please with the highest db value at array index [0].

- Alex

[0] http://www.spinics.net/lists/linux-wpan/
[1] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L1609
