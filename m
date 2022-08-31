Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F9ECAAD8
	for <linux-wpan@archiver.kernel.org>; Wed, 31 Aug 2022 20:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiHaUeH (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiHaUeE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Aug 2022 16:34:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3726DFB58
        for <linux-wpan@vger.kernel.org>; Wed, 31 Aug 2022 13:34:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lx1so30649656ejb.12
        for <linux-wpan@vger.kernel.org>; Wed, 31 Aug 2022 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BWCSto+d0Sdc3pu/dI6kfALxAxUh8nbvYhfQQse8Du4=;
        b=UqbaQCMQ8Ir0eFvGxnTJYodezvei/7SOzMXpuyww0mYZ3xZ4NBiWOHcuGfUW3JFyx6
         R9kOGei6YDc8ev/0UcWn+l1CYEt7H7an7s0unDOVanZTtppwMC/vEFfqNTie1tlekpiW
         bNhtEh95IhzL1atWzqECkFsv0tRezF/kKuHKL6kf89H4D4OGlyxQJQ5gBmJQFqBH8xk/
         T2ZZdn1ddK2rX1PgY25w1qd2Ae8olxOLVUy4GGw34dvLyCJT6IC86ek+E/DH3i0++g1n
         LiF76NTYdlhO+1mG8Wr+gxS9znLiCMWDPcbk+zJZS7dFcMdp7u7kz7I8mbZ0iq+OS9Sz
         M6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BWCSto+d0Sdc3pu/dI6kfALxAxUh8nbvYhfQQse8Du4=;
        b=w0CGSmKIQkeYsshl6l0WL48Dcrb23RCNlNlvcX0jiEVWn2OZgapk/6+XtUzL52BhBJ
         TbER+eEQ2M3wXhgTuNor1VbEqdFSKn3YbatjaA0n1QNbTRHcAWEM7gAeZrlYylgQcgV3
         b56/NIyXJzxZYTRE0yCpSL2ogoQulUXFEnH8MehLaP9DJjFJUSS3dsxlrF//cyWWtDJg
         qHn+ZueDjTFhDk0UisJc/aKgGlfEShGD862FLfURodlAv7nEbAgu3vr+3N3Twn5GKKJt
         jOfRfxCOfre91ScvXUjinLyjjPwasQxOiITtKm1NnBnEu0ycjJRVwOCAoGmhJiPdNZth
         Zpvg==
X-Gm-Message-State: ACgBeo2IOAMvFoy3ltL1epBZ+rmcm6Iek8/KHHHyUtSGzRWzcXALLVdD
        Am/x1s+RGQx7D9POjg4AxL8XUs0Fz0vBPaZ5dX6snw==
X-Google-Smtp-Source: AA6agR7EtnTzAoLqrkdRQji8od/wdsUejedlsqe6yDsRzJ4GH4pBLANa9tDTlmIUZyZjCCW75+Y2PPCFUGpfNE6atE0=
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id
 ds2-20020a170907724200b00741770bdfc6mr12548822ejc.203.1661978041297; Wed, 31
 Aug 2022 13:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <630fa8c5.moZxX4/JNtIfjYQO%lkp@intel.com>
In-Reply-To: <630fa8c5.moZxX4/JNtIfjYQO%lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 22:33:50 +0200
Message-ID: <CACRpkdb8bEyNrc7_gN+Lt-W_um56YfhOAcXgqEXsToGpvswmKA@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION 7fd22855300e693668c3397771b3a2b3948f827a
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wpan@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, Aug 31, 2022 at 8:32 PM kernel test robot <lkp@intel.com> wrote:

> |-- alpha-allyesconfig
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
> |-- alpha-randconfig-r024-20220830
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw

Fixed in this patch:
https://lore.kernel.org/linux-arch/20220818092059.103884-1-linus.walleij@linaro.org/

> |-- parisc-randconfig-r012-20220831
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw

Working on this one!

> |-- sparc-allyesconfig
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |-- sparc-buildonly-randconfig-r005-20220830
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |-- sparc64-buildonly-randconfig-r006-20220830
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
> |-- sparc64-randconfig-c042-20220830
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
> |   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq

Fixed in this patch:
https://lore.kernel.org/linux-arch/20220831195553.129866-1-linus.walleij@linaro.org/

Yours,
Linus Walleij
