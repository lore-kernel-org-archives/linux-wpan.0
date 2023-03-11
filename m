Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D199C74A4B
	for <linux-wpan@archiver.kernel.org>; Sat, 11 Mar 2023 17:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCKReX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjCKRdk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Mar 2023 12:33:40 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C324B82E
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o12so33017265edb.9
        for <linux-wpan@vger.kernel.org>; Sat, 11 Mar 2023 09:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPTGdDBL8b40RCmwJ/SrwI24KRXn2ceVZMzb8HuniE8=;
        b=RMJAnx3hUX085h7uK4IIPYlR6BkBWKb5DISi3/TVx4WOj/hDyJWkXczuc21LYAj0bi
         JFsb8UepMLGx27vo9e0YBpvvBVNLE7TOTPUeD+QnrUhpEc4E9YNnxBxfUnxS8L+6zYee
         /1ZtE4e0/oDtGyVdDMZRk6nhskr6FtM64OeH08pmk7ebmJFsWegZOBmtoEmFmhD5MCyW
         07DkfNibueSpCDZXxY2zE/1f0qn42HXUETAdmSiF6YY/aFy+FXCS5jQWLdEerElZf/MH
         KrfpfAWWtlmEXKFk8G+lGrsf/m6qj4IFk2p5/pZPJX9PcOflu0mYW/Q39HydYMdnWy4Y
         SGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPTGdDBL8b40RCmwJ/SrwI24KRXn2ceVZMzb8HuniE8=;
        b=SVlYJpe4upQ8I4n1wjI7YS1J+NRHlDtSXfMu6NYZdtJJRaFQaU7IPG6YEHvp2dSvfc
         +yRD/QjhEcIZgg6O4ey5I5Jk7f6I6RExMhaYepSiMPMZhbGIqNkv3CpeSzZEo38p368E
         fm2th6uh9r7WuSfTGVUp3zuIhb7Sr03bxErvHIyM/9VpEsN71boWgmKKswI6Py6Ltb1t
         oAhY7mTJtEMV/d68hB8Sen6JqbgVj3PI9e/7o+0GtwIxSPZbHOy+ZYOOXcIpJLvzL5GX
         8WFnGdRW3X7KBUb+AjhAvmi0jnxM4aB4D7Q5TAIMVc9r6FzG3I3YE1LFjnw0xiq1Vtew
         XH9A==
X-Gm-Message-State: AO0yUKXRd1faCcxZrG8+WKZMcb03nKeGYm02wXVYBUecfKlg0weHNsVK
        Q6oFvvJtcWjVcffCeSswuOU1TA==
X-Google-Smtp-Source: AK7set8LcQuAvpdmH4YyQTjnOklUnNTtB1MERqqJcYlJGMRUuqDen6lOHZY7vAex7tGlhIdRelAcYw==
X-Received: by 2002:a05:6402:70f:b0:4af:7390:b488 with SMTP id w15-20020a056402070f00b004af7390b488mr27475483edx.40.1678556003405;
        Sat, 11 Mar 2023 09:33:23 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004d8287c775fsm1440885edj.8.2023.03.11.09.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:33:23 -0800 (PST)
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
Subject: [PATCH 09/12] net: ieee802154: at86rf230: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:33:00 +0100
Message-Id: <20230311173303.262618-9-krzysztof.kozlowski@linaro.org>
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

  drivers/net/ieee802154/at86rf230.c:1644:34: error: ‘at86rf230_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 62b984f84d9f..164c7f605af5 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1662,7 +1662,7 @@ MODULE_DEVICE_TABLE(spi, at86rf230_device_id);
 static struct spi_driver at86rf230_driver = {
 	.id_table = at86rf230_device_id,
 	.driver = {
-		.of_match_table = of_match_ptr(at86rf230_of_match),
+		.of_match_table = at86rf230_of_match,
 		.name	= "at86rf230",
 	},
 	.probe      = at86rf230_probe,
-- 
2.34.1

