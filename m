Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37973 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRNvh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 18 Dec 2018 08:51:37 -0500
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw> <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
In-Reply-To: <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Tue, 18 Dec 2018 14:50:58 +0100
Message-ID: <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>, "David S . Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-lpwan@lists.infradead.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello Andreas,

On Mon, 17 Dec 2018 at 15:19, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>
> Hello Xue Liu,
>
> Am 17.12.18 um 09:50 schrieb Xue Liu:
> > I have a question about the architecture of your module. AFAIK LoRaWAN
> > is already the MAC Layer above the LoRa technology. Why do you want to
> > make a new layer called "maclorawan" ?
>
> I had asked Jian-Hong to separate between his soft-MAC implementation
> and the common bits needed to drive hard-MAC implementations found on
> several of the hardware modules made available to me.
>
As a reference Linux 802.11 uses cfg80211 to talk with hard-MAC devices.
We may also use the name =E2=80=9Ccfglora=E2=80=9D for hard-MAC implementat=
ion.

> The prefix "mac" was copied from mac80211 and mac802154:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/n=
et
>
OK. Understood. I guess they use mac80211 and mac802154 to distinguish
physical layer and MAC layer. Since LoRa and LoRaWAN are already
separate I think
"maclorawan" is not necessary.

> If you have better ideas for how to structure this, just let us know,
> ideally as inline comment where you see it (or on the cover letter).
>
> Only comment I have for this patch at the moment is that I would prefer
> to have the Kconfig bits be in the patches adding the code, so that we
> can actually build-test them before 6/6.
>
> Been updating my lab to 4.20-rcX with some hiccups. Ben's
> regmap_noinc_write support made it into 4.20, so I expect to have Ben's
> pending branch for sx1301 merged into rebased lora-next before Christmas
> and my sx1276 conversion to follow, leaving the PF_PACKET vs. PF_LORA
> discussion from ELCE - haven't assessed yet how much this series would
> be affected by the underlying changes, but if the abstraction was done
> right then only maclorawan implementation should be affected.
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
Regards,

Xue Liu


--
