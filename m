Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F1C433B4
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Apr 2021 00:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361DB61393
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Apr 2021 00:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhDEAeH (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Apr 2021 20:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhDEAeF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Apr 2021 20:34:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7EBC061756
        for <linux-wpan@vger.kernel.org>; Sun,  4 Apr 2021 17:34:00 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so9993782otk.5
        for <linux-wpan@vger.kernel.org>; Sun, 04 Apr 2021 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqLDFjVKFUdPicZtxkYljksLT9BsdVgBTmMUFSeDXpY=;
        b=S4Q2xR72ILOvBmyeI6i6dJasYFpzS6pTqpVIIfj8m1UWQY5YUmpy2GBQ+Dbh+v4Qvb
         O4lfkluPSiA1Ak8PPUwWClOi9yHCkmme4k/0l3NWTnsukWdXI1TsrrkJEf5RWT0TF2yv
         kHkr8FMB3GbVlzIrU5fkMUMju5iTkCOa08ouZFB5/TsvC9uJ15npZpi6chEJAKOeBz+6
         CC0Kz7kbk3nsy6ZytmgdELN7HUARCPsS2UbBqhMh1G7t32BHxbKuHQGpNbVx6MnJBegY
         ofFPkBvo9ohSGMBXZLpEJl+RKg23Efp2+9PFU76dZVnzqN4HqgyObtzJyl35zMtS3Uzs
         27eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqLDFjVKFUdPicZtxkYljksLT9BsdVgBTmMUFSeDXpY=;
        b=qY97ykw3jsQi0d+9s37Y/irWpKk4m0ioONxTz7bZ8vuH3Ux0ZvgtmVZ5Sp5gxEV74I
         9LyOLfZlWW3qdAnjsjSighKogDyURzWJUNzQ0vmCDlI5Du/6YeQVTfSPrmVoPUl8WwAO
         XMefyPXhJsFoB7HKJ2jRQ407L4twoBrjNbEKa4RAnt+hRRnPKHa620VUB1Qj9/YqEAQ4
         EzQziWuj4wLObXWB3B9QMhzrzHT5uiFEX1fWc1DVwdlWmRXOisGhgz/UFFkbtesddjIC
         Y4TG3kwgAaywuI8bxheahHXOygGrekLx0LUGWZc8jc9/iF5kIer1kCIhzBJWjZdvgRsO
         tWaQ==
X-Gm-Message-State: AOAM530URRWUownXBnNDL+Gs0opI5nz//wCIu09Bht3BrSe81AC24ow/
        2vhU0pcHVUcO6l8Sp9Txeg7BIIHwp30VqBTQ+Rs=
X-Google-Smtp-Source: ABdhPJzJxMkgS4JHoN4gbmRjrB4MBhFAJJoKBX9G7KPhLbSU3wwWVd3BDD56xTFUiCS9YvTX/i7lM2lPAWVrfY/tx1g=
X-Received: by 2002:a05:6830:111a:: with SMTP id w26mr13291774otq.329.1617582840067;
 Sun, 04 Apr 2021 17:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210404045712.50954-1-ducheng2@gmail.com>
In-Reply-To: <20210404045712.50954-1-ducheng2@gmail.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Sun, 4 Apr 2021 20:33:48 -0400
Message-ID: <CAB_54W5BwCoJ9u45PZrZpF49Jzh41eGvysG0KwrhoFD8e5y1Ng@mail.gmail.com>
Subject: Re: [PATCH] net:mac802154: add init of .sec and .sec_mtx for sdata in ieee802154_setup_sdata
To:     Du Cheng <ducheng2@gmail.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        skhan@linuxfoundation.org,
        syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sun, 4 Apr 2021 at 00:57, Du Cheng <ducheng2@gmail.com> wrote:
>
> add mutex_init(&sdata->sec_mtx) and mac802154_llsec_init(&sdata->sec) for
> NL802154_IFTYPE_MONITOR inside ieee802154_setup_sdata. As the unintiated
> mutex and sec data structure were used in ieee802154_get_llsec_params
> which would cause a kernel crash. BUG reported by syzkaller.

this patch will fix it in a way that the user is allowed to set llsec
parameters for monitors but they will never use them because it's not
supported. I resend my patch series which should forbid monitors to
set any llsec parameters for now and the user will be aware that this
feature isn't supported right now.

Thanks.

- Alex
