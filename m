Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F80C001B0
	for <linux-wpan@archiver.kernel.org>; Thu, 10 Aug 2023 06:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjHJGRz (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 10 Aug 2023 02:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHJGRy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Aug 2023 02:17:54 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82374D2;
        Wed,  9 Aug 2023 23:17:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B87F5FF806;
        Thu, 10 Aug 2023 06:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691648271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCIldS7LgLkPH6J7rOrlaq8d6ZCqBahmrHWXhqMCqrQ=;
        b=Jo6v7fsauFxEg0pgDs7l0RyOUOqAr1TIKTgcHJZmAD8dsHY0cAKbYXbcXKj5t/V+1feTy1
        ZHeivWFlH8RBiM/9sCPF+vzuQBeIBuL40kfYZdiHUuVAS98ocnGZzFY+7vPD/huMvuql6U
        A3iXMVmAB6X7Phi7XdbhXwH4SqdMCttpIDAqxHzYUFzNeW6dW/NsWSLiiw+BH9qlQQHwAe
        8mnrvYJYkyn3ZPvBW6YLfMpRLtfPLyxy98cMQRZSXt5R7XsUiOoixoP7P0xFLWp2jWNgRA
        3Jtko+zPAP4vjS4Cttq4iBDB1Ai1NmGjdMNd6ynYX0/U1EdvDtcV9YOWzs9LNg==
Date:   Thu, 10 Aug 2023 08:17:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, jiri@resnulli.us, johannes@sipsolutions.net,
        Jason@zx2c4.com, alex.aring@gmail.com, stefan@datenfreihafen.org,
        krzysztof.kozlowski@linaro.org, jmaloy@redhat.com,
        ying.xue@windriver.com, floridsleeves@gmail.com, leon@kernel.org,
        jacob.e.keller@intel.com, wireguard@lists.zx2c4.com,
        linux-wpan@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 05/10] genetlink: use attrs from struct
 genl_info
Message-ID: <20230810081743.567abd78@xps-13>
In-Reply-To: <20230809182648.1816537-6-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
        <20230809182648.1816537-6-kuba@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Jakub,

kuba@kernel.org wrote on Wed,  9 Aug 2023 11:26:43 -0700:

> Since dumps carry struct genl_info now, use the attrs pointer
> use the attr pointer from genl_info and remove the one in

"use the attr pointer" is present twice

> struct genl_dumpit_info.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

>  net/ieee802154/nl802154.c       | 4 ++--

Otherwise for wpan:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
