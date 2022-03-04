Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0014C433F5
	for <linux-wpan@archiver.kernel.org>; Fri,  4 Mar 2022 08:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiCDIFf (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 4 Mar 2022 03:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiCDIFY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Mar 2022 03:05:24 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACE113D570;
        Fri,  4 Mar 2022 00:04:14 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 66267240002;
        Fri,  4 Mar 2022 08:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646381053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBRYVCP7yb0gESHF2jAS7A5JYcBrX+6Xm1nRRGqyulo=;
        b=IuMHWJbKqTcLVSwYatuRArzPaeMdOfHc6GjT792MfLfHZ0ID4Fi6HMJRg24qSNC/QeVdKQ
        T8xtywzHEUeOoimkfVnM1K02nGNYqrjhVnwa3uuR/KQnB/fwb7L0cU3oxwufS1tY4I/Mt8
        QxwSmwWKVC48Z9ioP/HC6XYuIuJ/YGZTMbi7J3/nKTqrfS6fLhWwZSqJiYwODis1//o6lk
        2PzAskwrZW/qkn1iUIAdoDNHIRZQNXjs9PJSRsrte8srzmNKwNmnZ/JSeaNfUhKTrr+65t
        +4IIWXm6EKKBeJI+bNZCweFcy7nWrE4AyrAba1zS4VKXoMId/37iSqu4KZ3M6w==
Date:   Fri, 4 Mar 2022 09:04:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v3 03/11] net: mac802154: Create a transmit
 error helper
Message-ID: <20220304090409.0315820f@xps13>
In-Reply-To: <20220303203025.17df135e@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
References: <20220303182508.288136-1-miquel.raynal@bootlin.com>
        <20220303182508.288136-4-miquel.raynal@bootlin.com>
        <20220303203025.17df135e@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Jakub,

kuba@kernel.org wrote on Thu, 3 Mar 2022 20:30:25 -0800:

> On Thu,  3 Mar 2022 19:25:00 +0100 Miquel Raynal wrote:
> > So far there is only a helper for successful transmission, which led
> > device drivers to implement their own handling in case of
> > error. Unfortunately, we really need all the drivers to give the hand
> > back to the core once they are done in order to be able to build a
> > proper synchronous API. So let's create a _xmit_error() helper and take
> > this opportunity to fill the new device-global field storing Tx
> > statuses.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> I'm sure kbuild bot will tell you as well but there's a transient build
> failure here which will break bisection:
>=20
> net/mac802154/util.c: In function =E2=80=98ieee802154_xmit_error=E2=80=99:
> net/mac802154/util.c:96:14: error: =E2=80=98struct ieee802154_local=E2=80=
=99 has no member named =E2=80=98tx_result=E2=80=99
>    96 |         local->tx_result =3D reason;
>       |              ^~

Mmmh, crap, it's just that I forgot to swap patch 03 and patch 04
(adding the field before using it...). I will wait for more feedback
and then send a v4 that fixes that. In the mean time, you can
definitely swap patches manually for build coverage purposes, if
needed.

Thanks,
Miqu=C3=A8l
