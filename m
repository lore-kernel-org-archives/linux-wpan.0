Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726660AbeLQOTY (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 17 Dec 2018 09:19:24 -0500
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
Date: Mon, 17 Dec 2018 15:19:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello Xue Liu,

Am 17.12.18 um 09:50 schrieb Xue Liu:
> I have a question about the architecture of your module. AFAIK LoRaWAN
> is already the MAC Layer above the LoRa technology. Why do you want to
> make a new layer called "maclorawan" ?

I had asked Jian-Hong to separate between his soft-MAC implementation
and the common bits needed to drive hard-MAC implementations found on
several of the hardware modules made available to me.

The prefix "mac" was copied from mac80211 and mac802154:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net

If you have better ideas for how to structure this, just let us know,
ideally as inline comment where you see it (or on the cover letter).

Only comment I have for this patch at the moment is that I would prefer
to have the Kconfig bits be in the patches adding the code, so that we
can actually build-test them before 6/6.

Been updating my lab to 4.20-rcX with some hiccups. Ben's
regmap_noinc_write support made it into 4.20, so I expect to have Ben's
pending branch for sx1301 merged into rebased lora-next before Christmas
and my sx1276 conversion to follow, leaving the PF_PACKET vs. PF_LORA
discussion from ELCE - haven't assessed yet how much this series would
be affected by the underlying changes, but if the abstraction was done
right then only maclorawan implementation should be affected.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
