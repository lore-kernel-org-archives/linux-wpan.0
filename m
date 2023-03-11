Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C317C7618A
	for <linux-wpan@archiver.kernel.org>; Sat, 11 Mar 2023 17:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCKRdm (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCKRdc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Mar 2023 12:33:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D03D08B
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ek18so1899681edb.6
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678555999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXAmespG0M4hSiMCAu+5SVl3Gjs1X4fJ7l5m653N/T0=;
        b=h61OLmcgQZ49pdiaT/hMry9cHAP5irMaU8H2HF8mKrR8UcaTmYxRuNVscBm/7KcSZu
         iP9KwtjEe/2vbYH65cQWESLAptBhLAUdvgrrnES77GxdAbGIl5U8Y42eB7/y5s0Y4hSW
         mvj2c5nj9V8PzeMXsaLMCCoHABuAcjtkN819POzZEPr+rR7S8TsvpLjpWnMrFDmyd+07
         zlHWo/ouD5nf+6zfOSrQZ/GtUKPYMy0P/kUdaSLuRSQ//1hJXQ5IB9UXMKMX7HkTlnPd
         f99sqAPHOzCY4JSVlYAuscS6WSHfBCE4nLApyI6xWtqW7DobA7r9aMRVSOmlM102ttVK
         NBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXAmespG0M4hSiMCAu+5SVl3Gjs1X4fJ7l5m653N/T0=;
        b=mZEvAMfQFsEE8xHv1iA+jlrmtuwTZMiwGv793R696To8x3tb+onXWIwBWVrQBM52Nr
         x8rO6iFj35tafc1qqFZ5CW/AMvDZtORYUWJHaPqi2OTNUfOPGnWr+psMildln00QTihh
         0aDp5MsbxrL2/1WXZwJCNzDCq+fXrIas/dOj+1yrCJSAc7Q7I2GgJ7W/Sv69F+n9QE2h
         nLbrzCCUK7orlIU3cz8C5ip5c4DNYdEppPU5yqNoYw1ZB2H06q0UIkCwB+DDGFB08bFt
         eR5p6sQyS6CMJx8bJ/kdUfUFS2BIanjQ/YvuJ9tE39VTiaC/EuiHwUv0pEhe7LHokIrM
         7+hQ==
X-Gm-Message-State: AO0yUKWLe2wa/kVpIS/oSOXJcIG2dRll+t3Q16CX9/9MY8Y/iq2y4/jv
        1aQt/94nlrRwHEi2b4mcyffWgw==
X-Google-Smtp-Source: AK7set/kpZ2vdN8HmJ3eoEZdciC1xrNdRT0XaUll+kYhR/pDJF4w7J+TuEaXTUmUIJfY2jOSfMh2Gg==
X-Received: by 2002:a05:6402:542:b0:4af:8436:2f5d with SMTP id i2-20020a056402054200b004af84362f5dmr25453512edx.40.1678555999770;
        Sat, 11 Mar 2023 09:33:19 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004d8287c775fsm1440885edj.8.2023.03.11.09.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:33:19 -0800 (PST)
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
Subject: [PATCH 06/12] net: phy: ks8995: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:32:57 +0100
Message-Id: <20230311173303.262618-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173303.262618-1-krzysztof.kozlowski@linaro.org>
References: <20230311173303.262618-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The driver will match mostly by DT table (even thought there is regular
ID table) so there is little benefit in of_match_ptr (this also allows
ACPI matching via PRP0001, even though it might not be relevant here).

  drivers/net/phy/spi_ks8995.c:156:34: error: ‘ks8895_spi_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/phy/spi_ks8995.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/spi_ks8995.c b/drivers/net/phy/spi_ks8995.c
index d4202d40d47a..7196e927c2cd 100644
--- a/drivers/net/phy/spi_ks8995.c
+++ b/drivers/net/phy/spi_ks8995.c
@@ -491,7 +491,7 @@ static void ks8995_remove(struct spi_device *spi)
 static struct spi_driver ks8995_driver = {
 	.driver = {
 		.name	    = "spi-ks8995",
-		.of_match_table = of_match_ptr(ks8895_spi_of_match),
+		.of_match_table = ks8895_spi_of_match,
 	},
 	.probe	  = ks8995_probe,
 	.remove	  = ks8995_remove,
-- 
2.34.1

