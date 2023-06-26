Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE68EEB64DA
	for <linux-wpan@archiver.kernel.org>; Mon, 26 Jun 2023 10:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjFZKkG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 26 Jun 2023 06:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjFZKkE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 26 Jun 2023 06:40:04 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F9E6E;
        Mon, 26 Jun 2023 03:40:03 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687776001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jauNiTUVecaU7uoq65G3YgC4ySxzMEbBq59VXsu48VA=;
        b=lcCBn1mLmnLYOzbu+vaPLnje+7jSBQ2CFMqETX5GIUgDcGZKS0KTtE8YCvPm06D2LAt+gP
        qy7uRZ+yO2UsbKKPB3mGNYXayhOuFRV4BKKWw0r3ZUdGHHuYm+ODQAPp+UW2l/vhEi2HcH
        sLjvp+TrgiJDtFkvcS8Iv7fSjLEcsJQZ1xCPt1JMLZHo+/wXU+ONA6jsUpFkXzfkbE3mJE
        iw/0CDdztIYBZ7B9nrxIvnc5/WnXn3pw5uYIFxAxRegcvLcCkel5XVrJyZ9fz8ewrQ2Xn6
        qbXXp9kzMHJrijMS1kmjcHRoxqnpoRq7z4XxRA6J5hKakAYuzQGMC0L18bL6jQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 294366000C;
        Mon, 26 Jun 2023 10:40:00 +0000 (UTC)
Date:   Mon, 26 Jun 2023 12:39:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, pabeni@redhat.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, netdev@vger.kernel.org,
        linux-wpan@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net-next 2023-06-23
Message-ID: <20230626123957.2f9bb4c9@xps-13>
In-Reply-To: <20230624155947.1b94903e@kernel.org>
References: <20230623195506.40b87b5f@xps-13>
        <20230624155947.1b94903e@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Jakub,

kuba@kernel.org wrote on Sat, 24 Jun 2023 15:59:47 -0700:

> On Fri, 23 Jun 2023 19:55:06 +0200 Miquel Raynal wrote:
> > As you know, we are trying to build a wpan maintainers group so here is
> > my first ieee802154 pull-request for your *net-next* tree. =20
>=20
> Pulled thanks!
>=20
> In the future, please try to avoid merging in tags from Linus's tree
> directly. You can send a PR to net-next and fast forward, that results
> in a more straightforward shape of the history, and avoids getting=20
> the back-merging wrong (Linus said a couple of times that any cross-
> -merge must have an explanation in the commit message, for example).

I agree merging upstream tags darkens the history. So IIUC, it's fine
to have an -rc tag higher than -rc1 as base, but you prefer to receive
one merge request per "base tag". Duly noted.

Thanks!
Miqu=C3=A8l
