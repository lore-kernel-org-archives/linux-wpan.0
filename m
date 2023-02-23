Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A45C61DA4
	for <linux-wpan@archiver.kernel.org>; Thu, 23 Feb 2023 10:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjBWKfH (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBWKfG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Feb 2023 05:35:06 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F0C4988E
        for <linux-wpan@vger.kernel.org>; Thu, 23 Feb 2023 02:35:04 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B9E860007;
        Thu, 23 Feb 2023 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677148503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxvRbvrmU+vCqnSNTxPqupDLWG4ixWBsPNajvBuI2hg=;
        b=YJ19G0UnKhBZk9aS93y6jjrYIo5wxyB0i3Epqf4+dGgocFswPK47y1ImS+MXmcECJb+akB
        /uB17CrLcbbt9C4gvxpud/hU+wmhkJLLnVGH1toVjOkZlJXRLU164j66UnZu+wWnl4xOXK
        H/lnBTsTI/VMoEXgntfJ52FLGvNBEatbx1JM+T9D+WNRmVwmonDaMuk+VRLPNSTRwSYHKx
        ZlWqEg6mMSX2HCZNHznJ17NLXsTaUgvYSezW1pf44joQJchTjpYTg04vKf67ey+VhMTqp4
        RSMT3LNxYLIUoMNN81E6qwX9B8jzyvLy+sIZxJG1ZZN2wBjHHaYZRq8XD6ngew==
Date:   Thu, 23 Feb 2023 11:35:00 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Linux Wpan Mailing List <linux-wpan@vger.kernel.org>
Subject: Re: ieee802154: energy detection question
Message-ID: <20230223113500.662d1624@xps-13>
In-Reply-To: <CAK-6q+hUzbUi3quGW6_jvXyGm+cqv4aY6rnLOJ1B=QzOMUoH8A@mail.gmail.com>
References: <20230217100059.58e92818@xps-13>
        <CAK-6q+hUzbUi3quGW6_jvXyGm+cqv4aY6rnLOJ1B=QzOMUoH8A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Mon, 20 Feb 2023 21:58:04 -0500:

> Hi,
>=20
> On Fri, Feb 17, 2023 at 4:01 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hello,
> >
> > I know this may sound like a silly question but while looking at the
> > various drivers implementations I found no users (at all) of the ->ed()
> > energy detection hook. Its comment says that the mac layer is supposed
> > to use it but I couldn't find where. Of course, the fact that the
> > abbreviation ends like half of the word in english "-ed" does not help
> > grepping for that, but I could not figure out how useful this callback
> > was. In particular since it is mandatory to provide.
> > =20
>=20
> There is no user, there was never an upstream user.

Ah, thanks a lot for the confirmation.

> > I am pretty sure I missed something, so perhaps someone has a pointer
> > to help me there. =20
>=20
> I think there were some non-upstream users for code which never came
> upstream. Please don't look into this code.
>=20
> What do you want to do with this functionality? But the finger out and
> look for a suitable channel to switch and operate on?

Yeah, the idea of having a mac hook for that feels odd, but why not.
What is bothering me actually is the fact that this hook seems mandatory
(while mostly useless), see:
https://elixir.bootlin.com/linux/latest/source/net/mac802154/main.c#L53

I propose to remove that check regarding the ->ed() callback presence?

Thanks,
Miqu=C3=A8l
