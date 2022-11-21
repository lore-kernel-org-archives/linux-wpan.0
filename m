Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79769C433FE
	for <linux-wpan@archiver.kernel.org>; Mon, 21 Nov 2022 01:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKUBCY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 20 Nov 2022 20:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiKUBCW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 20 Nov 2022 20:02:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3B2BB00
        for <linux-wpan@vger.kernel.org>; Sun, 20 Nov 2022 17:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668992485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rXsfTFQRDnhK+uagajXB8h99nAVFJiQ0wRyOTdCGKlM=;
        b=M2Kbfio3yF7NpMWlZDOq5DePIM0TFAao3o5kHq/6aSVIL3kW8taFugn5O2WgISM0LJ485u
        0mPUkRvNqca5Z5Iqz1e2mSx2SrYJYwLyDaDR9+RLRdvR5GKQYu8Ydtf5l03aUk+pFODYGQ
        1dASN5/q/q8aUxf+JtBMJGCPSiQ0oFk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-SGfXo9fuN5qkwrWGXP4SHA-1; Sun, 20 Nov 2022 20:01:23 -0500
X-MC-Unique: SGfXo9fuN5qkwrWGXP4SHA-1
Received: by mail-ed1-f71.google.com with SMTP id z15-20020a05640240cf00b00461b253c220so5675004edb.3
        for <linux-wpan@vger.kernel.org>; Sun, 20 Nov 2022 17:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXsfTFQRDnhK+uagajXB8h99nAVFJiQ0wRyOTdCGKlM=;
        b=iY7+U1/4FhV5N3vl5jTAWk0il+bs4hYX5DmxGJIkOr2ODx/WlwcM2Bv1InhSzeJTP2
         /1jSAQPJ/LLZKx1N7x6CzYuJSQQUdxgVgZz44m3vuCB4ZcTgNzJr4oQgdctJ8G5TtsTf
         SeXeVzKS2Uf8aInOY0IKIYHRTKOd+LVtiz5J1akPCeBYFdgQSd3DtyNWZfoTo/Cv7fl5
         PcWV0kyAoilIaQdIDf5B7c9QCSRKro3jzV6coNc8Gr2IZCp/ukOHOoCSb+i1u3aJ2ls/
         WD323j1eaMBNWmnNMb0eDi/o553YoBg01wxsssJwRuGgLDMUFyfor4ObN7BFymHRvKUf
         XJ9Q==
X-Gm-Message-State: ANoB5plTMLIdrqjHS/lzm7dapAhPMYjPBfVXNd1+fDIeqOjEbzhekNlQ
        fMPJXMkzLRVuS6nb+TmEXEAY8y7vjHzg15/8GY9tYv5WIJAbNByku7ukzakgp9TRD5iJqAI2Jpj
        4PhI+Y4j2Bl7cpMyeFBCKjJul2xOSKaiLGs+XPw==
X-Received: by 2002:a17:906:830d:b0:79e:5ea1:4f83 with SMTP id j13-20020a170906830d00b0079e5ea14f83mr175744ejx.372.1668992482522;
        Sun, 20 Nov 2022 17:01:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf42QYppf5NH1cqt0xyVFjIxmUaf+Lq0MxOv2aowlRXTyyHPvBMJhl9UHdaWtC1Y4EQUcRT4eJ5mOZxuU+7iW1Y=
X-Received: by 2002:a17:906:830d:b0:79e:5ea1:4f83 with SMTP id
 j13-20020a170906830d00b0079e5ea14f83mr175738ejx.372.1668992482393; Sun, 20
 Nov 2022 17:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20221102151915.1007815-1-miquel.raynal@bootlin.com>
 <20221102151915.1007815-2-miquel.raynal@bootlin.com> <CAK-6q+iSzRyDDiNusXiRWvUsS5dSS5bSzAtNjSLTt6kgaxtbHg@mail.gmail.com>
 <20221118230443.2e5ba612@xps-13> <CAK-6q+jJKoFy359_Pd4_d+EfqLw4PTdG4F7H4u+URD=UKu9k6w@mail.gmail.com>
In-Reply-To: <CAK-6q+jJKoFy359_Pd4_d+EfqLw4PTdG4F7H4u+URD=UKu9k6w@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 20 Nov 2022 20:01:11 -0500
Message-ID: <CAK-6q+j_NOL0Q4MU4XOawx-54112Qdq1pKRVue8Ea13ScPDk3w@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/3] ieee802154: Advertize coordinators discovery
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sun, Nov 20, 2022 at 7:57 PM Alexander Aring <aahringo@redhat.com> wrote:
...
> >
> > Yes this is how it is working, you only see PANs on one preamble at a
> > time. That's why we need to tell on which preamble we received the
> > beacon.
> >
>
> But then I don't know how you want to change the preamble while
> scanning? I know there are registers for changing the preamble and I
> thought that is a vendor specific option. However I am not an expert
> to judge if it's needed or not, but somehow curious how it's working.
>
> NOTE: that the preamble is so far I know (and makes sense for me)
> _always_ filtered on PHY side.

*I hope we are talking here about the same preamble.

- Alex

