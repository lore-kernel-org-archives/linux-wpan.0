Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79F5C197A0
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Nov 2023 11:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjKTLAw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Nov 2023 06:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKTLAw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Nov 2023 06:00:52 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC58CF;
        Mon, 20 Nov 2023 03:00:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A48DE0007;
        Mon, 20 Nov 2023 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700478046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPaqW1unqNYLwobu5MVnmGi393cZZdXcgvy3GDDemEY=;
        b=bk/egSQggvi3ys0gRPm8AlBJfMwj2BcJc4UmU6UcHheCGmJJ4RLZDoy3P40QObUKZLe8J2
        RDMYPL6tmBa6bw767jIkR8l2u/Rw7ZZtK+OrIqZdLe60EoySo2eSNCtpNHwJyB050RQsiM
        XfEAot/PgEuI6rc/CXW33ZJEwwft5GqGXk9WPDJksYHBhcko7SiPiMWJ6GR3jk4itwUlOv
        /qu8096S/Wbi1Bo4W0XuTkDAUP8e0wCFTAx9d6jdKCyHfBMKSaLSPC1vF4GTRjH1ztpawk
        jx8vRhHXdEoroF3D2SU5TPxqg5WJbvEzg/24mt1i8BjIMmn/m1FmwPOQG5llFg==
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
Subject: Re: [PATCH wpan-next v5 05/11] ieee802154: Add support for user disassociation requests
Date:   Mon, 20 Nov 2023 12:00:44 +0100
Message-Id: <20231120110044.3808153-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-6-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'7b18313e84eb62c3e4071f9679480159d8da5107'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2023-09-27 at 18:12:08 UTC, Miquel Raynal wrote:
> A device may decide at some point to disassociate from a PAN, let's
> introduce a netlink command for this purpose.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel
