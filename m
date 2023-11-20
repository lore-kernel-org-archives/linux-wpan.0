Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B46C197A0
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Nov 2023 11:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjKTLA4 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Nov 2023 06:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKTLAz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Nov 2023 06:00:55 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880549D;
        Mon, 20 Nov 2023 03:00:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 932C31BF205;
        Mon, 20 Nov 2023 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700478050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nraIXLr/sjekfG8OPPtcnU5dEoAMEdDvcsPXVL3KSDg=;
        b=oOPKzeyuuKZvMTiflbX+QIuJoSz0iZ1tXZJh4qL2lxRFaAJbX8+bWaLxFVho+IDLG3agmI
        udn0GovT9L33X+VwTrn2dkyqIYnyKJX14mHhSxE6I4ZV8a86lXY0ObMyZLuraH3tJHYndQ
        mVERFIxJQIUEPIDCK3FE7iAmvlWvrEVdAA4dEOUeCc3igHiI0u5L/8sSfo07WF1V9fZad0
        /FssUIAcQV1/4XdNkSrpm8QuaXwmleKFHNjEYErTCxGcd/0zARgyRZSUZ+3pHbqJwqT6Vm
        FM/cl2dKDrE1FFCX5l7HfZJzjNpw/FIApQ2i1nwmY7h5A3dYqhdrx73Vxn37kQ==
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
Subject: Re: [PATCH wpan-next v5 04/11] mac802154: Handle associating
Date:   Mon, 20 Nov 2023 12:00:49 +0100
Message-Id: <20231120110049.3808188-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927181214.129346-5-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'fefd19807fe9c65002366c749e809996a1ca4e68'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2023-09-27 at 18:12:07 UTC, Miquel Raynal wrote:
> Joining a PAN officially goes by associating with a coordinator. This
> coordinator may have been discovered thanks to the beacons it sent in
> the past. Add support to the MAC layer for these associations, which
> require:
> - Sending an association request
> - Receiving an association response
> 
> The association response contains the association status, eventually a
> reason if the association was unsuccessful, and finally a short address
> that we should use for intra-PAN communication from now on, if we
> required one (which is the default, and not yet configurable).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

Miquel
