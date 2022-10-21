Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D4C4332F
	for <linux-wpan@archiver.kernel.org>; Fri, 21 Oct 2022 13:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJUNd5 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJUNd4 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Oct 2022 09:33:56 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F3E272121
        for <linux-wpan@vger.kernel.org>; Fri, 21 Oct 2022 06:33:53 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0A718240005;
        Fri, 21 Oct 2022 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666359232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeR3qf2+XHUDgnxZ+dFz7I68XzKCUwp87/Q1HEvd2/c=;
        b=hfwycbj186I9zVdqnhjVgPTx5RlAWYvhMevwualxXhq7o02BMpnxfskffDCCiI3zgc+ML2
        X/005bpSAJ7KfN4fzqfU3A5NgZxZrDgPisDQHKYZfK9XP/Kf/NmNpY14g6LCGo6nos8QlW
        0li5H49cVc7eUNKpugzWLVN2GnVdaCwps6fuHT/UZyvVkm27GVfkEpqp3TdA0W9zKVcYRE
        VpKmR/jS9H6BeQQEcU0DLCHFKqr1NmhwerWD2s7nfdCNtzBCM8jPEqtfs2LDLFJYuqGYw2
        2C1egI+QqSwF1iSDW49qJH6dErkzgp8JXPSYZ2j4AsmbVxHLxfQeA898O3yebw==
Date:   Fri, 21 Oct 2022 15:33:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, werner@almesberger.net,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org
Subject: Re: [PATCH atusb/fw v2 2/3] atusb: fw: Update toolchain
 instructions
Message-ID: <20221021153351.1d30f620@xps-13>
In-Reply-To: <CAK-6q+g6mDWh2xNmMUviqiiDwBs1q835TrOU9wZ-CF7=rOA+Tw@mail.gmail.com>
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
        <20220906082104.1338694-2-miquel.raynal@bootlin.com>
        <44a98eb6-e8bb-3065-4c6d-9ffb801182ae@datenfreihafen.org>
        <20221014081808.1b30bba7@xps-13>
        <CAK-6q+jbAmTYfF8OTZNZ-KdUNWAfU2RRJE7p8N6nMyHB0xwGMg@mail.gmail.com>
        <20221019214625.22101769@xps-13>
        <20221020161713.6004b0cf@xps-13>
        <CAK-6q+iffiLx0U3W0Gaw=xtDn3ipRb5v5BPKEazxfpe343h5iA@mail.gmail.com>
        <20221021085353.2ad567d4@xps-13>
        <CAK-6q+g6mDWh2xNmMUviqiiDwBs1q835TrOU9wZ-CF7=rOA+Tw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Fri, 21 Oct 2022 08:13:52 -0400:

> Hi,
>=20
> On Fri, Oct 21, 2022 at 2:53 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> ...
> > I read a little bit more about LQI during this test phase and indeed,
> > "weak" seems appropriate :-)
> > =20
>=20
> * "weak" defined.
>=20
> > > I heard successful reports also using aluminium foil around transceiv=
ers... =20
> >
> > Indeed I've heard it could work, I'll keep it in mind!
> > =20
>=20
> be careful with shortcutting something there, for atusb I recommend [0].
>=20
> - Alex
>=20
> [0] https://www.thingiverse.com/thing:2815832

Excellent!

Thanks,
Miqu=C3=A8l
