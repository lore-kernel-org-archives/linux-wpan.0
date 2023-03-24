Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3F4C6FD1C
	for <linux-wpan@archiver.kernel.org>; Fri, 24 Mar 2023 12:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCXM31 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 24 Mar 2023 08:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCXM3H (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Mar 2023 08:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2818268E
        for <linux-wpan@vger.kernel.org>; Fri, 24 Mar 2023 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679660879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTfNNYCehaWTquK3/uZurL5jVOF9LjsnjoLLjJw6tug=;
        b=ZUzyGwjJruS81778TUcBH47Up28NzeuO2+L+vgirH9O3tk3xTPz7jU34I7+DBe2Ok+3rj8
        PxmigAUN+f0uNud0vYmGq+jSNCODAUt3damQyLh5sa9yVzScsbAzZN4z/gs7xhKdrBWbRZ
        73ZlZv+9fYCq//foCKVn+aOcxpdTa1E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-y-dt0ljbNomkUN6KBMTPFw-1; Fri, 24 Mar 2023 08:27:58 -0400
X-MC-Unique: y-dt0ljbNomkUN6KBMTPFw-1
Received: by mail-ed1-f69.google.com with SMTP id fi8-20020a056402550800b004a26cc7f6cbso2991863edb.4
        for <linux-wpan@vger.kernel.org>; Fri, 24 Mar 2023 05:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679660877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTfNNYCehaWTquK3/uZurL5jVOF9LjsnjoLLjJw6tug=;
        b=bq5vnppmIODCXiP4NI+OSZuRWKY5c963xYq4ISliz9pM+EC2pJcQgnAdvZc2OSW7A4
         KJWk+dyG+mklHAbnEsXNwcQK+5d9WUU7Xu+GisFfuUIVn3wRldQigS4H7hjAyNhI9p4Y
         TUwVqh2AFkLa7sM5tm1ZTtVZl3dUNFEHwuZZrYqrh9f4wFDv5HhqNbNwiBLjfLYAzJA4
         Ip9Poduhh/L19lF6l2yXxdAIQ3frEeiySI+opIQfeB3IAkHxPwjkrvhNMAxW6lIMQMFj
         UM6wlO+E51D43jlLATMc3u3w1bZws9Osmu55yG6wjDrYkTVFeyW5wBh4a3FwIUooy8B5
         tUew==
X-Gm-Message-State: AAQBX9cMJl5vRuKI1ZlMNGv+siXW0qm8X7fuquMslPb9Z8lzvPhsRp7J
        WPMt2Yqs6r3+jzC6Ue5f4sssLnUTxMoll2tKUIKPF7K73F3Z78Mnk6bUoGSgtKv9H4gkY+y4A86
        RTjUjdaT8r/tGHF69FNzE6G30amzjMpgX2UpMwarRP3vB1w==
X-Received: by 2002:a17:906:3118:b0:92f:fc27:8ea0 with SMTP id 24-20020a170906311800b0092ffc278ea0mr1291261ejx.9.1679660877201;
        Fri, 24 Mar 2023 05:27:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z6rwT9/pIMmvbgwPggpK3yBQ8axBXbbYE47vwztizUPFF/6EQtQwN5GFQPu9XJSWnHKb6+z6sfm8i39aByxiU=
X-Received: by 2002:a17:906:3118:b0:92f:fc27:8ea0 with SMTP id
 24-20020a170906311800b0092ffc278ea0mr1291251ejx.9.1679660876977; Fri, 24 Mar
 2023 05:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
 <CAK-6q+iw6V5qDCux0E4xE3wMuCc1u8tc26kzwQFyHbMcyFr4iQ@mail.gmail.com> <20230324105737.0fb0f39f@xps-13>
In-Reply-To: <20230324105737.0fb0f39f@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 24 Mar 2023 08:27:45 -0400
Message-ID: <CAK-6q+i8-PcFDX52jXrL1KoKA_Q53m08V2TyQ+=6yFCxTcM=fw@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/4] ieee802154: Active scan support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Mar 24, 2023 at 5:57=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi,
>
> aahringo@redhat.com wrote on Thu, 23 Mar 2023 08:58:43 -0400:
>
> > Hi,
> >
> > On Fri, Mar 10, 2023 at 10:12=E2=80=AFAM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hello,
> > > Following the initial support for passive scan and beaconing, here is=
 an
> > > addition to support active scans.
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > Acked-by: Alexander Aring <aahringo@redhat.com>
> >
> > but I need to admit those are more scan mechanism related work and I
> > trust Miquel he does the right thing, because he is actually more into
> > this topic as me and worked previously on it.
> > For me, I do not see anything that will break something e.g.
> > overwriting framebuffer/dealing with frame filter levels and I am
> > pretty sure Miquel already knows to take care of it.
>
> I agree with the fact that the risk is rather low on this one. Now
> coming:
> - Handling of limited devices (ca8210)
> - Associations/dis-associations (+ additional care to avoid confusing
>   the devices)
>

ok. Thanks for the update.

- Alex

