Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21814C00140
	for <linux-wpan@archiver.kernel.org>; Wed, 10 Aug 2022 22:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiHJWP6 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 10 Aug 2022 18:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiHJWP4 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Aug 2022 18:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 997CE60522
        for <linux-wpan@vger.kernel.org>; Wed, 10 Aug 2022 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660169754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mc94x2l1SWBFbi3Otw374P0izTSUSQQbduCAI60Vr9o=;
        b=DhHmxrydzBdu7saUv5O/f31n7qeCRdidsFTbJ8/4VUUYqesRkpgTqeStsuKXCAaZX60zIP
        A1wbGdSbh4G8FrLFNCFyP58WR+kY507Q9ZKpU4ZLfYnnz2XMTCIXObczQ4kt6rYjLIBjOi
        U/nHluGUpWQi3kXsRHDpuMZuvaiCNXU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-h1KIneUAO4aY56K1BI7WsA-1; Wed, 10 Aug 2022 18:15:53 -0400
X-MC-Unique: h1KIneUAO4aY56K1BI7WsA-1
Received: by mail-qt1-f197.google.com with SMTP id v5-20020ac873c5000000b003434ef0a8c7so3337072qtp.21
        for <linux-wpan@vger.kernel.org>; Wed, 10 Aug 2022 15:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Mc94x2l1SWBFbi3Otw374P0izTSUSQQbduCAI60Vr9o=;
        b=O0i9nNT0q9f6zi9GIfWob8D7KyJCj6KPEjpXL3aY73z7oKFHKRRgaLLzNQyqou0dz/
         6gD5s8i5PyPRC2EChe+O7j1d2GUD3Owz9XN//zZ4PHkkOLT3YSxNWT/Ej0lhS1ltS1uK
         l7n9VTdQNfp9i0nD7Ad7Nf+Aj6QrDRP7mTah0V0ezbxwIDRSGTlqNF8kR3kqvI+8gOMe
         QrLZsCndnvossXvOU/YsfF28V3O8IER0gJFxNieuetzLxMEAoU40tEznr2mTDTIMdBZP
         dSyTIIL82TA+iudPemram4KjW27D8DeLYcEzNHo5luBeOawSbx5x/msI8Umnd5/AQ9Pv
         4ayg==
X-Gm-Message-State: ACgBeo2/EB7rYWuZuc7bjM53xny8VBoI9D8vtgkhg0Jp/8eIRUhUgehL
        RCFJ5fO6ZXCbG85sMUVcVU/eFdxMLH/rbwjrLM0esVr49+L0V+fHkHAcF0cDlRw7QI/DaebuZiX
        Qdh9dgmH9Y+PkkoHXhU/aPFYEz6CmJ911+DKyWA==
X-Received: by 2002:a05:620a:4403:b0:6b5:e1ad:75a7 with SMTP id v3-20020a05620a440300b006b5e1ad75a7mr23025263qkp.177.1660169753096;
        Wed, 10 Aug 2022 15:15:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6JemclPb6rQn4npugQkHoAKTi0xijw2VyZ+3BmhZOPvZ0LHcz5SUC+PY+BLgAYoLCl9r0fV00cTKJCRvFMQYg=
X-Received: by 2002:a05:620a:4403:b0:6b5:e1ad:75a7 with SMTP id
 v3-20020a05620a440300b006b5e1ad75a7mr23025253qkp.177.1660169752921; Wed, 10
 Aug 2022 15:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <3a3904c4-1bf9-ef1b-3d03-b5c3e1e2f8c5@desertmonitor.com>
 <CAK-6q+gBUHaR5njKHJJnONW41duVafMA-6R8jKMtN=7M1mg6rA@mail.gmail.com> <f1dcf16f-938c-0768-4c88-754a0ea7c2d0@desertmonitor.com>
In-Reply-To: <f1dcf16f-938c-0768-4c88-754a0ea7c2d0@desertmonitor.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 10 Aug 2022 18:15:42 -0400
Message-ID: <CAK-6q+hfJ=oUHx0t7ueaNxg8NVsQZ2oJZ9wzj1PoP1fhHwpMrg@mail.gmail.com>
Subject: Re: 6LoWPAN (IPv6 over BLE) neighbor discovery
To:     Philipp Blum <info@desertmonitor.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Aug 9, 2022 at 9:41 PM Philipp Blum <info@desertmonitor.com> wrote:
>
> Hi,
>
>  > Which neighbor discovery are you talking about? Can you be more
>  > specific here?
>
> Sorry, I cannot, since I am not too familiar with the network stack.
>  From my point of view, mostly as a user of the stack, I can't pass down
> IPv6-PDs from my router down to the RIOT RPL network.
> I need some workarounds with radvd in order to distribute the PD.

What kind of workarounds? I am curious...

> There is a markdown file about it:
> https://github.com/RIOT-OS/RIOT/blob/master/pkg/nimble/README.ipv6-over-ble.md
>

Okay, if you like you could also try [0] on bluetooth networks... I
never did it on bluetooth. Although I think it does not make any sense
because it makes only sense on a mesh network and so far I understand
this is the difference between bluetooth 4.x vs 5.x/upwards and
currently there is no mesh bluetooth 6lowpan support here (but mesh
bluetooth on link-layer is there). It's a star topology. I guess what
you could try out is ndisc-proxy setup which is mostly the same but no
routing involved and they share the same prefix.

> People in the matrix chat pointed me towards the mailing list.

I see, on this layer it would be linux-wpan and linux-bluetooth.

- Alex

[0] https://github.com/linux-wpan/rpld

