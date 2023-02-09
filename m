Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EAAC61DA4
	for <linux-wpan@archiver.kernel.org>; Thu,  9 Feb 2023 10:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBIKnb (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 9 Feb 2023 05:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBIKnJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Feb 2023 05:43:09 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F483B0C2
        for <linux-wpan@vger.kernel.org>; Thu,  9 Feb 2023 02:43:02 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-520dad0a7d2so19578047b3.5
        for <linux-wpan@vger.kernel.org>; Thu, 09 Feb 2023 02:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Dfnv6QTzazTlsxHac3XWatpVo8TGduuTbtSvglXVvU=;
        b=EDs5k/W16zn0Ewb4Av+rMGdR5etMeYUDSOnhWymGYKcLYthti1GYfA2TP5e5t/ERNh
         MKbbieo53E8kpeB0Yyv2NvHUk0yfrE/gvmFC1NYjTeJDTe1h+OdhU5+m3DFeFdI2TB7T
         p17dPLZa8O46uE7nuWG/UhXPfYyFM5D148s8bTaU+meKYR6c/RyiM9fXtLSdxRl8iuwD
         C9fro1Hx0Q5jEuplvrdGWMyNelcJTVf+a5N4QugPxawAs41AoO9OZIKCubn/wPeMvXNA
         /bZx2ceCuEj/De9Vb4bWeaLRk4MMHC2KK2V4YS0PUdsK3mqNfcVg1olMoECAbSvgLbOn
         l2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Dfnv6QTzazTlsxHac3XWatpVo8TGduuTbtSvglXVvU=;
        b=jgeTtnuGPa+NwsdAXhZRCNkE2+DLiG/slqSSCamflpkDLrYEPs4hICAwDZ+Z5gXKEa
         E6GNqdqITkIIk4HyQRdGgNEzpyFeLWd0gmtpr9hPULP4nyKBKiUxF8mxPxxy9XF/U6Ma
         MKqQfjlxO8JT7bvOfN8b+5qW9d6+d9NM7+PagBs8TBU01NAd1s7i3dYZWBElx6NQtSd4
         d+hIxEZDKBtC0fmIc9dghzjeNsHLHzk8e5GZnbYxObTfySNG2iQwZPibHeZ2PZYT1PKu
         yBMx7HAyvv9PSj7AShRnq/6DEh4PM37xvdC5CwsIsdB93Ity3lUz7RECDLYXUhXzcuC8
         ezOQ==
X-Gm-Message-State: AO0yUKU8tcl9ueS30orTawFn/Zy0JhvgBtBW5nTzh7Npbwiv0RUQqNMv
        qeHz8bf13rtZnx4Z3PnLgL3dQcXAExRGAvpfLKbKBg==
X-Google-Smtp-Source: AK7set9QMguoIjGfWWwpFvhgz/Kg7HslLMdKNBORB2dldIzFQhQQTBP68JgHz09/otq/c2jQJlbDIxPqVcPmUJJPotc=
X-Received: by 2002:a81:d509:0:b0:4f3:8d0e:edce with SMTP id
 i9-20020a81d509000000b004f38d0eedcemr1154619ywj.185.1675939382102; Thu, 09
 Feb 2023 02:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20230208173343.37582-1-andriy.shevchenko@linux.intel.com> <20230208173343.37582-18-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230208173343.37582-18-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Feb 2023 11:42:50 +0100
Message-ID: <CACRpkdY6rc3hBoY=Cf4nTmMu=VA-d+VUveG6PsU6bvRKAgnxxA@mail.gmail.com>
Subject: Re: [PATCH v4 17/18] gpiolib: Group forward declarations in consumer.h
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
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, Feb 8, 2023 at 6:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> For better maintenance group the forward declarations together.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
