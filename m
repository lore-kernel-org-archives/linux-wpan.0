Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B107C636D4
	for <linux-wpan@archiver.kernel.org>; Fri, 17 Feb 2023 09:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBQJBX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 17 Feb 2023 04:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBQJBW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Feb 2023 04:01:22 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB65D60A50
        for <linux-wpan@vger.kernel.org>; Fri, 17 Feb 2023 01:01:03 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 51D4B40007;
        Fri, 17 Feb 2023 09:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676624462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/DVDURoWgNGbLonQ7APDI+TgdZJXbcoKOZC4DnKLPIU=;
        b=AqnHGzyg1I6z2x5Z1iyRCKbz+QwHdY0cDpMkUeOa6eC2q0WAu7loUesdF/E2TxMg09CBkG
        ZFacTaYdfEv8oaguwgejjJelpelVso+ooHPJXVBnfKk+Tgo3ZLXQfXOmSJvcTYeog123J4
        BdPRZqbiqqXsvf+x3OeE+08v9TxMZMwu7Kp7W8+jx9i6S2Sa/m5fR9AfBVuVJW0CFIbKq2
        aAxw+6OgkGchfvt4yJAlbIgvLjfFs4+0R947bx1JxTDyCW3nBpmtUORMpj9kdVL4kiZ9qI
        XvqdAsTqeM4l+1QkSIn/qnQtFwOYOAts6vb2iK77/WH5iW29sgosBxTtx9Uq7g==
Date:   Fri, 17 Feb 2023 10:00:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Linux Wpan Mailing List <linux-wpan@vger.kernel.org>
Subject: ieee802154: energy detection question
Message-ID: <20230217100059.58e92818@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

I know this may sound like a silly question but while looking at the
various drivers implementations I found no users (at all) of the ->ed()
energy detection hook. Its comment says that the mac layer is supposed
to use it but I couldn't find where. Of course, the fact that the
abbreviation ends like half of the word in english "-ed" does not help
grepping for that, but I could not figure out how useful this callback
was. In particular since it is mandatory to provide.

I am pretty sure I missed something, so perhaps someone has a pointer
to help me there.

Thanks a lot!
Miqu=C3=A8l
