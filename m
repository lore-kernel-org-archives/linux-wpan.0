Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1343AC74A4B
	for <linux-wpan@archiver.kernel.org>; Sat, 11 Mar 2023 17:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCKReH (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjCKRdc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Mar 2023 12:33:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD72B9C0
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o12so33017160edb.9
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0eIoQUlzBtNWdRZyomXaxMeOe08r5W6w3hU8zY2eLk=;
        b=jQv/WlnODqsuHQabO1Micpq/pDWNovtU717/W3OPhTC7u6X2YK4ju3WLG6Dm2OWE1v
         pMN87UD+/bZt6J5qcdcLAtM30x0ExopjeMuP0dvT7u7VCie9RtQLTKSIEuWWVaDUdvJh
         AYvwEgUM5QDD3GArtIZvjbEj3KPJWwzHEl/Aa0GzUjLP3DlqbkQXnHkegC9HSFMWaorc
         UWoZ+l9TcZ+pzB/pvnati+hCDNrdfcFMgj6Y9pqjBjheJLgtrJJ4NBM9lJc9VWC3f8Kg
         yQXysQJfPkDAiJ2NqrSQtD32pdqe4mhGoetw0i3OUc30EoGH3NmEm8sn6cW2L2A11F8T
         sKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0eIoQUlzBtNWdRZyomXaxMeOe08r5W6w3hU8zY2eLk=;
        b=hXAdgiGsxU7EeUqDoAcur9bVTLVxPaho3FiZqTAWQncQ8HtA/Sz/LyDeLS3phUXpCY
         mDbW5tz9PYE/S9BmF1VRh7JOiRaMYdk0cZYny9xZstfRxLwR6RkusNfpWCq6IVp20irj
         ZqN8GbC5as/q6Gr3ZIfsJ9r4bsp1wrg121zDp6G7OJsD0XMpESrFU8nhR+cKkmcsMBmb
         SEQOJ0g1vtznT3blNFxlPFcblTVvXWYdsdhtzJ3Bn2/mnTaE9bZuM2rluoHdSuKOtKpu
         PqbHuL6Dtih10fpKY2kOVHDazXK77ruFPUn+fd5dsR79pj9NXF5jgXJx6sbIMSpUsHbK
         SdOA==
X-Gm-Message-State: AO0yUKV9iSYe2BmyqeRuIJxGUapJNvX1O6YXKo3mGVxa6KJqARX8iOJ2
        mOFu/GFAdp+lFm6VFXCF15nyUg==
X-Google-Smtp-Source: AK7set+Gav2lc+k6TaNhMqr6MQ7LBRUpCtyMan24OMdeglwwbEjp77cTDzo8yi4QIiHgdjmq562JTA==
X-Received: by 2002:a05:6402:384:b0:4af:6aa6:12d3 with SMTP id o4-20020a056402038400b004af6aa612d3mr23926913edv.40.1678556002238;
        Sat, 11 Mar 2023 09:33:22 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004d8287c775fsm1440885edj.8.2023.03.11.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:33:21 -0800 (PST)
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
Subject: [PATCH 08/12] net: ieee802154: mcr20a: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:32:59 +0100
Message-Id: <20230311173303.262618-8-krzysztof.kozlowski@linaro.org>
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

  drivers/net/ieee802154/mcr20a.c:1340:34: error: ‘mcr20a_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ieee802154/mcr20a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index f53d185e0568..87abe3b46316 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -1352,7 +1352,7 @@ MODULE_DEVICE_TABLE(spi, mcr20a_device_id);
 static struct spi_driver mcr20a_driver = {
 	.id_table = mcr20a_device_id,
 	.driver = {
-		.of_match_table = of_match_ptr(mcr20a_of_match),
+		.of_match_table = mcr20a_of_match,
 		.name	= "mcr20a",
 	},
 	.probe      = mcr20a_probe,
-- 
2.34.1

