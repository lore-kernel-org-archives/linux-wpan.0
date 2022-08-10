Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DB6C19F2D
	for <linux-wpan@archiver.kernel.org>; Wed, 10 Aug 2022 00:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiHJARQ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 9 Aug 2022 20:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiHJARP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Aug 2022 20:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD1197D791
        for <linux-wpan@vger.kernel.org>; Tue,  9 Aug 2022 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660090633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWwaUHjBysXWhHJ+eod4q2ogYoDzJ4P57FOFOXiREtk=;
        b=HyxAY64GXnH9CfsFkZQg0JItCxvaX5LlS98hi3IWooCRBK2b/uBWAo2RRAwrj69J9T4mCu
        /aTl+vXdGXnv35AOhdiWTjc6t1xgndaYeP7625qGXU9e28VeZDlLywgmXeRUiBO1226BDd
        +aSM5nTZskJNoAgJDtBLiAm6V5FLZUQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-GC-Xsn6bMryV2D54SpoQuA-1; Tue, 09 Aug 2022 20:17:12 -0400
X-MC-Unique: GC-Xsn6bMryV2D54SpoQuA-1
Received: by mail-qk1-f200.google.com with SMTP id az14-20020a05620a170e00b006b666c4627bso11527707qkb.23
        for <linux-wpan@vger.kernel.org>; Tue, 09 Aug 2022 17:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hWwaUHjBysXWhHJ+eod4q2ogYoDzJ4P57FOFOXiREtk=;
        b=VogXjLwyv2dcgdXoU/gZ5v/AxkW9Dqu46HCXOGRAQSShqppzpWAKLLv0VRq5fovTwB
         cs7mFA5RZ1EkT0JmiezXShib/6bDF9xxZDairh1ub5UC1zWKYT3lJ/vF0b0xF1n6+3RT
         dEbgU46UMC6MlH3GeVAT6Lx9R5bQeXNIof75JvB0KvwReiUpmKWlnYXPQ9psd+3EYuNf
         CdlNe9AgEOx7mWNCCZfUHcRtT8d1vWM87s4Kfvb91iZvdnvqpPa2RKAtXHcsaSMQ/IiW
         qfm13kbvDbMk4bmM599I5VNlPXu5c1M9vn1uu5sEsWU8gKNzQChLgRVHnqYdZpOd+X/B
         Sqfw==
X-Gm-Message-State: ACgBeo15v8L6yaNJdhlUFBbZAQpz6juVQ2OLB5ecVD58C53ebxIgnoa4
        eWhFC1dJ1r8VddHJsUYvjmjE5ofSUDelK7TeeTqCrnXwDDrcAyWJeVB+aa36Wvnvoa4AcK+b2F8
        g7ELfCuMCyIiJ8JEYnKa/r/LNQx5tpb7mzZLvqg==
X-Received: by 2002:a0c:e0cc:0:b0:474:94d4:53e with SMTP id x12-20020a0ce0cc000000b0047494d4053emr21898135qvk.2.1660090632158;
        Tue, 09 Aug 2022 17:17:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR65oSYaxdMQK1e3z5h5nEqt9Sgaho3HpLyfWhDFN2BziT6eJUv59emy46T6uE93XY9XUBsqOtkCCMMXbfgRTkI=
X-Received: by 2002:a0c:e0cc:0:b0:474:94d4:53e with SMTP id
 x12-20020a0ce0cc000000b0047494d4053emr21898122qvk.2.1660090631911; Tue, 09
 Aug 2022 17:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <3a3904c4-1bf9-ef1b-3d03-b5c3e1e2f8c5@desertmonitor.com>
In-Reply-To: <3a3904c4-1bf9-ef1b-3d03-b5c3e1e2f8c5@desertmonitor.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 9 Aug 2022 20:17:01 -0400
Message-ID: <CAK-6q+gBUHaR5njKHJJnONW41duVafMA-6R8jKMtN=7M1mg6rA@mail.gmail.com>
Subject: Re: 6LoWPAN (IPv6 over BLE) neighbor discovery
To:     Philipp Blum <info@desertmonitor.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Aug 9, 2022 at 4:24 PM Philipp Blum <info@desertmonitor.com> wrote:
>
> Hey,
>
> I am currently working on a demonstration for the W3C TPAC next month.
> Just wanted to get an update on this topic, since RIOT uses it in IPv6
> over BLE.
>

Which neighbor discovery are you talking about? Can you be more
specific here? I am not aware that any 6LoWPAN implementation uses any
optimized in-kernel IPv6 neighbor discovery for any low power/lossy
network, we are still using the default IPv6 one which should probably
still work if the other side supports it. In 802.15.4 we tweaked it a
little bit to support the short address into the address option as
RFC4944 describes it [0] that autoconfiguration can use it.

I added linux-bluetooth in cc.

- Alex

[0] https://www.rfc-editor.org/rfc/rfc4944#section-8

