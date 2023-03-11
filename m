Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A3C74A4B
	for <linux-wpan@archiver.kernel.org>; Sat, 11 Mar 2023 17:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjCKRdk (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCKRd3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Mar 2023 12:33:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5042B9E5
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id k10so32933214edk.13
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678555998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKur1r8OlOPHhO+W1SjiqgXs8kEkxFQEfXcxEmmOXUc=;
        b=k4Ti0rLnAWzmjDi7tWIcZx1FgUvGaYLD9CMX5Z4+jDpBipnLP+u8k1HeOmYB76PjqT
         wEu3FEQZHVG8ZpXSbrEZ3uEIq44dE1l7UIs6yoBhWaD7HllMVCzkAyDj+1hS4Yjlbnan
         l+9tDD7Y7A69//Cb0hV+luAlqtKGEg3lx0V82txAOxivF5XHSBmTRwMSmUKsPevtdK9S
         SViEPZi46I+SZU+M5TyvP5UfFy/c9YY/z6NKbL/u+RIRU0YLrvhWrTecZMJlzeOFrsXr
         S6qT43NZ5c/4m9ae4itCdHuKaTHdsT0FPBxXzAlYmPtLHl84lLisXDaVKG7+MkktVgNZ
         5zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678555998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKur1r8OlOPHhO+W1SjiqgXs8kEkxFQEfXcxEmmOXUc=;
        b=TzcFOj/Qy0nGhrBdgiWnFWqP3pB7zLQnfFQpWfCs1RhkGV0RKEoPcc3ZIz+s/HeKRM
         1dRDBVaOPcga42BrNrCwOFU+qUrMsOmzdbJiYscfmkOXFPQL3ItxB78A0WyJnOF9pp8l
         r48a0q+kIQ0FJAsFevHV/hznmWj1FUgWVH5Q+cUBjFKkSeEzfUVmBr/dvS1kiWp/gREf
         SxHlcet317i5UkomjhN2SlvKu3GMR1Rv/Fx37z57w0mWHHeEAxflsqbV7inbE0m8FFpN
         PkiSYZxIZwBc4boMTFuSZFMQEnod7TXTUCLV9MjeqfiFuIe5vPRdDa5KM+Nwagw3asjE
         Coww==
X-Gm-Message-State: AO0yUKUfquQRbPMWWyC3ntXuNJ5waEgo7vbumWtRSRRS3u7uPUd6gd8t
        eR/u2xOWOm+V4cE+Z/eYduXG9A==
X-Google-Smtp-Source: AK7set+7UkOx/2YMNdMbGIWOGP5Y0f4Tdf6ivMioIVg2xYb8RrkCWLmuL1/fIFWs5ACOFrdzbgdPgA==
X-Received: by 2002:a17:906:fe44:b0:8e6:bcb6:469e with SMTP id wz4-20020a170906fe4400b008e6bcb6469emr33549135ejb.0.1678555998342;
        Sat, 11 Mar 2023 09:33:18 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004d8287c775fsm1440885edj.8.2023.03.11.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:33:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/12] net: dsa: ocelot: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:32:56 +0100
Message-Id: <20230311173303.262618-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173303.262618-1-krzysztof.kozlowski@linaro.org>
References: <20230311173303.262618-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/net/dsa/ocelot/ocelot_ext.c:143:34: error: ‘ocelot_ext_switch_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/ocelot/ocelot_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
index 063150659816..228737a32080 100644
--- a/drivers/net/dsa/ocelot/ocelot_ext.c
+++ b/drivers/net/dsa/ocelot/ocelot_ext.c
@@ -149,7 +149,7 @@ MODULE_DEVICE_TABLE(of, ocelot_ext_switch_of_match);
 static struct platform_driver ocelot_ext_switch_driver = {
 	.driver = {
 		.name = "ocelot-ext-switch",
-		.of_match_table = of_match_ptr(ocelot_ext_switch_of_match),
+		.of_match_table = ocelot_ext_switch_of_match,
 	},
 	.probe = ocelot_ext_probe,
 	.remove = ocelot_ext_remove,
-- 
2.34.1

