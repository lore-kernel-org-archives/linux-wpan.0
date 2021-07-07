Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39F8C07E95
	for <linux-wpan@archiver.kernel.org>; Wed,  7 Jul 2021 23:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977216008E
	for <linux-wpan@archiver.kernel.org>; Wed,  7 Jul 2021 23:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGGXhX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 7 Jul 2021 19:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhGGXhX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 7 Jul 2021 19:37:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE43C061574;
        Wed,  7 Jul 2021 16:34:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k31-20020a05600c1c9fb029021727d66d33so1158345wms.0;
        Wed, 07 Jul 2021 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzIIS7pK2VZwYIvomdFlbHweoT1DZsRECHEVFUap8N0=;
        b=mmKrnf5V/DPMTkjm0+dI9aaWJsrn0mdZbXVoIX1D7IZebZR6UFLGNsbBpiqtYqIcEH
         rbWFuWWo2rQDvs6XmwPs1h6hdBOWvdsQk1zUg7+2uF1yTYdeTIdOP4vD5C67FSRf+CR2
         4l4qIvhuSu4txVMhaVttEkMMiXijI6mSy1Yq7rLIjenKagRbllh/3NG/HBDajF3F5NI3
         V06LwCTl+usxFBjCr5+HZv8Px9K7L0JwscvlufXgWzrg6Sqmz8otdVuL3MXlWY11qWJu
         aOyZ41OZASSnC228xiNgImxmd/yXYMUJoewCL7l4UkwbZ6b0dxpfieoQFPrtN/0F7xjs
         3efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzIIS7pK2VZwYIvomdFlbHweoT1DZsRECHEVFUap8N0=;
        b=a0hNSZWyVSQgYMjiRmsIfbe3ahSQ0ox8uHaH99iL1+ljETBK7Iq+YF5/qfQ3YkDjzD
         WWp+7PcUASVE/A5TV9kOGflJNZ/A/OY6mYMtO1VibVmdV2InKoKj3ZaLIAWF7BvGU8vu
         k7P0xKpZX5huNAWsg/DJr+LRBTaX5RgD7dWgvwB2vEoaYLDX2HDNSr/Y3Y6xzkKM5pbJ
         KVvAY0dqGMhdR2yp3rbHAtOhVH/vHAOIWSSAY1Te/3bFPW05Z1J0VaISmtzvZF4EI8XO
         RMR72S8zbup4RXMgF5v+4wvDhZbnfUFPXyuA1R/jBI1EN7JNqXhPRGeu3lAd5/jW4J40
         NhaQ==
X-Gm-Message-State: AOAM533p3AEhpbaQFV00FfxhGI5WdoYhBRdeiRRer6hre2U0u2M6cjx7
        Rov5MHRgYh+LB9WQW54DvV3+I4RXfKroZNU2E58=
X-Google-Smtp-Source: ABdhPJyjqOvwuRXlzs/0vfnHF+FzCxaSOOZF5m5uxFwpkelApM7oaAoF6x0LbTJ0zJ+a0sPvqoKj0RRfqzCxGTLJvmU=
X-Received: by 2002:a1c:e485:: with SMTP id b127mr1650100wmh.91.1625700880220;
 Wed, 07 Jul 2021 16:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210707155633.1486603-1-mudongliangabcd@gmail.com>
In-Reply-To: <20210707155633.1486603-1-mudongliangabcd@gmail.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Wed, 7 Jul 2021 19:34:29 -0400
Message-ID: <CAB_54W5u9m3Xrfee8ywmWg7=aMB+Rx05w03kHfLuBpYVbxbEwQ@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: hwsim: fix GPF in hwsim_new_edge_nl
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, 7 Jul 2021 at 11:56, Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> Both MAC802154_HWSIM_ATTR_RADIO_ID and MAC802154_HWSIM_ATTR_RADIO_EDGE
> must be present to fix GPF.
>
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex
