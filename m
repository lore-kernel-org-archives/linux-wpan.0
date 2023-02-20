Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB254C05027
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Feb 2023 08:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBTI7z (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Feb 2023 03:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjBTI7y (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Feb 2023 03:59:54 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6699714483;
        Mon, 20 Feb 2023 00:59:48 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A31BA6000E;
        Mon, 20 Feb 2023 08:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676883587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbKACJUx3qdyBcA1MKYjHgQRv8jx40Gz4iFN+i2oZBI=;
        b=ZTeqcjr2XUhPB/cSrLTQlntMYWVGZ7PAMeSuqg3AXcrdjCtt0TU4prCuOGfozB7ZZbjBaN
        nHb0linciD66P1KoQxCa+ZEMPspPdGmzFfUhcX0iZOLFV/Rxt5g+/d/6ZKaoFHJoVxHiDO
        02Y/NAfE64Z+1R+Z50x1xOWeD6dC9aiNHQTRGncyqBRavYrpecMyXqqGhKyCSghoc4QZ7N
        bbDeJwJF7mPdOTkdXqppWqEXEkD7S4NHL3lYIaM2BdgmQVogUSrFKmDJ91ibgtWazDdLNn
        VPhZrVy8TEOHKBVckeDSY4FkbGhyBLm83zgn7UxJgrYvYkAFAOJ8IWYWE4EwcA==
Date:   Mon, 20 Feb 2023 09:59:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-wpan@vger.kernel.org,
        alex.aring@gmail.com, linux-kernel@vger.kernel.org,
        alan@signal11.us, liuxuenetmail@gmail.com, varkabhadram@gmail.com
Subject: Re: [PATCH net 4/4] MAINTAINERS: Add Miquel Raynal as additional
 maintainer for ieee802154
Message-ID: <20230220095944.6be3ceec@xps-13>
In-Reply-To: <20230218211317.284889-4-stefan@datenfreihafen.org>
References: <20230218211317.284889-1-stefan@datenfreihafen.org>
        <20230218211317.284889-4-stefan@datenfreihafen.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,

stefan@datenfreihafen.org wrote on Sat, 18 Feb 2023 22:13:17 +0100:

> We are growing the maintainer team for ieee802154 to spread the load for
> review and general maintenance. Miquel has been driving the subsystem
> forward over the last year and we would like to welcome him as a
> maintainer.

Thanks a lot!

Not sure this is needed but just in case:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Cheers!
Miqu=C3=A8l
