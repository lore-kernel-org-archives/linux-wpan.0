Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B628ECE7A95
	for <linux-wpan@archiver.kernel.org>; Mon, 25 Sep 2023 07:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjIYHWS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 25 Sep 2023 03:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIYHWQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 25 Sep 2023 03:22:16 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE010E
        for <linux-wpan@vger.kernel.org>; Mon, 25 Sep 2023 00:22:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E0B820012;
        Mon, 25 Sep 2023 07:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695626525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9NeKCOKlfqVdx9HVGU8Xx9UYpOD3/yaTubKX6F9sm4=;
        b=iRCU+rExHx7qXDluoVwTR27/QIHFK6xaLNO3c9tOGbG6GjgDp7coQXwN2jQoiEbpHBTaFf
        cRaRWsTox/b1TJH9xumLiju1Ee2OO931tK1VtDhCrWKhy6Wy1ILqUB0qOfP8omFRG8rhst
        AuarCUFoub8JP++KcH85TTKlufuah5VotR78M8s79imA5FVm/TAYhLO3mnBcVXT3dD8AH4
        Wrtc0p4ACId+2Gaep7PLIwCPu8AEjhZ8+405IbcTSTUX2mW5iAhln2ZduC4u0/AhI6GtYA
        eNJSRqHqEi9Rde79t09WNnHQKaIEDVBANpVye46PiXy0WWgVrgttMMxgN089Dw==
Date:   Mon, 25 Sep 2023 09:22:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        david.girault@qorvo.com
Subject: Re: [PATCH 0/9] wpan-tools: switch to SPDX header for license and
 copyright
Message-ID: <20230925092202.0ab39c04@xps-13>
In-Reply-To: <20230924122231.716878-1-stefan@datenfreihafen.org>
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,

stefan@datenfreihafen.org wrote on Sun, 24 Sep 2023 14:22:22 +0200:

> Hello.
>=20
> I took some time to convert wpan-tools over to using the SPDX header form=
at to
> express copyright and license information. In this process we make the ac=
tual
> license (ISC) more clear and allow downstream users of wpan-tools to have=
 a
> machine readable format for license compliance.
>=20
> We are also using the reuse tool in our CI to check for this now and gene=
rate a
> SBOM file as an example.

Nice addition!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
