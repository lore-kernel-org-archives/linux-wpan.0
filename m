Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E782C197A0
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Nov 2023 11:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjKTLA7 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Nov 2023 06:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKTLA7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Nov 2023 06:00:59 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A84CA;
        Mon, 20 Nov 2023 03:00:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03ADE1BF20F;
        Mon, 20 Nov 2023 11:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700478053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/rElJpyeEE7sYCnBh0dkb67KhQptIAe00a1V96Mndg=;
        b=HNFoP/I76MeUlEMmKcQ0MDV3+FpYEhjkIgoE6RMZd98Tq+6aZv1IvQti/SY0618uedoTXG
        higkq6pfb0loxcxYaLMb44q0yQMFdXt8D42+/j8Xaov/OSlh6gi5BgsKZ66mvDizGqs6Tq
        zqbGCg0mulhiNM92WVZIY1HE1wXlQiVhXRtQPtzLYjlx2AKNVcJ74QNELbzcXLr4Na+sCu
        IVF1iPNzMM31TqRFMbtOa1LR30yV8g6wPAHxCTseUWsl483o1oB/+hUKpSACd2qV7pNQ/v
        61tzur07jSAxB2CpIqEvFLLGaJC/+gHjRJRmJXUSAe3dP7pe3tC8Os598F2syw==
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
Subject: Re: [PATCH wpan-next v5 03/11] ieee802154: Add support for user association requests
Date:   Mon, 20 Nov 2023 12:00:52 +0100
Message-Id: <20231120110052.3808220-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-4-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'05db59a0619969a47ab87050985344177c662cab'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2023-09-27 at 18:12:06 UTC, Miquel Raynal wrote:
> Users may decide to associate with a peer, which becomes our parent
> coordinator. Let's add the necessary netlink support for this.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel
