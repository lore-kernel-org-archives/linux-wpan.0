Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B50C433EF
	for <linux-wpan@archiver.kernel.org>; Mon, 13 Jun 2022 18:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244567AbiFMSQ2 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbiFMSQQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jun 2022 14:16:16 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3767F1582B;
        Mon, 13 Jun 2022 07:15:00 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EE847E0018;
        Mon, 13 Jun 2022 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655129699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rS0N+uNW3y/f76cBoiGLwTl9Tj8SWBiLSeaXvEmxa8=;
        b=e96QscZicV5VhXOlXXHjYoNbbcaUT7T79HKpk9I/8n3peSDQbAwipVhVZs2kG+W3NgeCJZ
        tOUR1KLBq9HFmeOnlPkRa1ERKA1Z5mxaHrjuQtYxjetVee7faj1v3mWRCcobDe35+eb2Xu
        3z2n+LJww0zNskiY4B0QPD2Av96xNz7gibZ3F9T3/i/NzhV/7louh7pD+5b5uVp4AvyVMX
        2Ag0D53NaThASMwBpqzZAN4XccVagWNQHJiupqFNvzs5XtuHXNrPFDAz2l3Pi9pvFDA0w3
        ERp0E1zgX9JwhrHgMa1QuOi4om5O5U5zKikue0HsAbbNhYJq6YrWO7tZlphBsA==
Date:   Mon, 13 Jun 2022 16:14:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     stefan@datenfreihafen.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCHv2 wpan-next 0/2] mac802154: atomic_dec_and_test() fixes
Message-ID: <20220613161457.0a05cda0@xps-13>
In-Reply-To: <20220613043735.1039895-1-aahringo@redhat.com>
References: <20220613043735.1039895-1-aahringo@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alex,

aahringo@redhat.com wrote on Mon, 13 Jun 2022 00:37:33 -0400:

> Hi,
>=20
> I was wondering why nothing worked anymore. I found it...
>=20
> changes since v2:
>=20
>  - fix fixes tags in mac802154: util: fix release queue handling
>  - add patch mac802154: fix atomic_dec_and_test checks got somehow
>    confused 2 patch same issue

I've got initially confused with your patchset but yes indeed the API
works the opposite way compared to my gut understanding.

We bought hardware and I am currently setting up a real network to
hopefully track these regressions myself in the future.

For these two patches:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Alexander Aring (2):
>   mac802154: util: fix release queue handling
>   mac802154: fix atomic_dec_and_test checks
>=20
>  net/mac802154/tx.c   | 4 ++--
>  net/mac802154/util.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20


Thanks,
Miqu=C3=A8l
