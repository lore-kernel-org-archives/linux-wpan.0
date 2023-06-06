Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98BC77B73
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Jun 2023 09:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjFFJsA (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Jun 2023 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbjFFJr6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Jun 2023 05:47:58 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E610E7;
        Tue,  6 Jun 2023 02:47:48 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686044866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApW14yUphjoVxJ8OfyJdmz2zYwhytsITbf5DWcM7pbA=;
        b=dg+sYQGnLW0QH4rB/42gLxiZpgIs4N4MWvuVIdXz5PKjRuujNIMthpmHOKMJKu9Utmjou6
        Md0BouvLY6nH6sPN4Mg77MHfCkpjKLozxV2XfUCDJPRRTZVIpF5TtXoimeOG8d50bTi5uL
        bDvoCdz2E55HOi5d1fjbXXS4Ty7iOOMK8vgf/ripk51upIbWRXGVA/P2irt7h4mw1DGYHe
        qV7js6mvf9pzNfsVQaie4v8vuWFiRo80orhoUiOLw0uKslu4UcvFGS4eLxV1zxEdc/fwim
        +XmP8wZpcXTpfn8uLzennrhF31RV+YxKsKOVhK/s3JkOasCoFVvDhnu1jCtu8Q==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 787262000D;
        Tue,  6 Jun 2023 09:47:44 +0000 (UTC)
Date:   Tue, 6 Jun 2023 11:47:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next v1 1/1] ieee802154: ca8210: Remove stray
 gpiod_unexport() call
Message-ID: <20230606114743.30f7567e@xps-13>
In-Reply-To: <CAK-6q+hkL8cStdSPnZF_D1CtLvJZ=P16TJ8BCGpkGwrbh8uN3A@mail.gmail.com>
References: <20230528140938.34034-1-andriy.shevchenko@linux.intel.com>
        <ZHWo3LHLunOkXaqW@corigine.com>
        <ZH3srm+8PnZ1rJm9@smile.fi.intel.com>
        <CAK-6q+hkL8cStdSPnZF_D1CtLvJZ=P16TJ8BCGpkGwrbh8uN3A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org


aahringo@redhat.com wrote on Tue, 6 Jun 2023 05:33:47 -0400:

> Hi,
>=20
> On Mon, Jun 5, 2023 at 10:12=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, May 30, 2023 at 09:42:20AM +0200, Simon Horman wrote: =20
> > > On Sun, May 28, 2023 at 05:09:38PM +0300, Andy Shevchenko wrote: =20
> > > > There is no gpiod_export() and gpiod_unexport() looks pretty much s=
tray.
> > > > The gpiod_export() and gpiod_unexport() shouldn't be used in the co=
de,
> > > > GPIO sysfs is deprecated. That said, simply drop the stray call.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> =
=20
> > >
> > > Reviewed-by: Simon Horman <simon.horman@corigine.com> =20
> >
> > Thank you!
> > Can this be applied now? =20
>=20
> ping, Miquel? :)

I already applied it locally, but I am trying to fix my "thanks for
patch" routine to not tell you it was applied on the mtd tree :-p

Cheers,
Miqu=C3=A8l
