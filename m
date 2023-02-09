Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2128BC64EC5
	for <linux-wpan@archiver.kernel.org>; Thu,  9 Feb 2023 10:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBIKoA (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 9 Feb 2023 05:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBIKni (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Feb 2023 05:43:38 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3213928B
        for <linux-wpan@vger.kernel.org>; Thu,  9 Feb 2023 02:43:25 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id x71so920414ybg.6
        for <linux-wpan@vger.kernel.org>; Thu, 09 Feb 2023 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O7bf9Uq485R2NtxZEe67divp+n6UAi9uTuUydnCWVSg=;
        b=GLwl7Q7S+sW3h6atJzFjD9AilOcYqsPpQ3N3GeZ/D1Q88eJFYLRx7SByx2MKR3Tbg6
         QubdUMrA1FyWuDBqNGk/KYgKHj88NCbcdHz0TdxzXQlWldCFmt+T88T3OTKYV4CWPws+
         UJNXxHkfOucmMuvDGUcoQO0SeUM/g0ki7Fy81zLeWxa8HJRrq0tPaCgVq8mtC+dl1KTG
         v1A/7RHpawAeO/VgRA2to2txj8hRpIw2aZGHWCGR5He7S8Yx5BD5smCOGAdYNCvajG6I
         Ri7bl0JjbLdIsGg97InNpJ8AnGnu5MYrxD0Ms9oC/qKIpgK736+hK9g4RDJvTDvM1KLX
         Z9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7bf9Uq485R2NtxZEe67divp+n6UAi9uTuUydnCWVSg=;
        b=nwwFyl9oJqipK6oMMrucGwPJpShsY9hWhJOQUHXpQJFkbBx/aKoUTBVi9Bil9lQYmA
         6ThJ+TS2hW022o6wdYtGXN/BJkbMHM1CjIvllJlhqcXann8BLksduPNVa036T8wps2Ln
         iP2IH/nz+eXOsLq8pVCMYYzb6zp8zKXUs/Io4bLROPA5OqIuijvukt4hqxp1Rw0JAx2U
         Vw1LUjUBes58s80zbFL+MjalgZL1uirutC6BLhCZ/1R7IZLUPNsq26qXPtlMxchqzZuU
         U+feakWdeSGxBmQ/gjgZA94DK/Jx9Pns0RAfBYPfkAeXhmJcIUXdBDRNlnlc6QZ4eXEJ
         VkIA==
X-Gm-Message-State: AO0yUKUKmtfdNijzpdu/UEobty7QUWVyvba2eWxyP2jbAcK9LQrZ1Q6t
        LFyBPDnWEYh9O6C8F2ieoBdLwNly39vLzbOppku6KA==
X-Google-Smtp-Source: AK7set+gn4TRcnw/Px4w/IuFAMVTVJyu4IvoJ/vrCRoCZs1e5OwtzAnC5LkZeezUkZu5vWtv8zRWrBwhSzP2jQpPPmI=
X-Received: by 2002:a5b:150:0:b0:88f:92ec:4292 with SMTP id
 c16-20020a5b0150000000b0088f92ec4292mr1180607ybp.460.1675939405127; Thu, 09
 Feb 2023 02:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20230208173343.37582-1-andriy.shevchenko@linux.intel.com> <20230208173343.37582-13-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230208173343.37582-13-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Feb 2023 11:43:13 +0100
Message-ID: <CACRpkdaTvKhRi2_szWCPv+NrXAzsT7ROKv-OJDh5NgLJznDzCQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/18] gpio: aggregator: Add missing header(s)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Michael Walle <michael@walle.cc>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Keerthy <j-keerthy@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, Feb 8, 2023 at 6:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
>
> While at it, drop unused linux/gpio.h and split out the GPIO group of
> headers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
