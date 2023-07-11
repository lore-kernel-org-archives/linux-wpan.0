Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEAEB64DC
	for <linux-wpan@archiver.kernel.org>; Tue, 11 Jul 2023 08:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGKIgo (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 11 Jul 2023 04:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGKIgm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Jul 2023 04:36:42 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A6198;
        Tue, 11 Jul 2023 01:36:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B6A320002;
        Tue, 11 Jul 2023 08:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689064597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcF/dD7Z8yfzBkNvI4P1fBcyCYyfjI5P6OTKVfbQbv8=;
        b=U8CkyYbhudE9wDZfge8cSyPHStwQgVvafl7SIb3J50Q1cboyxZRzJf3hRq+AUDnXlPZ18F
        DF1r/N7EhCkD0mojaqSJrnBnXKgKc8hPrCf9jiSBjON9piRzd/5ARHmmE5xvAnm/+/gmQD
        zH95es03wpjuDL9oSNuTjqT3rdd02NQTLL0kBTxHwpv9B5AxvlcBdUA3ctcQLXGk6by2bA
        GDnjUYyH0H21dAwImqnCeSvhG6U6rjgWjCPVsgXqjbjal7stq+ZRYOAnpz1O/j12F/xEMo
        HJbHZEl9mPGThw2J7ygBIa6JUsvcMh7+tw1bUfnf1Iowy9HB28P6IPWVDByldg==
Date:   Tue, 11 Jul 2023 10:36:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net 03/12] net: cfg802154: fix kernel-doc notation
 warnings
Message-ID: <20230711103634.450e66c7@xps-13>
In-Reply-To: <20230710230312.31197-4-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
        <20230710230312.31197-4-rdunlap@infradead.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

rdunlap@infradead.org wrote on Mon, 10 Jul 2023 16:03:03 -0700:

> Add an enum heading to the kernel-doc comments to prevent
> kernel-doc warnings.
>=20
> cfg802154.h:174: warning: Cannot understand  * @WPAN_PHY_FLAG_TRANSMIT_PO=
WER: Indicates that transceiver will support
>  on line 174 - I thought it was a doc line
>=20
> cfg802154.h:192: warning: Enum value 'WPAN_PHY_FLAG_TXPOWER' not describe=
d in enum 'wpan_phy_flags'
> cfg802154.h:192: warning: Excess enum value 'WPAN_PHY_FLAG_TRANSMIT_POWER=
' description in 'wpan_phy_flags'
>=20
> Fixes: edea8f7c75ec ("cfg802154: introduce wpan phy flags")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: linux-wpan@vger.kernel.org
> Cc: Marcel Holtmann <marcel@holtmann.org>

I believe the whole series is subject to be taken directly by the net
maintainers, so:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Please let me know if I should instead consider this patch for the wpan
tree.

Thanks,
Miqu=C3=A8l
