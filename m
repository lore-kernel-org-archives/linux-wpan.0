Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807D5C61DA3
	for <linux-wpan@archiver.kernel.org>; Tue, 21 Feb 2023 02:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjBUCz7 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Feb 2023 21:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjBUCz6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Feb 2023 21:55:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA910252
        for <linux-wpan@vger.kernel.org>; Mon, 20 Feb 2023 18:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676948096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZZXwnWcWt/UqCQd2wPxJt9pbcp+rBDX0N6vKR8yWb8I=;
        b=SqjKt/LilP7+fCrpwh/W3HCqkcs5Fyi0piNiASxU5U+mAIPvrLrVHnzPQA3cc/lV/K6wTs
        m1rj5A9+u/E0PHteE6Iz9E+jMSq0S3r0GjeWkbrrQCEcnoL12JrSuxxyAyKC6OOi1ikI+B
        gspuJ9GIF9PqDnt11MMAv4KdK3Es0Xc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-iAqlWrSaMMyxW64ojkxquw-1; Mon, 20 Feb 2023 21:54:54 -0500
X-MC-Unique: iAqlWrSaMMyxW64ojkxquw-1
Received: by mail-ed1-f72.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so3672361edc.9
        for <linux-wpan@vger.kernel.org>; Mon, 20 Feb 2023 18:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZXwnWcWt/UqCQd2wPxJt9pbcp+rBDX0N6vKR8yWb8I=;
        b=NYAutVBVkKHYz418cyTqqdazjilhTlV/UjgnaI6Z7hTDcFIeysSv9E38WlZgbt0c/Y
         wJxoFqS8qiQFdilgpaPX4RHtLfdIbWWbHvqPXuyc6V6iqKQQynHMYL9cpkylsrw6lfJ1
         3gOvTqVbev96uops4tisNxQTi8d1Y5Y5XVT00E8SKqIalGo1SdnaT/JwGktVVPFgNCrb
         wWkMc7A0sxBeOXqzM+/CXQLgdk1kP4vPp4PKwDxMRTpeVSdJDyCq7KSKWHgxt/LXjPqd
         C5f4y3R6sy2xsoZ5539DBYsmbr27yKwZFEGDVX6cdRMFmGCXVQC6pzXQMDxdhvyFOKO2
         uSnA==
X-Gm-Message-State: AO0yUKW2dqZRcFXEdDsmRzRyutFO8mDDPgh+8JV9K0i484NVzFnOiMjP
        Vk+VcDhkLGpTPsK3Srq5OXT5tFjMi9oTvdwapwAAgKVEN8GBCJnLWmU4MhW5Z435GF9I5wFwyeR
        Cz9cSIIPiaISbcqNMg5K15fDuwZ6Za6wwNz1Hlw==
X-Received: by 2002:a17:906:dfe8:b0:895:58be:963 with SMTP id lc8-20020a170906dfe800b0089558be0963mr5368607ejc.3.1676948093837;
        Mon, 20 Feb 2023 18:54:53 -0800 (PST)
X-Google-Smtp-Source: AK7set88KxwpA9gydRis/BiZbejUno3rh09A31cVnYVLaxYPFmUsB7WIUC+GDYtbExPBCfKK/yy26ahkKOBX7bospSI=
X-Received: by 2002:a17:906:dfe8:b0:895:58be:963 with SMTP id
 lc8-20020a170906dfe800b0089558be0963mr5368595ejc.3.1676948093629; Mon, 20 Feb
 2023 18:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20221129160046.538864-1-miquel.raynal@bootlin.com>
 <20221129160046.538864-2-miquel.raynal@bootlin.com> <CAK-6q+iwqVx+6qQ-ctynykdrbN+SHxzk91gQCSdYCUD-FornZA@mail.gmail.com>
 <20230206101235.0371da87@xps-13> <CAK-6q+jav4yJD3MsOssyBobg1zGqKC5sm-xCRYX1SCkH9GhmHw@mail.gmail.com>
 <20230210182129.77c1084d@xps-13> <CAK-6q+jLKo1bLBie_xYZyZdyjNB_M8JvxDfr77RQAY9WYcQY8w@mail.gmail.com>
 <20230213111553.0dcce5c2@xps-13> <CAK-6q+jP55MaB-_ZbRHKESgEb-AW+kN3bU2SMWMtkozvoyfAwA@mail.gmail.com>
 <20230214152849.5c3d196b@xps-13> <CAK-6q+i-QiDpFptFPwDv05mwURGVHzmABcEn2z2L9xakQwgw+w@mail.gmail.com>
 <20230217095251.59c324d0@xps-13>
In-Reply-To: <20230217095251.59c324d0@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 20 Feb 2023 21:54:41 -0500
Message-ID: <CAK-6q+ikVP2eWpT5xRkiJn_JoenmD6D5+xcc2RwwXTfC-zsobw@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/6] ieee802154: Add support for user scanning requests
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Feb 17, 2023 at 3:53 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
...
> >
> > ok, I am curious. Probably it is very driver/device specific but yea,
> > HardMAC needs to at least support what 802.15.4 says, the rest is
> > optional and result in -ENOTSUPP?
>
> TBH this is still a gray area in my mental model. I'm not sure what
> these devices will really offer in terms of interfaces.

ca8210 is one. They use those SAP-commands (MCPS-SAP and MLME-SAP)
which are described by 802.15.4 spec... there is this cfg802154_ops
structure which will redirect netlink to either SoftMAC or HardMAC it
should somehow conform to this...
However I think it should be the minimum functionality inside of this,
there might be a lot of optional things which only SoftMAC supports.
Also nl802154 should be oriented to this.

Are you agreeing here?

- Alex

