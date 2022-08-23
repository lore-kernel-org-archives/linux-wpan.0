Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72592C32772
	for <linux-wpan@archiver.kernel.org>; Tue, 23 Aug 2022 14:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiHWO5i (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 23 Aug 2022 10:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbiHWO5X (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Aug 2022 10:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36CF30828F
        for <linux-wpan@vger.kernel.org>; Tue, 23 Aug 2022 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661257345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBRONIqnt4E6MBax+RN8UNcJe1L53HfRKZaqNtIx+8M=;
        b=LmSrcwBnel10o72rk+7ttsInp/Bf+cOstXP7XItAWJ7BWZN6KCIXyB9hEeixqlPPucTuTN
        Fo52+/ksem50bo7sZ0LGbWYiM+W7D/2RoEDpclB6ijZ/ungowdpra1N1VdxVIViE95c4ci
        hYAtdngokCsJS/Yy3EAnLF5JLFudusA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-VMDLWrm8O7KuoTmuCAZgiw-1; Tue, 23 Aug 2022 08:22:24 -0400
X-MC-Unique: VMDLWrm8O7KuoTmuCAZgiw-1
Received: by mail-qt1-f199.google.com with SMTP id i19-20020ac85e53000000b00342f05b902cso10331906qtx.7
        for <linux-wpan@vger.kernel.org>; Tue, 23 Aug 2022 05:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rBRONIqnt4E6MBax+RN8UNcJe1L53HfRKZaqNtIx+8M=;
        b=YU3RcKiToShfpLnxbCZGfMdzTHkNrwS+FOn/1O1JlFjeVHmlob74rBzs/dwxIKgrvx
         bQqCa2rHwGPtNqjZQYgN9s4aflrtg67wKhOJhAqitTGZYnzsFL8BV2VPMcOakUehCeYx
         Jo3lmHX5jjlss0Q2IC00rUNeOkRj0oE3dteQaOyniO9sMF+3MdeIybFQPRmOx7Zd9R0D
         Q3gUHlyzKFIj6uDjBKk0P1DQXRUMnPjUDmP0QAg0XEKojKsCP8LgvQVwHSsK6opXbezR
         inqQVGmqW5GKmKHXnBxqqx+9P1ucAaWuQYOCeo92ycjrX/cWRZl4oPFAun7Mcm5rNrEN
         1EFw==
X-Gm-Message-State: ACgBeo1AjNs1Ca2p5bx+DHxBqt0sPKuLM4Q60oqHM2e6tDKwvYtyNM27
        b47go4pkNO6usNxwd5kjXMGCeDTPJr3TCHoDUuKf6oR+sw1Lw+NLIuwFUMDgCBca56CADeQpWKl
        wSQHY7Mh+tGAbERCwUgglDbwBVVOrRDliyNYb9A==
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id q13-20020a05622a04cd00b0034365a4e212mr18592695qtx.526.1661257344327;
        Tue, 23 Aug 2022 05:22:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5GKTbzDfd8wryS9ex6M02iafW0bT+KO4ivoTSlfqZwnK57plTGzb+b3/uHyQGZR/6c4pz3OUf4d7o+2xiJpKE=
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id
 q13-20020a05622a04cd00b0034365a4e212mr18592683qtx.526.1661257344138; Tue, 23
 Aug 2022 05:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220822071902.3419042-1-tcs_kernel@tencent.com> <f7e87879-1ac6-65e5-5162-c251204f07d4@datenfreihafen.org>
In-Reply-To: <f7e87879-1ac6-65e5-5162-c251204f07d4@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 23 Aug 2022 08:22:13 -0400
Message-ID: <CAK-6q+hf27dY9d-FyAh2GtA_zG5J4kkHEX2Qj38Rac_PH63bQg@mail.gmail.com>
Subject: Re: [PATCH] net/ieee802154: fix uninit value bug in dgram_sendmsg
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haimin Zhang <tcs_kernel@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Aug 23, 2022 at 5:42 AM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello.
>
> On 22.08.22 09:19, Haimin Zhang wrote:
> > There is uninit value bug in dgram_sendmsg function in
> > net/ieee802154/socket.c when the length of valid data pointed by the
> > msg->msg_name isn't verified.
> >
> > This length is specified by msg->msg_namelen. Function
> > ieee802154_addr_from_sa is called by dgram_sendmsg, which use
> > msg->msg_name as struct sockaddr_ieee802154* and read it, that will
> > eventually lead to uninit value read. So we should check the length of
> > msg->msg_name is not less than sizeof(struct sockaddr_ieee802154)
> > before entering the ieee802154_addr_from_sa.
> >
> > Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
>
>
> This patch has been applied to the wpan tree and will be
> part of the next pull request to net. Thanks!

For me this patch is buggy or at least it is questionable how to deal
with the size of ieee802154_addr_sa here.

There should be a helper to calculate the size which depends on the
addr_type field. It is not required to send the last 6 bytes if
addr_type is IEEE802154_ADDR_SHORT.
Nitpick is that we should check in the beginning of that function.

- Alex

