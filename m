Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EDAC6FD1C
	for <linux-wpan@archiver.kernel.org>; Sat, 11 Mar 2023 17:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCKRep (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCKReH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Mar 2023 12:34:07 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC55A917
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s11so33017365edy.8
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ChsQRqVj0jyB/G1Crn3NbUNgDqSBdOpogFcEWxoqlI=;
        b=yFfRvTUq8NMpwBDMW7UK/XiLFl9kjGuyKMU6qYLCRLZ9FY/bH501DF/wQ6yDuxUdQQ
         WPYXmfNDCwgWk05x6qTaOos89AIeUap79eN5mHNBafSOIcuSdFWc06UCsp42sZRdl2Dd
         0JzSXMWgCjcC5bNy0k4naTtar8G6ntG0iQKToYtM8sIkSM/Y9NmSmvK4P3EpPAr+X3s8
         bWZMfAHe3MCjtegO/sEEKBtn4iL07KcXwonsyQJizBKHQqA3Wb34JH/EHU+QQeQbB+Aa
         airUXqwZDu7x3L67M26ZllM2/9sC8+K3PoPtKHjYzcVxpM/eRRU67V1AztMmTjdWL0E2
         G4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ChsQRqVj0jyB/G1Crn3NbUNgDqSBdOpogFcEWxoqlI=;
        b=3synqC8ztA64Gi5Ppe/zrxte7d9wsRKaBzEdqBAIql/ZQTVrk2TvgGHwba8s4Eelj3
         aNi/5S1ecta+KiWVWz1jhmIiPXe3uCIB8QO+HWrOsYBcll5yIb7Ws+5MXXangvXqjK2u
         tN6uMEbR1chdGw4g/hq2T9mh4frbjF/jvm83GL2jSZ+vvekEjVFedYWJxWwcQYqrzyNU
         PTu6DZcH1USv/zNc4T/hbRsJydcE3DUi76Fh/UFA5YXwtP59TMDdg/fL8hOuoSaiq9nq
         4thwrXMhHexEXAx0DCheo0bsSEspbS3VdPTELWJESZc/Gz9OUD38q38KT4xuO95gE/9j
         DAOw==
X-Gm-Message-State: AO0yUKX9wfae1gPN5fNwBsTmxl6EsBNLR4nAa6zXegRtmYkpjVsJKH8E
        XL4KenU311f/HYQkI3WXYIujXw==
X-Google-Smtp-Source: AK7set9pu+G41lQLLzsCDbrCUOAJyTJ8hQD32E3dD18LmZVTVZbRU/AI7oCy9fCGNZSx2Wh3lLlu1g==
X-Received: by 2002:aa7:cf0d:0:b0:4bc:ab52:ac70 with SMTP id a13-20020aa7cf0d000000b004bcab52ac70mr25748060edy.8.1678556005934;
        Sat, 11 Mar 2023 09:33:25 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004d8287c775fsm1440885edj.8.2023.03.11.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:33:25 -0800 (PST)
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
Subject: [PATCH 11/12] net: ieee802154: adf7242: drop owner from driver
Date:   Sat, 11 Mar 2023 18:33:02 +0100
Message-Id: <20230311173303.262618-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173303.262618-1-krzysztof.kozlowski@linaro.org>
References: <20230311173303.262618-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Core already sets owner in spi_driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ieee802154/adf7242.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 509acc86001c..f9972b8140f9 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1338,7 +1338,6 @@ static struct spi_driver adf7242_driver = {
 	.driver = {
 		   .of_match_table = adf7242_of_match,
 		   .name = "adf7242",
-		   .owner = THIS_MODULE,
 		   },
 	.probe = adf7242_probe,
 	.remove = adf7242_remove,
-- 
2.34.1

