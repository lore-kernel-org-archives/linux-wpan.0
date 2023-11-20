Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C03C54E76
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Nov 2023 11:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjKTLBH (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Nov 2023 06:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjKTLBG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Nov 2023 06:01:06 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B39C;
        Mon, 20 Nov 2023 03:01:02 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F00C20012;
        Mon, 20 Nov 2023 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700478061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWPv7qmXbYMZsh3tgZrj6JHRyyZ0V+GeU5V2lZZNkDw=;
        b=JafUyBocuw6O1vMH7aL1zKFSfui9j3iokT4kne7i3Gjoxy+f1VDOPynauyHCEhN1l4qE8U
        UEJQJwy1Qo0eX/zn1x45vyq5s/TNSFKJNICWsQ+9jsQxN3gqO4PtvX6VEt2bJNXWHFu28F
        xV65sJXXXCDmMrkHheJQPW7YSGtoT5UbQEQ0GdML/qHu+ZOUvROevrChapCG4YvG1ABepY
        FM11bU16j+dg0DDP1KVP5ubsMEAmQKPjIkdN4SlFP2LwMBFzSOUQwd1Yr2v4bWamcA8a+d
        763RvLeAUv6J6YTe06rzhUTVP2TWrQlnfkU2/qkONUsApR4x/gX9gH7Byh1YXA==
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
Subject: Re: [PATCH wpan-next v5 01/11] ieee802154: Let PAN IDs be reset
Date:   Mon, 20 Nov 2023 12:01:00 +0100
Message-Id: <20231120110100.3808292-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-2-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'5260adf86b6732c75136fc1b159bb370062ddfa8'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2023-09-27 at 18:12:04 UTC, Miquel Raynal wrote:
> Soon association and disassociation will be implemented, which will
> require to be able to either change the PAN ID from 0xFFFF to a real
> value when association succeeded, or to reset the PAN ID to 0xFFFF upon
> disassociation. Let's allow to do that manually for now.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel
