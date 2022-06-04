Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F959C43334
	for <linux-wpan@archiver.kernel.org>; Sat,  4 Jun 2022 02:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiFDCB4 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 3 Jun 2022 22:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiFDCBy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Jun 2022 22:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8974BBA0
        for <linux-wpan@vger.kernel.org>; Fri,  3 Jun 2022 19:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654308111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P5Z6sqMniESbIA5jCZ/sWFr4MxGC2e9xfA7pFQrjpdE=;
        b=BW6xFY1TTzMB5+cNDGgSishkETZnAgsl2V/wMD82EO2h94hZJX4fU954rNsNqqgbtqo8gE
        LGD3lw5MVx8zjTZ/UXjQiNCSWQ8lq1F7qTkox5Ik6TrfLHeKGmNrVmLYNu2fYeXIsWMhre
        bak4uKti9yMClYxiDTYNt1O4kqsUgx8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-lgd5qWTMMzK-7FC5im6V8A-1; Fri, 03 Jun 2022 22:01:50 -0400
X-MC-Unique: lgd5qWTMMzK-7FC5im6V8A-1
Received: by mail-qt1-f199.google.com with SMTP id s36-20020a05622a1aa400b00304b8f28352so7143307qtc.23
        for <linux-wpan@vger.kernel.org>; Fri, 03 Jun 2022 19:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5Z6sqMniESbIA5jCZ/sWFr4MxGC2e9xfA7pFQrjpdE=;
        b=CI7Dupya8hj/SxEXHqhEXiqTLr6U1aL1vjtm4TTHIUkgGFdv7l+62QcXB6xe9nGvYz
         cdfGkHMDiWObjT8SZ7OOe/ivh/1BFcCUHvtglWiXkuJD2uLYjwZ7CrZMHEaPP1pVC2Vx
         7rN2TZqc8ggmp0yKr7QF9i3SACpUvRPuve3ohZgwh2CZ3IxKAHKzbXW6TmzU4iJ15uZy
         CNo9fU9Mt9ytVCICDS2vtm6/1etr+uI/1uOBqpMAlh0oU/rO1eIxmiq2uybXRrjKlJoy
         DvzGj1Uq/ABbmvUNJ7zS8uKgknrVuHAfOiTLRF4FtnWP9RsPtFK8AoPq6qrbLqQVotj4
         s7IQ==
X-Gm-Message-State: AOAM5308ezNUlTjCDa5MgLA466ahYToyBEg+mNbg5pjy3mScBsDqNtEQ
        obQwVWAVi0wDUSfZhL68nAR4WjkUZo6OnjmZGys6yHJqhQXoVoCR3sQGLzOgUXCSADh0WzZ4z9R
        DJw1nyDrqwgkuyQxzMpxUBy8DIu85dmOGeDi/PQ==
X-Received: by 2002:a05:620a:24d1:b0:6a5:99e2:6247 with SMTP id m17-20020a05620a24d100b006a599e26247mr8668808qkn.691.1654308109591;
        Fri, 03 Jun 2022 19:01:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2iy1DM9FV4x370xPca3Rg9fz0NUJGv3a/wqv1A9jVGXtyYlLK468ILY6CWDmgVL+ONfpSjZ48GpzSnx0Hls8=
X-Received: by 2002:a05:620a:24d1:b0:6a5:99e2:6247 with SMTP id
 m17-20020a05620a24d100b006a599e26247mr8668794qkn.691.1654308109395; Fri, 03
 Jun 2022 19:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220603182143.692576-1-miquel.raynal@bootlin.com> <20220603182143.692576-2-miquel.raynal@bootlin.com>
In-Reply-To: <20220603182143.692576-2-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 3 Jun 2022 22:01:38 -0400
Message-ID: <CAK-6q+hAZMqsN=S9uWAm4rTN+uZwz7_L42=emPHz7+MvfW6ZpQ@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/6] net: ieee802154: Drop coordinator interface type
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
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

On Fri, Jun 3, 2022 at 2:34 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> The current enum is wrong. A device can either be an RFD, an RFD-RX, an
> RFD-TX or an FFD. If it is an FFD, it can also be a coordinator. While
> defining a node type might make sense from a strict software point of
> view, opposing node and coordinator seems meaningless in the ieee
> 802.15.4 world. As this enumeration is not used anywhere, let's just
> drop it. We will in a second time add a new "node type" enumeration
> which apply only to nodes, and does differentiates the type of devices
> mentioned above.
>

First you cannot say if this is not used anywhere else. Second I have
a different opinion here that you cannot just "switch" the role from
RFD, FFD, whatever.
You are mixing things here with "role in the network" and what the
transceiver capability (RFD, FFD) is, which are two different things.

You should use those defines and the user needs to create a new
interface type and probably have a different extended address to act
as a coordinator.

- Alex

