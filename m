Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11666C6FD1C
	for <linux-wpan@archiver.kernel.org>; Sat, 11 Mar 2023 17:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCKRer (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCKReI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Mar 2023 12:34:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE83E0BC
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:28 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x3so32951681edb.10
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb45CXv6pKtdqYtvpQnbjuwacdqrOSlJTgeuRVg38GM=;
        b=sB0jHemmPnsrZbX5jq/nfP6dIGBR9zpynpPrwRAReydPckoMG1qUDHuOmjHsF+L+Yi
         FXvnMXmqpYO8E9fFXLywnZZ9EK8mFas/VyFoLkUHCJjZ0AxLPvCE4JBtcQY/at8B4Om5
         YwgqAo06jMK7oETpOssxg2MS10wQE6UL4JdHzsxMgj22D5zMBqhhnUsYfGZf6SPx87jA
         r9dAOCCQs2chuoPJOnSSAwON5DqVa7Fd/1BSbw96vEw06+L+4SoRc3i1xCYmrpsODnc8
         dWSHfPetw184oxgOPpb0Q5XFTIpZfWvrAciyNDeRwxZvrpKMGNeGZF9WDHSjCdcqq7Zr
         fRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bb45CXv6pKtdqYtvpQnbjuwacdqrOSlJTgeuRVg38GM=;
        b=h4HB02QZ5ZuGmdXIgwa8FyOFyNYjF6VJxX89h046vXzosHyETBC0YIKStnWbY6k8tK
         HiPj2tGpXH/MgSe5wU3tgIFOwiCveXOtT0etCzutZkYofeflOODMXn3GJLX3ZuZmFzNX
         jvWYmjFeai/p1AveZhUni9pL0/LIiIZAkhJe3OvCI+zZbQu5CZ2ey4UAguezhAeNLqfd
         wsm82C+9SF434/VfFZY2JhMEap3OZZm17kAhiuHgdzpAFUQfz0c4HZ5tytMpw4Yyeyuc
         r+NLExCMX+E+2NIU1SmRxFvqxfWcGo3lZWuGTwGcqqyoaQAaLZajPomuBBV0ZhYdQczj
         8Crw==
X-Gm-Message-State: AO0yUKX63+MvpuYA0iyILILJJ6KvJqzMCbZ0gq9SnIUqhuVk2UPP3ptj
        pf22vtKX8e0Nl5cK8JoA+9fiog==
X-Google-Smtp-Source: AK7set++ux4zDvlZTZkBob7j+q8P/Nvl1U5PQw52g7pwTikQ/uSeogp80Ri1hXGWTgDvuE//f1qJ3w==
X-Received: by 2002:aa7:cfd9:0:b0:4bc:403f:a7b3 with SMTP id r25-20020aa7cfd9000000b004bc403fa7b3mr5363100edy.3.1678556007257;
        Sat, 11 Mar 2023 09:33:27 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004d8287c775fsm1440885edj.8.2023.03.11.09.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:33:26 -0800 (PST)
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
Subject: [PATCH 12/12] net: ieee802154: ca8210: drop owner from driver
Date:   Sat, 11 Mar 2023 18:33:03 +0100
Message-Id: <20230311173303.262618-12-krzysztof.kozlowski@linaro.org>
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
 drivers/net/ieee802154/ca8210.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 65d28e8a87c9..ca1fa56cca68 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3180,7 +3180,6 @@ MODULE_DEVICE_TABLE(of, ca8210_of_ids);
 static struct spi_driver ca8210_spi_driver = {
 	.driver = {
 		.name =                 DRIVER_NAME,
-		.owner =                THIS_MODULE,
 		.of_match_table =       ca8210_of_ids,
 	},
 	.probe  =                       ca8210_probe,
-- 
2.34.1

