Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F84CD5483
	for <linux-wpan@archiver.kernel.org>; Tue, 19 Sep 2023 07:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjISHcy (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjISHcw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Sep 2023 03:32:52 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81567114;
        Tue, 19 Sep 2023 00:32:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD8DB1BF20A;
        Tue, 19 Sep 2023 07:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695108765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8vxL7pYoQxk9FSR+fqgg0+sjwi0fCCi1XB+3HlChxV0=;
        b=JdVtLK+5cLlScXDozenIb4lPgdx148FNLNOG2Id4iyo8764/hRSHNTyWm9YCign9VGEF29
        +PIsNUj4O4I1goIg6De/Mp7IfEBlyB6OyZWv7EcK4n3tdeqKogUi7nEzQDWLm/1iVjAHEw
        dqS5cWOJO8mK7HegkfJzRSk5qwMcboWgk+gUnT6xa3FTN3ZrFlXmz/PbXbgAaB4WlxmVcd
        iN8e4ZJUUcWuyTcUPgKCPwaSm90zDqmVy/dApyJL7UB/eTEKMUTPcmHOisLbo7o5Xo0Hn/
        HCL0PBlMhj+lXCthHEpt+V0QwRydfS/0aKGHj3jyckjgJPMj+G2prERRcCKfHg==
Date:   Tue, 19 Sep 2023 09:32:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v3 11/11] ieee802154: Give the user the
 association list
Message-ID: <20230919093243.3e5f3429@xps-13>
In-Reply-To: <202309191044.4ABvPP5X-lkp@intel.com>
References: <20230918150809.275058-12-miquel.raynal@bootlin.com>
        <202309191044.4ABvPP5X-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

>    net/ieee802154/nl802154.c: In function 'nl802154_list_associations':
> >> net/ieee802154/nl802154.c:1778:15: error: implicit declaration of func=
tion 'nl802154_prepare_wpan_dev_dump' [-Werror=3Dimplicit-function-declarat=
ion] =20
>     1778 |         err =3D nl802154_prepare_wpan_dev_dump(skb, cb, &rdev,=
 &wpan_dev);
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> net/ieee802154/nl802154.c:1811:9: error: implicit declaration of funct=
ion 'nl802154_finish_wpan_dev_dump' [-Werror=3Dimplicit-function-declaratio=
n] =20
>     1811 |         nl802154_finish_wpan_dev_dump(rdev);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>=20
>=20
> vim +/nl802154_prepare_wpan_dev_dump +1778 net/ieee802154/nl802154.c
>=20
>   1769=09
>   1770	static int nl802154_list_associations(struct sk_buff *skb,
>   1771					      struct netlink_callback *cb)
>   1772	{
>   1773		struct cfg802154_registered_device *rdev;
>   1774		struct ieee802154_pan_device *child;
>   1775		struct wpan_dev *wpan_dev;
>   1776		int err;
>   1777=09
> > 1778		err =3D nl802154_prepare_wpan_dev_dump(skb, cb, &rdev, &wpan_dev)=
; =20

[...]

> > 1811		nl802154_finish_wpan_dev_dump(rdev); =20

These two are defined within #ifdef EXPERIMENTAL. I will move them out
as I need them as well inthe !EXPERIMENTAL case. Good that kernel test
robot eventually catch that.

Thanks,
Miqu=C3=A8l
