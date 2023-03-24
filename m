Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2515BC6FD20
	for <linux-wpan@archiver.kernel.org>; Fri, 24 Mar 2023 09:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCXJ5r (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 24 Mar 2023 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjCXJ5q (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Mar 2023 05:57:46 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D059812853
        for <linux-wpan@vger.kernel.org>; Fri, 24 Mar 2023 02:57:44 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B6D8624000F;
        Fri, 24 Mar 2023 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679651862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eD0y9Q6jAF6Kv/oUM9t9O8CzrUw0ZAP7zVFYdnRwNfk=;
        b=d+ASyUCshVembRi5scX8Q6a66U4QdQLFrn3G+hilamRc+sL6E52ZtfFYIrZtkvSc6mjKrm
        kbO+9oCjPV1824H5S6nUV4Owb8c7FWcXtT/NpOjF9da2jFUwyG+rflNxub7WYsd4kdWumS
        Te0Js8vnd9mxmj7UumkBQdaE+fEpbFmovX3kwg0uLB8sVIzq1jdrF0wTlcBL32lZMjymB+
        X08AIBEkhMlwwXO6FomwgN+2LBq8WKcgOOL/pk5X7GLWFqYJFExFfKyG0leUNzd8hDJqJi
        OuDUTldbULSZsbsxjzSWoO5klu6r/IdzWa+pQXozioU3rplKjmXkZPr7ftD/Lg==
Date:   Fri, 24 Mar 2023 10:57:37 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v2 0/4] ieee802154: Active scan support
Message-ID: <20230324105737.0fb0f39f@xps-13>
In-Reply-To: <CAK-6q+iw6V5qDCux0E4xE3wMuCc1u8tc26kzwQFyHbMcyFr4iQ@mail.gmail.com>
References: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
        <CAK-6q+iw6V5qDCux0E4xE3wMuCc1u8tc26kzwQFyHbMcyFr4iQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

aahringo@redhat.com wrote on Thu, 23 Mar 2023 08:58:43 -0400:

> Hi,
>=20
> On Fri, Mar 10, 2023 at 10:12=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hello,
> > Following the initial support for passive scan and beaconing, here is an
> > addition to support active scans.
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> Acked-by: Alexander Aring <aahringo@redhat.com>
>=20
> but I need to admit those are more scan mechanism related work and I
> trust Miquel he does the right thing, because he is actually more into
> this topic as me and worked previously on it.
> For me, I do not see anything that will break something e.g.
> overwriting framebuffer/dealing with frame filter levels and I am
> pretty sure Miquel already knows to take care of it.

I agree with the fact that the risk is rather low on this one. Now
coming:
- Handling of limited devices (ca8210)
- Associations/dis-associations (+ additional care to avoid confusing
  the devices)

>=20
> Even if there would later be a problem regarding that, we can
> hopefully work things out.

Of course.

>=20
> Thanks.
>=20
> Sorry for the late reply.
>=20
> - Alex
>=20


Thanks!
Miqu=C3=A8l
