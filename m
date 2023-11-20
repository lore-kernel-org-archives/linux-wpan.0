Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3C9C54E76
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Nov 2023 11:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjKTLBD (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Nov 2023 06:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKTLBD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Nov 2023 06:01:03 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE79D;
        Mon, 20 Nov 2023 03:00:59 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 901DB40006;
        Mon, 20 Nov 2023 11:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700478058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4SutgbzTFJbed6CnmBYu/sgR3lWoSNtaZmvPWneWGg=;
        b=f2KQqgrmOrxgiDf0o3Ps7so1Cc5gBKO9Kz2nlm12QTNNdgCAHJKg8CVG1/G6wsr1aTF+ce
        3+o2rI9KmV7Y+LkteHEMX8CcZ2PVLhYSB/73sDUE68j4UreEsyGCzLU+XlapmSKC9496MV
        m9QbdZ7xff46+10GPBwk+YTsZtfJ+labLCMAIGe1niH+FmGhHtzrkfGWk/dUfCPZYEmyph
        8ocplSx6WOpBe5yXLY+1+xyXms5dgai3nUrpcfYgd/ZyJljyDb7RX7JgZ82eDSkQNG3tWO
        88Z4744sMOmA1fEw1PWgmwvQX8gupmP5EH0yDJky5ahGvBvULATZhVMrjJsdpg==
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
Subject: Re: [PATCH wpan-next v5 02/11] ieee802154: Internal PAN management
Date:   Mon, 20 Nov 2023 12:00:55 +0100
Message-Id: <20231120110055.3808254-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-3-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'2e7ed75e92fc493ff5484f61aed6489262c78f3e'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2023-09-27 at 18:12:05 UTC, Miquel Raynal wrote:
> Introduce structures to describe peer devices in a PAN as well as a few
> related helpers. We basically care about:
> - Our unique parent after associating with a coordinator.
> - Peer devices, children, which successfully associated with us.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel
