Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB48C05027
	for <linux-wpan@archiver.kernel.org>; Wed,  8 Feb 2023 17:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBHR4N (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 8 Feb 2023 12:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjBHR4M (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Feb 2023 12:56:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF8B7AB7
        for <linux-wpan@vger.kernel.org>; Wed,  8 Feb 2023 09:56:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x40so28164151lfu.12
        for <linux-wpan@vger.kernel.org>; Wed, 08 Feb 2023 09:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpljMohL8GLL9JNNZm5TNh7NQliOwfqEEgvKA1M8vPA=;
        b=iSJy452+yQNDkj/XRpSJtdvrqV4Nc9SHmDUlIPEMcI7FsTBkg180jQi1F8xp6YW1iB
         x+n5zVe4ua33Iptv3+3hIXXVPzCDMsaE+aiY5ZioYXS2QK7YcFrDLdAp2jdyqNCNAiuB
         jOEvyRlDxjvya+Oe6QZshDBs21k3QFl/D0kQ9C/WADLHUUR3m08hnMM5D5Fh2ivALyk/
         MfyowyYvxCwIcJkZ8wjZ8+6pip+4HEgfvld60+W6Z8mMTEGB2wvoc+UcpG17rGgizxEB
         3jdEH391M/2wSjYcYiPL4nNwuw3AUeWO4FlI+ZrKLIUg3rr1b9AQb/hWfziar7N1D7kJ
         2C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpljMohL8GLL9JNNZm5TNh7NQliOwfqEEgvKA1M8vPA=;
        b=5ba6NWMLHKTYwxPC9uPuAdtj2jg/fU3hN/aFMzPePjCYq6+X0eDSSH+C5vupZpFVrt
         EyPNO/c9SUR9eKLXjXYdoJjYQMYHe88MvH+iG/0+x2BKxTbIdq+/HdO+X+aBmfttUhGT
         juenrEinOHub2xeLy3ravUhvbqKo/+q7Ef7qNczXc3ekr+PaoSoTx6baOwtAUjvuYt8O
         fJgSoDyc0X3nkPBh+F16T6nH+eVZjruDoOfu3wYerxXtpDGv99kiqZHbJs92ZNbFd9vC
         wtWhEQ83aUWkfKZnW4HfYj08rmgW3UCdeGL4laJ05AnZ/oFn6aCQRzekiIrfkLbTLLLu
         qPEw==
X-Gm-Message-State: AO0yUKXbcmpyKHb3SB8TDyV2GH/ZXSk0vTfHJC7A6Z+AN1SvDaIQdYbl
        JKk1nBgVsWwSWGwk10sUUIX4CeEH2ht/K1bQ
X-Google-Smtp-Source: AK7set/lK0dtz8rcHRt03yyNK2Vwc1Fz232Sf6dsRanegcNrGJ8x6yT7AAkYHUf260eQ8ib742Kj5Q==
X-Received: by 2002:adf:f212:0:b0:2c3:dbe0:58ea with SMTP id p18-20020adff212000000b002c3dbe058eamr8107790wro.47.1675877957261;
        Wed, 08 Feb 2023 09:39:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u10-20020adfdb8a000000b002bfb0c5527esm14273251wri.109.2023.02.08.09.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 09:39:16 -0800 (PST)
Message-ID: <30234963-33e5-e2d7-a6ef-112e89efbdd0@linaro.org>
Date:   Wed, 8 Feb 2023 18:39:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 02/18] ARM: s3c24xx: Use the right include
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        devicetree@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
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
References: <20230208173343.37582-1-andriy.shevchenko@linux.intel.com>
 <20230208173343.37582-3-andriy.shevchenko@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208173343.37582-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On 08/02/2023 18:33, Andy Shevchenko wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The file s3c64xx.c is including <linux/gpio.h> despite using no
> symbols from the file, however it needs it to implicitly bring in
> of_have_populated_dt() so include <linux/of.h> explicitly instead.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/arm/mach-s3c/s3c64xx.c | 2 +-

It's not s3c24xx anymore, so subject prefix:
ARM: s3c64xx:


Best regards,
Krzysztof

