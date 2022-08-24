Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7E4C00140
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Aug 2022 12:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiHXMih (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 24 Aug 2022 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiHXMig (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Aug 2022 08:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23128F961
        for <linux-wpan@vger.kernel.org>; Wed, 24 Aug 2022 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661344714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9jr+amK0uWEEWGvSLDxuMVCNNDt0iE/dvefpOk4UgzQ=;
        b=cTr+YYyzy/Ic98M1akm8TFGRHJungRY0NJyZeLoCDtv4nNdOVAy7iwwjurYG8m/aW7Z9jM
        P3yoR00CThcxDiWzUdWubvsbsqlkmKQtqOj3qjH8w2LdsUAXmyTK0EQc7oDwpabWgKEprY
        T9NPCE3/f3kR8XAHq6FG/L381LlvwBM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-AFl_NbbTMZmRPRYq1gJ6vg-1; Wed, 24 Aug 2022 08:38:33 -0400
X-MC-Unique: AFl_NbbTMZmRPRYq1gJ6vg-1
Received: by mail-qv1-f70.google.com with SMTP id lx4-20020a0562145f0400b00496ecf45ac4so4970514qvb.7
        for <linux-wpan@vger.kernel.org>; Wed, 24 Aug 2022 05:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9jr+amK0uWEEWGvSLDxuMVCNNDt0iE/dvefpOk4UgzQ=;
        b=xAR+NjRb6fA4ODvDrVY72Yvlqabc4nVr3aLbvo+XZAjagCxnYmE46sOpv58c/HiHH9
         56X7F0YiZBrpr/WCPKDUFnyLdonfpqw66mpHvw1BWrPJOOkMjPZIGRgoAibRWC2ts7D2
         8790gk5+sxqxMZWs7U9pyLQ4bE4iiAgY9C7aKkZ/GYytWcg4np/bakkPVH7QERDEqmsg
         ctiYs07Uvpk4Bl/V6/KrUi3TZrlGAjky/k/8L2gKC+KpqJ7v3fdxzt7IC37eeMuAVAfW
         uIK90TDDHYC8/3UEUWABSW50KcutGcVEEP5pIjulgzaVj5j5RuV/4KnhXieBs1lpzUAH
         s5uw==
X-Gm-Message-State: ACgBeo3g0HMX6Mkjn3QNVSS/TeCH2MFGDsqILGbIPurqmhq/e5iUsrfM
        5vhn6GtIwbiMRRll8p7qJ6JD5fktDU6Gksx5SItpbNKVJf8NE2m0I16l3ldzAkIt8tZv9aC7gzW
        2+UIvPWURFWG8MVuI7L31zEOELrZ4INjgGGh7uQ==
X-Received: by 2002:ad4:5d6f:0:b0:496:5ad5:fa40 with SMTP id fn15-20020ad45d6f000000b004965ad5fa40mr24705002qvb.59.1661344713148;
        Wed, 24 Aug 2022 05:38:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5JSXq91N8s0XEtfCISGeusZI4avtWP9oNK+/vGFim1UEwZ9lqifEh6HdmO1keP9tUUF/WsRoUMcvpA/Bit5i4=
X-Received: by 2002:ad4:5d6f:0:b0:496:5ad5:fa40 with SMTP id
 fn15-20020ad45d6f000000b004965ad5fa40mr24704987qvb.59.1661344712950; Wed, 24
 Aug 2022 05:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220822071902.3419042-1-tcs_kernel@tencent.com>
 <f7e87879-1ac6-65e5-5162-c251204f07d4@datenfreihafen.org> <CAK-6q+hf27dY9d-FyAh2GtA_zG5J4kkHEX2Qj38Rac_PH63bQg@mail.gmail.com>
 <CAB2z9exhnzte0rpT9t6=VpFCm9x+zZdmr01UHFxqvYy8y9ifag@mail.gmail.com>
In-Reply-To: <CAB2z9exhnzte0rpT9t6=VpFCm9x+zZdmr01UHFxqvYy8y9ifag@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 24 Aug 2022 08:38:22 -0400
Message-ID: <CAK-6q+g-L-6kKW69DYxgXvLdfChF+oQsmi-Y4cvBK2ji2m4WZA@mail.gmail.com>
Subject: Re: [PATCH] net/ieee802154: fix uninit value bug in dgram_sendmsg
To:     zhang haiming <tcs.kernel@gmail.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

cc mailing lists again.

On Wed, Aug 24, 2022 at 7:55 AM zhang haiming <tcs.kernel@gmail.com> wrote:
>
> If msg_namelen is too small like 1, the addr_type field will be
> unexpected. Meanwhile, check msg_namelen < sizeof(*daddr) is

Then check if space for addr_type is available, if not -EINVAL. If
addr_type available, evaluate it, if it's unknown -EINVAL, the minimum
length differs here if it's known.

> necessary and enough as dgram_bind and dgram_connect did.
>

you probably found similar issues.

It is a nitpick and I see that the current behaviour is not correct here.

- Alex

