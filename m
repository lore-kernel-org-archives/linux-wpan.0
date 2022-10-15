Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB2AC4332F
	for <linux-wpan@archiver.kernel.org>; Sat, 15 Oct 2022 09:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJOJAG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 15 Oct 2022 05:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJOJAD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Oct 2022 05:00:03 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990A22BD8;
        Sat, 15 Oct 2022 01:59:52 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8F023E0008;
        Sat, 15 Oct 2022 08:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665824389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoiZf9QZHZSJ0QCNo7B50G/2t/lCGuPOfhSXJAYvpmU=;
        b=oJovXMUkeX2avijYqwsuRp8b4y4As/CH2E/Q7JKNAF5jSCXQ8UNHiVvKzntDN7joL4sody
        sQdOmq9LM9RLl8L2aYTpIcO44x73AdXNuF8doO0fysmawRFYF4wyiuJdVHJL5rYCg/RA/V
        GBXaMoXswF8YqXBflQ5/017FbZJk08D52fEsp+enN67rP5TFdZqepwEnqQk8HcYBmJWxmu
        9BNFNPydE61AHPwtR0FVP67mpJ9T5SO1Y3i1oUgI4mGZZRWU7lGiZi9aagawqQxcwvZZGz
        U1JNoJyJjrXyHYaqSA+g0fEvh1z1i7Eg2YHAKf43cEim1wWUBkZxu4GSRAhFlw==
Date:   Sat, 15 Oct 2022 10:59:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan/next v4 5/8] ieee802154: hwsim: Implement address
 filtering
Message-ID: <20221012161937.1b683d82@xps-13>
In-Reply-To: <8be89e06-5b26-6391-0427-b4e5b6ab66ab@datenfreihafen.org>
References: <20221007085310.503366-1-miquel.raynal@bootlin.com>
 <20221007085310.503366-6-miquel.raynal@bootlin.com>
 <8be89e06-5b26-6391-0427-b4e5b6ab66ab@datenfreihafen.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,

stefan@datenfreihafen.org wrote on Wed, 12 Oct 2022 12:48:06 +0200:

> Hello Miquel.
>=20
> This patch has given me some checkpatch wawrnings and errors.
>=20
> Commit d9abecc4a0fc ("ieee802154: hwsim: Implement address filtering")
> ----------------------------------------------------------------------
> CHECK: Blank lines aren't necessary after an open brace '{'
> #53: FILE: drivers/net/ieee802154/mac802154_hwsim.c:162:
> +	if (hw->phy->filtering =3D=3D IEEE802154_FILTERING_4_FRAME_FIELDS) {
> +
>=20
> ERROR: code indent should use tabs where possible
> #128: FILE: drivers/net/ieee802154/mac802154_hwsim.c:237:
> +        }$
>=20
> WARNING: please, no spaces at the start of a line
> #128: FILE: drivers/net/ieee802154/mac802154_hwsim.c:237:
> +        }$
>=20
> total: 1 errors, 1 warnings, 1 checks, 143 lines checked
>=20
> I fixed this up in palce for you tp proceed with applying this patches. J=
ust so you are aware.

I'm sorry for these, I focused on getting the feature more than on the
presentation and I forgot to re-run checkpatch after all the copy-paste
handling towards hwsim. Next time I'll fix it myself, don't hesitate to
tell me when this happens ;-)

Thanks,
Miqu=C3=A8l
