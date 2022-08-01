Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7794EC00144
	for <linux-wpan@archiver.kernel.org>; Mon,  1 Aug 2022 23:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiHAX7A (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 1 Aug 2022 19:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiHAX67 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Aug 2022 19:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B2B224BF4
        for <linux-wpan@vger.kernel.org>; Mon,  1 Aug 2022 16:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659398337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LM5x9879Wci4vC1mMK72JhyNI4ToAQ+rR4Qkc1H6vrM=;
        b=QltNzYTEbdTC5jYheXi5IXRx6oDjzA6X2yp/YXAOTKyhld3PRuCcQZUnk1/5EHzltX/CZD
        uRKVm92eXcIR2xxXckAT516pE9dQH5213dTXNKGPlydDha8UYstz66TCAGJAk40ErZOxJC
        RQvvwgu/pK2Gh5KII8GDE8Mj4HC5gqE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-KMMct62JMmW6fcd1xIOaKQ-1; Mon, 01 Aug 2022 19:58:56 -0400
X-MC-Unique: KMMct62JMmW6fcd1xIOaKQ-1
Received: by mail-qv1-f69.google.com with SMTP id m11-20020a0cfbab000000b004738181b474so7289454qvp.6
        for <linux-wpan@vger.kernel.org>; Mon, 01 Aug 2022 16:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LM5x9879Wci4vC1mMK72JhyNI4ToAQ+rR4Qkc1H6vrM=;
        b=cvtOUFOC46EDPCOF4SxZDMfGWtxc8eyxMs/FE58a7pD767kc/np06Ym1q8s7ueWv1r
         hBj9SuexVuxWX4GTp+iv/yAjeZv2FDnlXDJNTWPxssKsQtmriaP97ERyHxLmdX0UUxP7
         CwcVtEm4oEAAm070dNd3KMToyIpDZlgD6RdX8+yjDFnHQ6mk0g4ZIsdzI7SO4EYi4NiE
         E62ByHNnCd7ANp4EmfSuekQ14of/C+g+lTLixcQSJJx9VDHzex9gtrHSZvix1Lwy6Aia
         XGm/YQ7InOevL9gvh6LoujyRj7p+j4DVqQ8sQv2eOgC+JSmyuhttU6ML6ltlG4Nhf6/C
         6SpQ==
X-Gm-Message-State: AJIora/6/ZMG5nzOhiObDZo08RBmmaAbLXm91kCkhboMk/zZqSPb5QdJ
        RbCcGZIlrVAixz+0+PNW2qFCCo8ObWg4WKM3kiw6/UeUg0mDRqS9KcLoE5AetmRS4kxXm/UHKGN
        8CHuyFCZ32J6lk3iEqYw0LqndMIezTrpsPThsPg==
X-Received: by 2002:a05:620a:f13:b0:6b5:b956:c1f1 with SMTP id v19-20020a05620a0f1300b006b5b956c1f1mr13619142qkl.691.1659398336089;
        Mon, 01 Aug 2022 16:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uwknMVCKK6fhQJ3HEKR/Q6ywXFxRKc3gpLKeGLUpQ8cJQ9k0W02GLw8ag2ZG/XgjbZxW741+o9tjS/l2Gu4jo=
X-Received: by 2002:a05:620a:f13:b0:6b5:b956:c1f1 with SMTP id
 v19-20020a05620a0f1300b006b5b956c1f1mr13619135qkl.691.1659398335923; Mon, 01
 Aug 2022 16:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220701143052.1267509-20-miquel.raynal@bootlin.com> <CAK-6q+ihSui2ra188kt9W5CT0HPfJgHoOJfsMS_XDLfVvoQJTg@mail.gmail.com>
In-Reply-To: <CAK-6q+ihSui2ra188kt9W5CT0HPfJgHoOJfsMS_XDLfVvoQJTg@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 1 Aug 2022 19:58:45 -0400
Message-ID: <CAK-6q+j+xv+KwyN1M-uNy-G4y9uqQLU9Z8kDRF9bSs3w0VmTBA@mail.gmail.com>
Subject: Re: [PATCH wpan-next 19/20] ieee802154: hwsim: Do not check the rtnl
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Jul 5, 2022 at 9:23 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Fri, Jul 1, 2022 at 10:37 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > There is no need to ensure the rtnl is locked when changing a driver's
> > channel. This cause issues when scanning and this is the only driver
> > relying on it. Just drop this dependency because it does not seem
> > legitimate.
> >
>
> switching channels relies on changing pib attributes, pib attributes
> are protected by rtnl. If you experience issues here then it's
> probably because you do something wrong. All drivers assuming here
> that rtnl lock is held.

especially this change could end in invalid free. Maybe we can solve
this problem in a different way, what exactly is the problem by
helding rtnl lock?

- Alex

