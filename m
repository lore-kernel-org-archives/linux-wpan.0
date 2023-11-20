Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E365C197A0
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Nov 2023 11:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjKTLAh (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Nov 2023 06:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjKTLAg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Nov 2023 06:00:36 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51862A0;
        Mon, 20 Nov 2023 03:00:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC31A6000B;
        Mon, 20 Nov 2023 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700478031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ka429IEFLwPlIfXES4thmZ9kYRptQ+QGWcjMTefmfQ=;
        b=pJeCcT/Kj33W/cSFrayGIzN9WsUEY6c+hcwuEX5BDMaAY/CjaDXW2YKQKihOMg7RcPCUqC
        I9DAxDuCjFGesgO0sofpD3PLTTxMLVAOWXdIMMhRccJ9tgTxZAxCgLunrxN4JlrkumIvn6
        dalO678kGpqlTdjOFF+zp/gcPVGW3WF4UVRUGX2zoYde+BoiBL+2CiByv/y5yS5cAtkwFk
        o6Bet2q3UK15YoibiTR5grtu2pVLtipPYkSPc+3Hm5gUmPQNS2WytX2QjHfJwfOyqBcaNZ
        6dbxRT7QjP1dhM1njkEVjd21ouD+mUv8sbiI+5uwA1XyDpYzcjlroobqCz45aQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v5 09/11] mac802154: Follow the number of associated devices
Date:   Mon, 20 Nov 2023 12:00:29 +0100
Message-Id: <20231120110029.3808019-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-10-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'80f8bf9a2a7f603662e08f7663643a58087a2cd4'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2023-09-27 at 18:12:12 UTC, Miquel Raynal wrote:
> Track the count of associated devices. Limit the number of associations
> using the value provided by the user if any. If we reach the maximum
> number of associations, we tell the device we are at capacity. If the
> user do not want to accept any more associations, it may specify the
> value 0 to the maximum number of associations, which will lead to an
> access denied error status returned to the peers trying to associate.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel
